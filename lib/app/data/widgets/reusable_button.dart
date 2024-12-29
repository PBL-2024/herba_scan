import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/themes.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final bool isLoading;
  final double width;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;

  const ReusableButton({
    super.key,
    required this.text,
    this.fontSize = 15,
    required this.onPressed,
    this.width = double.infinity,
    this.isLoading = false,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: buttonStyle ?? ElevatedButton.styleFrom(
          backgroundColor: Themes.buttonColor,
          fixedSize: Size(double.infinity, 40.sp),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                textAlign: TextAlign.center,
                text,
                style: textStyle ??
                    TextStyle(
                      fontSize: fontSize.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
              ),
      ),
    );
  }
}
