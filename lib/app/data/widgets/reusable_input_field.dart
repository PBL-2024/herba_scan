import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableInputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;

  const ReusableInputField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      enabled: enabled,
      contentPadding: const EdgeInsets.all(0),
      subtitle: TextFormField(
        controller: controller,
        validator: validator,
        enabled: enabled,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
