import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final String buttonName;

  final VoidCallback? onPressed;

  final bool isDisabled;

  const CommonButton(
      {super.key, required this.buttonName, this.onPressed, this.isDisabled = false});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.isDisabled
            ? const Color(0xff6B959F).withOpacity(0.5)
            : const Color(0xff6B959F),
      ),
      child: MaterialButton(
        onPressed: widget.isDisabled ? null : widget.onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text(
          widget.buttonName,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
