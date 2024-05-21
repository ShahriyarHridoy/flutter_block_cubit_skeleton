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
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/presentation/screen/check_otp.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/presentation/screen/reset_password.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/presentation/cubit/send_otp_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => SendOtpScreenState();
}

TextEditingController passwordController = TextEditingController();

TextEditingController confirmPasswordController = TextEditingController();
TextEditingController nidController = TextEditingController();
TextEditingController dobController = TextEditingController(text: null);

class SendOtpScreenState extends State<SendOtp> {
  SendOtpRequest sendOtpRequest = SendOtpRequest(email: "");
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
      await BlocProvider.of<SendOtpCubit>(context).sendOtp(sendOtpRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOtpCubit, SendOtpState>(
      listener: (context, state) {
        if (state is SendOtpLoading) {
          debugPrint("In SendOtpLoading");

          showAppLoading(context);
        } else if (state is SendOtpFailure) {
          debugPrint("In SendOtpFailure");

          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is SendOtpSuccess) {
          final responseModel = state.model;
          debugPrint("In Success");
          log("in success Response: ${json.encode(responseModel)}");

          // accessToken = responseModel.accessToken!;
          // name = responseModel.fullName!;
          // email = responseModel.email!;
          // saveAccessToken();
          // saveName();
          // saveEmail();

          // log("access tocken: $accessToken");
          // log("name: $name");
          // log("email: $email");

          Navigator.pushNamed(context, RouteName.checkOtp);
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
              "Send OTP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
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
              onChanged: (value) {
                sendOtpRequest.email = value;
                checkOtpRequest.email = value;
                resetPasswordRequest.email = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Send OTP'),
            ),
          ]),
        ),
      ),
    );
  }
}
