import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza/core/constants/app_colors.dart';

class CustomSvgIconButton extends StatelessWidget {
  const CustomSvgIconButton({
    required this.svgIconPath,
    required this.onPressed,
    super.key,
  });

  final String svgIconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: AppColors.iconButtonBackground,
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Space inside the card
          child: SvgPicture.asset(
            svgIconPath,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
