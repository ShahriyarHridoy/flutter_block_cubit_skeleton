import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/common_textfield%20copy.dart';
import 'package:flutter_block_cubit_skeleton/core/utils/lang/app_localizations.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';

class SignInUserInfoFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SignInRequest user;
  final Function(GlobalKey<FormState> key, SignInRequest userData) callback;

  // required void Function(GlobalKey<FormState> key, SignInRequest userData)
  // callback,

  const SignInUserInfoFormWidget({
    Key? key,
    required this.formKey,
    required this.user,
    required this.callback,
  }) : super(key: key);

  @override
  State<SignInUserInfoFormWidget> createState() =>
      _SignInUserInfoFormWidgetState();
}

class _SignInUserInfoFormWidgetState extends State<SignInUserInfoFormWidget> {
  //final SignInRequest user = SignInRequest(email: "", password: "");
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  Timer? _debounce;

  // final _formKey = GlobalKey<FormState>();

  //late SignInRequest user;
  bool isLangBangla = false;

  @override
  void initState() {
    //user = widget.user;
    emailController = TextEditingController();
    pwdController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.callback(widget.formKey, widget.user);
    });
    //widget.callback(widget.formKey, widget.user);
  }

  void _onChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.callback(widget.formKey, widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context).locale.languageCode;
    isLangBangla = s.contains('bn');
    return Container(
        alignment: Alignment.center,
        child: Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  _userIdTextField(),
                  const SizedBox(
                    height: 15,
                  ),
                  _passwordTextField(),
                  const SizedBox(
                    height: 15,
                  ),
                ])));
  }

  Widget _userIdTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // child: CommonTextField(
      //   textEditingController: mobileController,
      //   hintText: "common_mobile_no",
      //   labelText: "common_mobile_no",
      //   needObscureText: false,
      //   validateMessage:
      //       AppLocalizations.of(context).translate("enter_mobile_number"),
      //   // "Enter Mobile Number",
      //   validatorValue: "mobile",
      //   onChange: (value) {
      //     user.userId = value;
      //   },
      // ),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          // Email regex pattern
          String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Invalid email address';
          }
          return null;
        },
        onChanged: (value) {
          widget.user.email = value;
          _onChanged();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   widget.callback(widget.formKey, widget.user);
          // });
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CommonTextField(
        textEditingController: pwdController,
        hintText: "common_password",
        labelText: "common_password",
        needObscureText: true,
        obscureText: true,
        validateMessage:
            AppLocalizations.of(context).translate("enter_password"),
        // "Enter Password",
        validatorValue: "password",
        onChange: (value) {
          widget.user.password = value;
          _onChanged();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   widget.callback(widget.formKey, widget.user);
          // });
        },
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
