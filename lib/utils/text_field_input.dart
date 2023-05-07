import 'package:flutter/material.dart';

// make utils of textfieldinput
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEdittingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.textEdittingController,
    this.isPass = false,
    // default setting is false.
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    // refactoring : repeating code
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEdittingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
