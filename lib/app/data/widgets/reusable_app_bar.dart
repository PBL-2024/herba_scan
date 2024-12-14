import 'package:flutter/material.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? backgroundColor;
  final Function()? onPressed;
  final double height;

  const ReusableAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.backgroundColor = Colors.white,
    required this.onPressed,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      title: title ?? Image.asset('assets/images/logo-text.png', height: 35),
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(Colors.green),
            ),
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
            ),
            onPressed: onPressed,
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
