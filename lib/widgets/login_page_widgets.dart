import 'package:flutter/material.dart';
import 'package:todo/utils/theme.dart';

class LoginIconButton extends StatelessWidget {
  final iconData;
  final isImage;

  const LoginIconButton({super.key, this.iconData, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: MyCustomTheme.buttonBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: isImage == true ? Image.asset(iconData, height: 22, width: 22) : Icon(iconData),
      ),
    );
  }
}

class BottomButtonNavigation extends StatelessWidget {
  const BottomButtonNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Text(
          'or continue with',
          textAlign: TextAlign.center,
          style: TextStyle(color: MyCustomTheme.textLabeldColor),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 13,
          children: [
            LoginIconButton(iconData: "assets/images/social.png", isImage: true),
            LoginIconButton(iconData: Icons.facebook),
            LoginIconButton(iconData: 'assets/images/apple.png', isImage: true),
          ],
        ),
      ],
    );
  }
}
