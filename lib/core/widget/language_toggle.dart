import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return AnimatedToggleSwitch<String>.size(
      current: currentLang,
      values: const ["en", "ar"],
      indicatorSize: const Size.fromWidth(55),
      borderWidth: 3.0,
      iconOpacity: 1.0,
      selectedIconScale: 1.2,
      style: ToggleStyle(
        backgroundColor: AppColors.black12,
        indicatorColor: AppColors.yellowF6,
        borderColor: AppColors.yellowF6,
        borderRadius: BorderRadius.circular(30),
      ),
      iconBuilder: (value) {
        return Image.asset(
          value == "en" ? AppAssets.icUs : AppAssets.icEgypt,
          width: 28,
          height: 28,
        );
      },
      onChanged: (value) {
        context.setLocale(Locale(value));
      },
    );
  }
}
