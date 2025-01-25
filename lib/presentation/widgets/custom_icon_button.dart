import 'package:flutter/material.dart';
import 'package:laza/core/constants/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: AppColors.iconButtonBackground,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          // Space inside the card
          child: Icon(
            icon,
            size: 15,
          ),
        ),
      ),
    );
  }
}
