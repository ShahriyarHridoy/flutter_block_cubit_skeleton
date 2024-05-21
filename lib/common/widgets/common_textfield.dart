// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_block_cubit_skeleton/core/utils/lang/app_localizations.dart';
// import 'package:flutter_block_cubit_skeleton/core/utils/value.dart';

// Color _iconColor = const Color(0xFFB8BDB6);

// class CommonTextField extends StatefulWidget {
//   final String hintText;
//   final String? labelText;
//   final String validateMessage;
//   final TextEditingController? textEditingController;
//   final Function(String)? onChange;
//   final Function(String)? validator;
//   final bool obscureText;
//   final bool needObscureText;
//   final String validatorValue;
//   final int? maxLength;
//   final bool readOnly;
//   final int? minLines;
//   final int? maxLines;
//   TextInputType? textInputType;
//   FocusNode? focusNode;
//   VoidCallback? onEditingComplete;
//   TextInputAction? textInputAction;

//   final String? errorText;
//   CommonTextField({
//     required this.hintText,
//     this.labelText,
//     this.validateMessage = "",
//     this.textEditingController,
//     this.validator,
//     this.onChange,
//     this.obscureText = false,
//     required this.needObscureText,
//     this.validatorValue = "",
//     this.maxLength,
//     this.readOnly = false,
//     this.minLines,
//     this.maxLines = 1,
//     this.textInputType,
//     this.focusNode,
//     this.onEditingComplete,
//     this.textInputAction,
//     this.errorText,
//   });
//   @override
//   State<CommonTextField> createState() => _CommonTextFieldState();
// }

// bool obsecureText = true;

// class _CommonTextFieldState extends State<CommonTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           textInputAction: widget.textInputAction,
//           maxLines: widget.maxLines,
//           minLines: widget.minLines,
//           onEditingComplete: widget.onEditingComplete,
//           focusNode: widget.focusNode,
//           readOnly: widget.readOnly,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           controller: widget.textEditingController,
//           maxLength: widget.maxLength,
//           keyboardType: widget.textInputType,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return widget.validateMessage;
//             }

//             if (value != "") {
//               if (widget.validatorValue.toLowerCase() == "email") {
//                 var abc = EmailValidator.validate(value);
//                 if (abc == false) {
//                   return AppLocalizations.of(context)
//                       .translate("sign_up_emailvalid");
//                 }
//               } else if (widget.validatorValue.toLowerCase() == "mobile") {
//                 if (RegExp(r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$")
//                     .hasMatch(value)) {
//                   return null;
//                 } else {
//                   return AppLocalizations.of(context)
//                       .translate("sign_up_mobvalid");
//                 }
//               } else if (widget.validatorValue.toLowerCase() == "repassword") {
//                 if (passwordController.text != confirmPasswordController.text) {
//                   return "Password don't match";
//                 } else if (value.length < 6) {
//                   return "Must have to 6 character";
//                 }
//               } else if (widget.validatorValue.toLowerCase() == "nid") {
//                 if (value.isEmpty) {
//                   return AppLocalizations.of(context).translate("nid_required");
//                 } else if (!RegexRes.kNidNumber.hasMatch(value)) {
//                   return AppLocalizations.of(context).translate("nid_invalid");
//                 } else {
//                   return null;
//                 }
//               } else if (widget.validatorValue.toLowerCase() ==
//                   "changepassword") {
//                 if (value.length < 6) {
//                   return "Must have to 6 character";
//                 } else if (changeNewPasswordController.text !=
//                     changeConfirmPasswordController.text) {
//                   return "Password don't match";
//                 }
//               } else {
//                 return null;
//               }
//             }
//             return null;
//           },
//           onChanged: (value) {
//             if (widget.onChange != null) {
//               widget.onChange!(value);
//             }
//           },
//           obscureText: widget.obscureText && obsecureText,
//           decoration: InputDecoration(
//             suffixIcon: widget.needObscureText
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         obsecureText = !obsecureText;
//                       });
//                     },
//                     icon: obsecureText
//                         ? Icon(
//                             Icons.visibility_off,
//                             color: _iconColor,
//                           )
//                         : Icon(Icons.visibility, color: _iconColor))
//                 : SizedBox(),
//             filled: true,
//             hintText: AppLocalizations.of(context).translate(widget.hintText),
//             labelText:
//                 AppLocalizations.of(context).translate(widget.labelText!),
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             focusedBorder: Values.enabledBorder,
//             errorBorder: Values.errorBorder,
//             focusedErrorBorder: Values.focusedErrorBorder,
//           ),
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             AppLocalizations.of(context).translate(widget.errorText ?? ''),
//             style: const TextStyle(
//               color: Colors.red,
//               fontWeight: FontWeight.w500,
//               fontSize: 10,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
