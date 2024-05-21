import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_dialog.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_widget.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart'; // import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../forgot_password/check_otp/presentation/cubit/check_otp_cubit.dart';
import '../../../sign_up/data/model/sign_up_response.dart';
import '../../data/model/otp_validate_request.dart';

class OtpValidate extends StatefulWidget {
  const OtpValidate({Key? key}) : super(key: key);

  @override
  State<OtpValidate> createState() => OtpValidateScreenState();
}

OtpValidateRequest otpValidateRequest = OtpValidateRequest(email: "", otp: 0);

class OtpValidateScreenState extends State<OtpValidate> {
  bool isLangBangla = false;

  String accessToken = "";
  String refreshToken = "";
  String name = "";
  String email = "";
  late SignUpResponse signUpResponse;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //response = ModalRoute.of(context)!.settings.arguments as SignUpResponse;
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is SignUpResponse) {
      signUpResponse = args;
    } else {
      // Handle the case where args is null or not of type SignUpResponse
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // final args = ModalRoute.of(context)!.settings.arguments;
    // if (args != null && args is SignUpResponse) {
    //   signUpResponse = args;
    // } else {
    //   // Handle the case where args is null or not of type SignUpResponse
    // }
    // getCurrencyIcon == null ?? "";
    super.initState();
  }

  saveAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accessToken', accessToken);
  }

  saveRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('refreshToken', refreshToken);
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

  final _formKey = GlobalKey<FormState>();
  int otpValue = 0;

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
      if (signUpResponse.data?.otp == otpValue) {
        debugPrint("In Success");
        log("in success Response: ${json.encode(signUpResponse)}");

        accessToken = signUpResponse.data!.accessToken!;
        refreshToken = signUpResponse.data!.refreshToken!;
        name = signUpResponse.data!.fullName!;
        email = signUpResponse.data!.email!;
        saveAccessToken();
        saveRefreshToken();
        saveName();
        saveEmail();

        log("access tocken: $accessToken");
        log("refreshToken : $refreshToken");
        log("name: $name");
        log("email: $email");

        Navigator.pushNamed(context, RouteName.dashboard);
        AppWidgets()
            .showSuccessSnackbar(context, message: "Registration Successful");
        // MotionToast.success(
        //   // title: Text("Success"),
        //   description: const Text("Registration Successful"),
        //   position: MotionToastPosition.center,
        //   toastDuration: const Duration(seconds: 3),
        // ).show(context);
      }
      // await BlocProvider.of<OtpValidateCubit>(context)
      //     .otpValidate(otpValidateRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
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
          // final responseModel = state.model;
          // debugPrint("In Success");
          // log("in success Response: ${json.encode(responseModel)}");
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
              "Validate OTP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            Text(
              "otp is - ${signUpResponse.data?.otp}",
              style: TextStyle(color: Colors.black12),
            ),
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
                otpValue = int.parse(verificationCode);
                //otpValidateRequest.otp = int.parse(verificationCode);
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
