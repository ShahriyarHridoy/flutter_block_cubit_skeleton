// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_dialog.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
// import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/presentation/screen/profile_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/presentation/cubit/update_profile_cubit.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  ProfileResponse? profileData;

  EditProfilePage({super.key, this.profileData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);

        updateProfileRequest.dateOfBirth =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
      fullName: "", phone: "", dateOfBirth: "", address: "");

  callUpdateProfile() async {
    await BlocProvider.of<UpdateProfileCubit>(context)
        .updateProfile(updateProfileRequest);
  }

  String name = "";

  saveName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('name', name);
  }

  @override
  void initState() {
    super.initState();

    _nameController =
        TextEditingController(text: widget.profileData?.data!.fullName);
    _emailController =
        TextEditingController(text: widget.profileData?.data!.email);
    _dobController =
        TextEditingController(text: widget.profileData?.data!.dateOfBirth);
    _phoneController =
        TextEditingController(text: widget.profileData?.data!.phone);
    _addressController =
        TextEditingController(text: widget.profileData?.data!.address);

    updateProfileRequest.fullName =
        widget.profileData!.data!.fullName.toString();
    updateProfileRequest.dateOfBirth =
        widget.profileData!.data!.dateOfBirth.toString();
    updateProfileRequest.phone = widget.profileData!.data!.phone.toString();
    updateProfileRequest.address = widget.profileData!.data!.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateProfileLoading) {
          showAppLoading(context);
          // Navigator.pop(context);
        } else if (state is UpdateProfileFailure) {
          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is UpdateProfileSuccess) {
          final responseModel = state.model;
          log(json.encode(responseModel));
          name = responseModel.data!.fullName.toString();
          saveName();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));

          MotionToast.success(
            // title: Text("Login Successful"),
            description: const Text("Profile edited successfully"),
            position: MotionToastPosition.center,
            toastDuration: const Duration(seconds: 4),
          ).show(context);

          // if (responseModel.code == 200) {
          // Navigator.pushNamed(context, RouteName.profile);
          // }
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: const AssetImage('assets/images/pp.jpg'),
                    backgroundColor: Colors
                        .transparent, // Set background color to transparent
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/pp.jpg',
                        fit: BoxFit
                            .cover, // Adjust the fit based on your requirement
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      updateProfileRequest.fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // updateProfileRequest.fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Email regex pattern
                      String pattern =
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      updateProfileRequest.phone = value;
                    },
                    validator: (value) {
                      if (RegExp(
                              r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$")
                          .hasMatch(value!)) {
                        return null;
                      } else {
                        return 'invalid mobile number';
                      }
                      // if (value!.isEmpty) {
                      //   return 'Please enter your phone number';
                      // }
                      // return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      updateProfileRequest.dateOfBirth = value;
                    },
                    onTap: () => _selectDate(context),
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      updateProfileRequest.address = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the updated profile information
                        // Implement your logic here
                        callUpdateProfile();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
