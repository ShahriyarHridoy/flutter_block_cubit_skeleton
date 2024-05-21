import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // import 'package:image_picker/image_picker.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_dialog.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpScreenState();
}

TextEditingController passwordController = TextEditingController();

TextEditingController confirmPasswordController = TextEditingController();

class SignUpScreenState extends State<SignUp> {
  SignUpRequest signUpRequest =
      SignUpRequest(fullName: "", email: "", password: "");
  bool isLangBangla = false;

  String accessToken = "";
  String refreshToken = "";
  String name = "";
  String email = "";

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
      await BlocProvider.of<SignUpCubit>(context).signUp(signUpRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          debugPrint("In SignUpLoading");

          showAppLoading(context);
        } else if (state is SignUpFailure) {
          debugPrint("In SignUpFailure");

          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is SignUpSuccess) {
          final responseModel = state.model;
          // debugPrint("In Success");
          // log("in success Response: ${json.encode(responseModel)}");
          //
          // accessToken = responseModel.data!.accessToken!;
          // refreshToken = responseModel.data!.refreshToken!;
          // name = responseModel.data!.fullName!;
          // email = responseModel.data!.email!;
          // saveAccessToken();
          // saveRefreshToken();
          // saveName();
          // saveEmail();
          //
          // log("access tocken: $accessToken");
          // log("refreshToken : $refreshToken");
          // log("name: $name");
          // log("email: $email");
          Navigator.pushNamed(context, RouteName.otpValidate,
              arguments: responseModel);
          // Navigator.pushNamed(context, RouteName.dashboard);
          // MotionToast.success(
          //   // title: Text("Success"),
          //   description: const Text("Registration Successful"),
          //   position: MotionToastPosition.center,
          //   toastDuration: const Duration(seconds: 3),
          // ).show(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text("Sign Up")),
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onChanged: (value) {
                signUpRequest.fullName = value;
              },
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
                signUpRequest.email = value;
              },
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
                // Password regex pattern
                // Check for three consecutive identical characters
                if (RegExp(r'(.)\1\1').hasMatch(value)) {
                  return 'Avoid 3 consecutive identical characters';
                }

                // Check for at least one alphanumeric or special character
                if (!RegExp(r'[!@#$%^&*()_+=\-~|]').hasMatch(value)) {
                  return 'Include at least one special character';
                }

                return null;
              },
              onChanged: (value) {
                signUpRequest.password = value;
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
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Sign Up'),
            ),
          ]),
        ),
      ),
    );
  }
}
