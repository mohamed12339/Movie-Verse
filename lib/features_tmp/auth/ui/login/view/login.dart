import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/di/di.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/styles/dialog_utils.dart';
import 'package:project_movie_app/core/widget/validation.dart';
import 'package:project_movie_app/features_tmp/auth/ui/auth_text_field/auth_text_field.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/cubit/login_cubit.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/cubit/login_state.dart';

import '../../../../../core/widget/language_toggle.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int movieId = 15;
  LoginCubit viewModel = getIt();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();   /// دا مهم جدا دا الي بتسخدموا مع ال validation بتاع ال  textFromField وعشان يظهرللك الحاجة الحمرة دية الي بيقولك باسورد المفروض يتكتب كدا وهكزا

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state.loginApi.hasData) {
          Navigator.pop(context);

          Navigator.pushReplacement(context, AppRoutes.navigationTabs);
        } else if (state.loginApi.hasError) {
          Navigator.pop(context);
          showError(
            context,
            title: "Error",
            content: state.loginApi.myError.message,
            posButtonTitle: "Ok",
          );
        } else if (state.loginApi.isLoading) {
          showLoading(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.black12,
        body: Form(
          key: formKey, /// وانو يكون معايا variable اسمو formkey هوا دا الي هيا check
          autovalidateMode: AutovalidateMode.always, /// دية لو عايز وانتا بتكتب يقعد يقول الصح وانتا بتكتب الايميل والباسورد في غير always حاجات كتير وانتا اختار
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 69),
                  Image(image: AssetImage(AppAssets.logo)),
                  SizedBox(height: 69),

                  // Email field
                  AuthTextField(
                    hintText: "Email".tr(),
                    prefixIcon: Icons.email,
                    controller: emailController,
                    validator: Validation.validateEmail,
                  ),
                  const SizedBox(height: 22.4),
                  // Password field
                  AuthTextField(
                    hintText: "Password".tr(),
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                    validator: Validation.validatePassword,
                  ),

                  // Forget password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password ?".tr(),
                        style: TextStyle(color: AppColors.yellowF6),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowF6,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        viewModel.login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: Text("Login".tr(), style: AppStyles.black20regular),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Create account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t Have Account ?".tr(),
                        style: AppStyles.white14Regular,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, AppRoutes.register);
                        },
                        child: Text(
                          "Create One".tr(),
                          style: AppStyles.gold14Regular,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // OR separator
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.yellowF6,
                          thickness: 1,
                          indent: 80,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OR".tr(),
                          style: TextStyle(color: AppColors.yellowF6),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.yellowF6,
                          thickness: 1,
                          endIndent: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Google login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowF6,
                        foregroundColor: AppColors.black28,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      onPressed: () {
                        viewModel.loginWithGoogle();
                      },
                      label: Text(
                        "Login With Google".tr(),
                        style: AppStyles.black16Regular,
                      ),
                    ),
                  ),

                  SizedBox(height: 33.6),

                  ////////////////////////////
                  LanguageToggle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
