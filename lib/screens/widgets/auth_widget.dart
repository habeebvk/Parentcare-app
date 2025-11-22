import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final Function(String) onChanged;

  const AuthField({
    super.key,
    required this.hint,
    this.isPassword = false,
    required this.onChanged, required TextStyle hintStyle, required TextStyle textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
