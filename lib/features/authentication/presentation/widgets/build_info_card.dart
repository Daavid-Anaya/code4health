import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/text_styles.dart';

class BuildInfoCard extends StatelessWidget {
  final String title;
  final Widget content;

  const BuildInfoCard(BuildContext context, {
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.subEncabezado(context)),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}