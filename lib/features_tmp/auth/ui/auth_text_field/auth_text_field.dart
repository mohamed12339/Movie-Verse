import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.prefixIcon,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true; // الحالة الافتراضية (مخفي)

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,

          decoration: InputDecoration(
            hintStyle: AppStyles.white16Regular,
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.black28,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            // هنا نحط الـ prefixIcon
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.white)
                : null,

            // هنا نحط الـ suffixIcon
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: AppColors.white,
                    ),
                  )
                : null,

            ///هنا بقولوا لو انتا مخفي او مش كات حاجة  اظهر ايكون العين الي عليها شرطة ايلس : ظاهر خلي العين من غير شرطة  وانتا بتدوس عليها
          ),
          style: AppStyles.white16Regular,
        ),
      ],
    );
  }
}
