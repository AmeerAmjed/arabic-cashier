import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String labelText;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  const Input({
    Key? key,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo[700]!),
    );
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        autofocus: false,
        controller: controller,
        validator: validator,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: textInputType,
        textInputAction: textInputAction,
      ),
    );
  }
}
