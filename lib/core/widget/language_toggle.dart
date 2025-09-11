import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';

class LanguageToggle extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const LanguageToggle({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  late String _currentLang;

  @override
  void initState() {
    super.initState();
    _currentLang = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<String>.size(
      current: _currentLang,
      values: const ["en", "ar"],
      indicatorSize: const Size.fromWidth(55),
      borderWidth: 3.0,
      iconOpacity: 1.0,
      selectedIconScale: 1.5,
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
        setState(() {
          _currentLang = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
