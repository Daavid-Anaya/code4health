import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(color: AppColors.backgroundLineasMarcos)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('O', style: TextStyles.parrafo(context)),
        ),
        Expanded(child: Divider(color: AppColors.backgroundLineasMarcos)),
      ],
    );
  }
}