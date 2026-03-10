import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/manager/auth_state.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/auth/views/uploadfiles.dart';
import 'package:graduation2/feauture/auth/views/success_screen.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/widget/custom_navigationbar.dart';
import 'package:graduation2/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../../core/const/role_const.dart';

class SignUpView extends StatefulWidget {
  final String role;
  final String? email;
  const SignUpView({super.key, required this.role, this.email});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  File? profileImage;
  String? selectedGender;
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  late final String role;

  @override
  void initState() {
    super.initState();
    role = widget.role;
    if (widget.email != null) {
      emailController.text = widget.email!;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0xFF6D4C41)),
            ),
          );
        } else if (state is AuthSuccessState) {
          if (Navigator.canPop(context)) Navigator.pop(context);

          if (role == UserRole.sellerBeginner ||
              role == UserRole.customer ||
              role == UserRole.supplier) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const ExpertSuccessScreen()),
            // );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainWrapper()),
            );
          } else if (role == 'Expert') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.accountcreatedsuccessfully.tr()),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainWrapper()),
            );
          }
        } else if (state is AuthFailureState) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffFAF8F5),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: heightScreen * .2,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Container-4.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthScreen * .07,
                      vertical: heightScreen * .03,
                    ),
                    child: Column(
                      children: [
                        Text(
                          LocaleKeys.completeAccount.tr(),
                          style: TextStyle(
                            color: Color(0xFF3E2723),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: heightScreen * .005),

                        Text(
                          LocaleKeys.jointhehandmadecommunity.tr(),
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: heightScreen * .03),

                        _buildLabel(LocaleKeys.firstname.tr()),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                hintText: LocaleKeys.firstname.tr(),
                                controller: firstNameController,
                                icon: Icons.person_outline,
                                validator: (v) => v!.isEmpty
                                    ? LocaleKeys.required.tr()
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                hintText: LocaleKeys.lastname,
                                controller: lastNameController,
                                icon: Icons.person_outline,
                                validator: (v) => v!.isEmpty
                                    ? LocaleKeys.required.tr()
                                    : null,
                              ),
                            ),
                          ],
                        ),

                        _buildLabel(LocaleKeys.gender.tr()),

                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          hint: Text(
                            LocaleKeys.selectyourgender.tr(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          decoration: _dropdownDecoration(
                            LocaleKeys.selectyourgender.tr(),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          items: [
                              DropdownMenuItem(value: 'male', child: Text(LocaleKeys.mmale.tr())),
                            DropdownMenuItem(value: 'female', child: Text(LocaleKeys.ffemale.tr())),
                          ],
                          onChanged: (value) {
                            setState(() => selectedGender = value);
                          },
                          validator: (v) => v == null ? LocaleKeys.required.tr() : null,
                        ),

                        _buildLabel(LocaleKeys.emailaddress),
                        _buildTextField(
                          hintText: LocaleKeys.enteryouremailtogetstarted.tr(),
                          controller: emailController,
                          icon: Icons.email_outlined,
                          enabled: widget.email == null,
                          validator: (v) =>
                              v!.contains('@') ? null : LocaleKeys.invalid_email.tr(),
                        ),

                        _buildLabel(LocaleKeys.password.tr()),
                        _buildTextField(
                          hintText:LocaleKeys.enteryourpassword.tr(),
                          controller: passwordController,
                          icon: Icons.lock_outline,
                          //  obscureText: true,
                          validator: (v) =>
                              v!.length < 6 ? LocaleKeys.weak_password.tr() : null,
                          obscureText: _isPasswordHidden,
                          isHidden: _isPasswordHidden,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),

                        _buildLabel(LocaleKeys.confirmpassword.tr()),
                        _buildTextField(
                          hintText: LocaleKeys.confirmpassword.tr(),

                          controller: confirmPassController,
                          icon: Icons.lock_outline,

                          //  obscureText: true,
                          validator: (v) =>
                              v != passwordController.text ? LocaleKeys.password_not_match.tr() : null,
                          obscureText: _isConfirmPasswordHidden,
                          isHidden: _isConfirmPasswordHidden,
                          onToggleVisibility: () {
                            setState(() {
                              _isConfirmPasswordHidden =
                                  !_isConfirmPasswordHidden;
                            });
                          },
                        ),

                        SizedBox(height: heightScreen * .04),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6D4C41),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),

                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                List<MultipartFile>? profileImages;
                                if (profileImage != null) {
                                  profileImages = [
                                    await MultipartFile.fromFile(
                                      profileImage!.path,
                                      filename: profileImage!.path
                                          .split('/')
                                          .last,
                                    ),
                                  ];
                                }

                                if (role == UserRole.sellerBeginner ||
                                    role == UserRole.customer ||
                                    role == UserRole.supplier) {
                                  context.read<AuthCubit>().registerWithFiles(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword: confirmPassController.text,
                                    role: role,
                                    gender: selectedGender ?? LocaleKeys.ffemale.tr(),

                                    yearsOfExperience: null,
                                    profileImages: profileImages,
                                  );
                                } else if (role == UserRole.sellerExpert) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ExpertVerificationScreen(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        gender: selectedGender ??  LocaleKeys.ffemale.tr(),
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPassController.text,
                                        profileImage: profileImage,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },

                            child:  Text(
                              LocaleKeys.signup.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              LocaleKeys.already_have_account.tr(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginView();
                                    },
                                  ),
                                );
                              },
                              child:  Text(
                              LocaleKeys.login.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 12),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
    VoidCallback? onToggleVisibility,
    bool? isHidden,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        decoration: _inputDecoration(
          hintText,
          icon,
          isHidden,
          onToggleVisibility,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
    bool? isHidden,
    VoidCallback? onToggleVisibility,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey),
      suffixIcon: isHidden != null
          ? IconButton(
              icon: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            )
          : null,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    );
  }
}

InputDecoration _dropdownDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide.none,
    ),
    suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
  );
}
