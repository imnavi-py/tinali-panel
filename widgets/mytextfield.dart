import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  myTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.type,
      required this.errorText,
      required this.prefixicon,
      this.onchanged,
      this.readonly = false});
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final String errorText;
  final Icon prefixicon;
  final bool readonly;
  Function(String)? onchanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
      onChanged: onchanged,
      keyboardType: type,
      decoration: InputDecoration(
          prefixIcon: prefixicon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 27, 7, 99))),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintTextDirection: TextDirection.rtl),
    );
  }
}
