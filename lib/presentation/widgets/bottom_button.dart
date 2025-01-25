import 'package:flutter/material.dart';
import 'package:laza/core/constants/app_colors.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        color: AppColors.button,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: AppColors.background),
        )),
      ),
    );
  }
}
