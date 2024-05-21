import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_dialog.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => ResetPasswordScreenState();
}

TextEditingController passwordController = TextEditingController();

TextEditingController confirmPasswordController = TextEditingController();
TextEditingController nidController = TextEditingController();
TextEditingController dobController = TextEditingController(text: null);
ResetPasswordRequest resetPasswordRequest =
    ResetPasswordRequest(email: "", otp: 0, password: "");

class ResetPasswordScreenState extends State<ResetPassword> {
  bool isLangBangla = false;

  String name = "";
  String email = "";
  String accessToken = "";

  saveAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accessToken', accessToken);
  }

  saveName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('name', name);
  }

  saveEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('email', email);
  }

  // DistrictListRequest districtList = DistrictListRequest(divisionOid: "");
  // ThanaListRequest thanaList = ThanaListRequest(districtOid: '');
  // HubListRequest hubList = HubListRequest(thanaOid: '');

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // PickedFile? _photo;
  // DateTime _dob = DateTime.now();
  // Future<void> _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: source);
  //   setState(() {
  //     _photo = pickedImage;
  //   });
  // }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<ResetPasswordCubit>(context)
          .resetPassword(resetPasswordRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          debugPrint("In ResetPasswordLoading");

          showAppLoading(context);
        } else if (state is ResetPasswordFailure) {
          debugPrint("In ResetPasswordFailure");

          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is ResetPasswordSuccess) {
          final responseModel = state.model;
          debugPrint("In Success");
          log("in success Response: ${json.encode(responseModel)}");
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SignIn()));
          // accessToken = responseModel.accessToken!;
          // name = responseModel.fullName!;
          // email = responseModel.email!;
          // saveAccessToken();
          // saveName();
          // saveEmail();

          // log("access tocken: $accessToken");
          // log("name: $name");
          // log("email: $email");

          Navigator.pushNamed(context, RouteName.signin);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: _buildBody(context),
        // drawer: const Drawer(),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 16.0),
            const Text(
              "Reset Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
              onChanged: (value) {
                resetPasswordRequest.password = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Reset Password'),
            ),
          ]),
        ),
      ),
    );
  }
}
