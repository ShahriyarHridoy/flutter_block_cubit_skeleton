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
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/presentation/cubit/check_otp_cubit.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/presentation/screen/reset_password.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOtp extends StatefulWidget {
  const CheckOtp({Key? key}) : super(key: key);

  @override
  State<CheckOtp> createState() => CheckOtpScreenState();
}

TextEditingController passwordController = TextEditingController();

TextEditingController confirmPasswordController = TextEditingController();
TextEditingController nidController = TextEditingController();
TextEditingController dobController = TextEditingController(text: null);
CheckOtpRequest checkOtpRequest = CheckOtpRequest(email: "", otp: 0);

class CheckOtpScreenState extends State<CheckOtp> {
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
      await BlocProvider.of<CheckOtpCubit>(context).checkOtp(checkOtpRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckOtpCubit, CheckOtpState>(
      listener: (context, state) {
        if (state is CheckOtpLoading) {
          debugPrint("In CheckOtpLoading");

          showAppLoading(context);
        } else if (state is CheckOtpFailure) {
          debugPrint("In CheckOtpFailure");

          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is CheckOtpSuccess) {
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

          Navigator.pushNamed(context, RouteName.resetPassword);
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
    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.displaySmall?.copyWith(color: color);
    }

    Color accentPurpleColor = const Color(0xFF6A53A1);
    Color primaryColor = const Color(0xFF121212);
    Color accentPinkColor = const Color(0xFFF99BBD);
    Color accentDarkGreenColor = const Color(0xFF115C49);
    Color accentYellowColor = const Color(0xFFFFB612);
    Color accentOrangeColor = const Color(0xFFEA7A3B);

    List<TextStyle?> otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];

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
              "Check OTP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            OtpTextField(
              numberOfFields: 6,
              borderColor: accentPurpleColor,
              focusedBorderColor: accentPurpleColor,
              styles: otpTextStyles,
              showFieldAsBox: false,
              borderWidth: 4.0,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here if necessary
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                checkOtpRequest.otp = int.parse(verificationCode);
                resetPasswordRequest.otp = int.parse(verificationCode);
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ]),
        ),
      ),
    );
  }
}
