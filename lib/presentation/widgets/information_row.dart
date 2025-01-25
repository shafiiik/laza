import 'package:flutter/material.dart';
import 'package:laza/core/constants/app_colors.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    required this.title,
    required this.subTitle,
    super.key,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.fontDisabled,
            fontSize: 15),
      ),
      Spacer(),
      Text(
        subTitle,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: AppColors.title, fontSize: 15),
      ),
    ]);
  }
}
