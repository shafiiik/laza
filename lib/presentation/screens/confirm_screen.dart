import 'package:flutter/material.dart';
import 'package:laza/core/constants/app_colors.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/presentation/routes/app_routes.dart';
import 'package:laza/presentation/widgets/bottom_button.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
          title: AppStrings.continueShopping),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AssetsPath.confirmPage,
                width: double.infinity,
              ),
              Text(
                AppStrings.orderConfirmed,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: AppColors.title),
              ),
              Text(
                AppStrings.confirmMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.fontDisabled),
              )
            ],
          ),
        ),
      ),
    );
  }
}
