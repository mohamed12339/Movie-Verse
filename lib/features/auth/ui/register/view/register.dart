import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/validation.dart';
import 'package:project_movie_app/features/auth/ui/auth_text_field/auth_text_field.dart';

import '../../../../../core/app_routes.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/styles/dialog_utils.dart';
import '../../../../../core/widget/language_toggle.dart';
import '../../../../network/model/request/register_request/register_request.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterCubit viewModel = getIt();
  int selectedAvatar = 0;
  final PageController _pageController = PageController(viewportFraction: 0.4);

  final List<String> avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int movieId = 15;
    return BlocListener<RegisterCubit, RegisterState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state.registerApi.hasData) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, AppRoutes.movieDetails(movieId));
        } else if (state.registerApi.hasError) {
          Navigator.pop(context);
          showError(
            context,
            title: "Error",
            content: state.registerApi.myError.message,
            posButtonTitle: "Ok",
          );
        } else if (state.registerApi.isLoading) {
          showLoading(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.black12,
        appBar: AppBar(
          backgroundColor: AppColors.black12,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.yellowF6),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Register".tr(), style: AppStyles.gold16Regular),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Avatars
                  SizedBox(
                    height: 161,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: avatars.length,
                      onPageChanged: (index) {
                        setState(() {
                          selectedAvatar = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final bool isSelected = index == selectedAvatar;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                selectedAvatar = index;
                              });
                            },
                            child: Transform.scale(
                              scale: isSelected ? 1.2 : .8,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage(avatars[index]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 9),

                  Text("Avatar".tr(), style: AppStyles.white16Regular),

                  const SizedBox(height: 12),

                  AuthTextField(
                    hintText: "Name".tr(),
                    prefixIcon: Icons.person,
                    controller: nameController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Name is required"
                        : null,
                  ),
                  const SizedBox(height: 24),

                  AuthTextField(
                    hintText: "Email".tr(),
                    prefixIcon: Icons.email,
                    controller: emailController,
                    validator: Validation.validateEmail,
                  ),
                  const SizedBox(height: 24),

                  AuthTextField(
                    hintText: "Password".tr(),
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                    validator: Validation.validatePassword,
                  ),
                  const SizedBox(height: 24),

                  AuthTextField(
                    hintText: "Confirm Password".tr(),
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    controller: confirmPasswordController,
                    validator: (value) => Validation.validateRePassword(
                      value,
                      passwordController.text,
                    ),
                  ),
                  const SizedBox(height: 24),

                  AuthTextField(
                    hintText: "Phone Number".tr(),
                    prefixIcon: Icons.phone,
                    controller: phoneController,
                    validator: Validation.validatePhone,
                  ),
                  const SizedBox(height: 24),

                  // Create Account button
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
                        if (_formKey.currentState?.validate() ?? false) {
                          final request = RegisterRequest(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            phone: phoneController.text,
                            avaterId: selectedAvatar + 1,
                          );

                          viewModel.register(request);
                        }
                      },
                      child: Text(
                        "Create Account".tr(),
                        style: AppStyles.black20regular,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17.67),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have Account ?".tr(),
                        style: AppStyles.white14Regular,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login".tr(),
                          style: AppStyles.gold14Regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.25),

                  ///////////////
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
