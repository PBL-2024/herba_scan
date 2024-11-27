import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/Themes.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const ReusableButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: buttonStyle ?? ElevatedButton.styleFrom(
          backgroundColor: Themes.buttonColor,
          fixedSize: const Size(double.infinity, 50),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                textAlign: TextAlign.center,
                text,
                style: textStyle ??
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
              ),
      ),
    );
  }
}
