import 'package:flutter/material.dart';
import '../../../../core/constants/text_styles.dart';

class AuthNavigationLink extends StatelessWidget {
  final String promptText;
  final String linkText;
  final VoidCallback onPressed;

  const AuthNavigationLink({
    super.key,
    required this.promptText,
    required this.linkText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          promptText,
          style: TextStyles.leyenda,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            linkText,
            style: TextStyles.linkLeyenda,
          ),
        ),
      ],
    );
  }
}