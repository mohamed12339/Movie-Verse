import 'package:flutter/material.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';

import '../../domain/entities/onboarding_item.dart';

class OnBoardingContent extends StatelessWidget {
  final OnBoardingItem item;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const OnBoardingContent({
    super.key,
    required this.item,
    required this.isLast,
    required this.onNext,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(item.image, fit: BoxFit.fill)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),

            decoration: BoxDecoration(
              color: AppColors.black12,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: AppStyles.white24bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  if (item.description.isNotEmpty)
                    Text(
                      item.description,
                      style: AppStyles.white20regular,
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellowF6,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: onNext,
                    child: Text(
                      isLast ? "Finish" : "Next",
                      style: AppStyles.black20SemiBold,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (onBack != null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.yellowF6, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: onBack,
                        child: Text("Back", style: AppStyles.gold20SemiBold),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
