import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  const CustomButton(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.onPressed,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: buttonColor,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              buttonText!,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ))),
      ),
    );
  }
}
