import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/app_routes.dart';
import 'package:project_movie_app/core/assets/app_assets.dart';
import 'package:project_movie_app/core/di/di.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/styles/dialog_utils.dart';
import 'package:project_movie_app/features/auth/ui/auth_text_field/auth_text_field.dart';
import 'package:project_movie_app/features/auth/ui/login/cubit/login_cubit.dart';
import 'package:project_movie_app/features/auth/ui/login/cubit/login_state.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginCubit viewModel = getIt();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state.loginApi.hasData) {
          Navigator.pop(context);

          Navigator.pushReplacement(context, AppRoutes.splash);
        } else if (state.loginApi.hasError) {
          Navigator.pop(context);
          showError(
            context,
            title: "Error",
            content: "${state.loginApi.myError.message}",
            posButtonTitle: "Ok",
          );
        } else if (state.loginApi.isLoading) {
          showLoading(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.black12,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 69),
                Image(image: AssetImage(AppAssets.logo)),
                SizedBox(height: 69),

                // Email field
                AuthTextField(
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 22.4),
                // Password field
                AuthTextField(
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                ),

                // Forget password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password ?",
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
                      //
                      viewModel.login(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    child: Text("Login", style: AppStyles.black20regular),
                  ),
                ),
                const SizedBox(height: 22),

                // Create account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ? ",
                      style: AppStyles.white14Regular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, AppRoutes.register);
                      },
                      child: Text("Create One", style: AppStyles.gold14Regular),
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
                        "OR",
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
                    onPressed: () {},
                    label: Text(
                      "Login With Google",
                      style: AppStyles.black16Regular,
                    ),
                  ),
                ),

                SizedBox(height: 33.6),

                ////////////////////////////
                //todo Language toggle
              ],
            ),
          ),
        ),
      ),
    );
  }
}
