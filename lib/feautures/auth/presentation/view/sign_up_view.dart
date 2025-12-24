import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_craftoria/feautures/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:project_craftoria/feautures/auth/presentation/view/loginview.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_button.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

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

  final String role = 'Beginner';
  final String gender = "Female"; // أو خليها اختيارية لاحقًا

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
     // FocusScope.of(context).unfocus(); // إخفاء الكيبورد

      await BlocProvider.of<AuthCubit>(context).register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPassController.text,
        role: role,
        gender: gender,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إنشاء الحساب بنجاح!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  LoginView()),
          );
        } else if (state is SignFailureState) {
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
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomImageAuth(
                    image: 'assets/images/Container-4.png',
                    height: heightScreen * .2,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthScreen * .07,
                      vertical: heightScreen * .03,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Color(0xFF3E2723),
                            fontSize: 22,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: heightScreen * .01),
                        const Text(
                          'Join the handmade community',
                          style: TextStyle(
                            color: Color(0xFF8D6E63),
                            fontSize: 14,
                            fontFamily: 'Arimo',
                          ),
                        ),
                        SizedBox(height: heightScreen * .03),

                        // First Name
                        const CustomText(text: 'First Name'),
                        CustomFormTextField(
                          hintText: 'Enter your First name',
                          controller: firstNameController,
                          icon: Icons.person_2_outlined,
                          validator: (value) =>
                              value!.isEmpty ? "First name is required" : null,
                        ),

                        // Last Name
                        const CustomText(text: 'Last Name'),
                        CustomFormTextField(
                          hintText: 'Enter your Last name',
                          controller: lastNameController,
                          icon: Icons.person_2_outlined,
                          validator: (value) =>
                              value!.isEmpty ? "Last name is required" : null,
                        ),

                        // Email
                        const CustomText(text: 'Email Address'),
                        CustomFormTextField(
                          hintText: 'Enter your email',
                          controller: emailController,
                          icon: Icons.email_outlined,
                        
                          validator: (value) {
                            if (value!.isEmpty) return 'Email is required';
                            if (!value.contains('@')) return 'Invalid email';
                            return null;
                          },
                        ),

                        // Password
                        const CustomText(text: 'Password'),
                        CustomFormTextField(
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                          icon: Icons.lock_outline,
                          validator: (value) {
                            if (value!.isEmpty) return 'Password is required';
                            if (value.length < 6) return 'Password must be at least 6 characters';
                            if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Must contain uppercase letter';
                            if (!RegExp(r'[a-z]').hasMatch(value)) return 'Must contain lowercase letter';
                            if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Must contain a symbol';
                            return null;
                          },
                        ),

                        // Confirm Password
                        const CustomText(text: 'Confirm Password'),
                        CustomFormTextField(
                          hintText: 'Confirm your password',
                          controller: confirmPassController,
                          obscureText: true,
                          icon: Icons.lock_outline,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please confirm your password';
                            if (value != passwordController.text) return "Passwords do not match";
                            return null;
                          },
                        ),

                        SizedBox(height: heightScreen * .04),

                        // زر التسجيل مع الـ Loading
                        if (state is SignLoadingState)
                          const Column(
                            children: [
                              CircularProgressIndicator(color: Color(0xFF6D4C41)),
                              SizedBox(height: 16),
                              Text(
                                "جاري إنشاء الحساب...",
                                style: TextStyle(color: Color(0xFF6D4C41), fontSize: 16),
                              ),
                            ],
                          )
                        else
                          CustomButton(
                            buttonText: 'Sign Up',
                            onTap: _submitForm,
                          ),

                        SizedBox(height: heightScreen * .03),

                        // Already have an account?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: Color(0xFF8D6E63), fontSize: 12.5),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) =>  LoginView()),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF6D4C41),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
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
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_craftoria/feautures/auth/presentation/manager/cubit/auth_cubit.dart';

// import 'package:project_craftoria/feautures/auth/presentation/view/loginview.dart';
// import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_button.dart';
// import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';
// import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text.dart';
// import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text_field.dart';

// class SignUpView extends StatefulWidget {
//   SignUpView({super.key});

//   @override
//   State<SignUpView> createState() => _SignUpViewState();
// }

// class _SignUpViewState extends State<SignUpView> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();

//   final firstNameController = TextEditingController();

//   final lastNameController = TextEditingController();

//   final passwordController = TextEditingController();

//   final confirmPasscontroller = TextEditingController();

//   final String role = 'Beginner';
//   @override
//   void dispose() {
//     emailController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     passwordController.dispose();
//     confirmPasscontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;

//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is SignSuccessState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Registerayion Successfully')),
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => LoginView()),
//           );
//           print("LLLLLLLLLLLLLLLLL");
//         } else if (state is SignFailureState) {
//           print("fdigjidgggggggggggg");
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: const Color(0xffFAF8F5),
//           body: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   CustomImageAuth(
//                     image: 'assets/images/Container-4.png',
//                     height: MediaQuery.of(context).size.height * .2,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: widthScreen * .07,
//                       vertical: heightScreen * .03,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Create Account',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color:  Color(0xFF3E2723),
//                             fontSize: 22,
//                             fontFamily: 'Arimo',
//                             fontWeight: FontWeight.w700,
//                             // height: 1.33,
//                           ),
//                         ),
//                         SizedBox(height: heightScreen * .01),
//                         const Text(
//                           'Join the handmade community',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: const Color(0xFF8D6E63),
//                             fontSize: 14,
//                             fontFamily: 'Arimo',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(height: heightScreen * .025),
//                         const CustomText(text: 'First Name'),
//                         CustomFormTextField(
//                           hintText: 'Enter your First name',
//                           controller: firstNameController,
//                           icon: Icons.person_2_outlined,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "First name is required";
//                             }
//                             return null;
//                           },
//                         ),
//                         const CustomText(text: 'Last Name'),
//                         CustomFormTextField(
//                           hintText: 'Enter your Last name',
//                           controller: lastNameController,
//                           icon: Icons.person_2_outlined,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Last name is required";
//                             }
//                             return null;
//                           },
//                         ),
//                         const CustomText(text: 'Email Address'),
//                         CustomFormTextField(
//                           hintText: 'Enter your email',
//                           controller: emailController,
//                           icon: Icons.email_outlined,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Email is required';
//                             }
//                             if (!value.contains('@')) return 'Invalid email';
//                             return null;
//                           },
//                         ),
//                         const CustomText(text: 'Password'),
//                         CustomFormTextField(
//                           hintText: 'Enrer your password',
//                           controller: passwordController,
//                           obscureText: true,
//                           icon: Icons.lock_outline,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Password is required';
//                             }

//                             if (value.length < 6) {
//                               return 'Password must be at least 6 characters';
//                             }

//                             // يحتوي على حرف كابيتل
//                             if (!value.contains(RegExp(r'[A-Z]'))) {
//                               return 'Password must contain at least one uppercase letter';
//                             }

//                             // يحتوي على حرف small
//                             if (!value.contains(RegExp(r'[a-z]'))) {
//                               return 'Password must contain at least one lowercase letter';
//                             }

//                             // يحتوي على رمز
//                             if (!value.contains(
//                               RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
//                             )) {
//                               return 'Password must contain at least one symbol';
//                             }

//                             return null;
//                           },
//                         ),
//                         const CustomText(text: 'Confirm Password'),
//                         CustomFormTextField(
//                           hintText: 'Enrer your password',
//                           controller: confirmPasscontroller,
//                           icon: Icons.lock_outline,
//                           obscureText: true,
//                           validator: (value) {
//                             if (value == null || value.isEmpty)
//                              { return 'Confirm your password';}
//                             if (value != passwordController.text)
//                                {return "Passwords do not match";}
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: heightScreen * .03),
//                         CustomButton(
//                           buttonText: 'Sign Up',
//                           onTap: _submitForm,
//                           // () {
//                           //   if (_formKey.currentState!.validate()) {
//                           //     BlocProvider.of<AuthCubit>(context).register(
//                           //       firstName: firstNameController.text,
//                           //       lastName: lastNameController.text,
//                           //       email: emailController.text,
//                           //       password: passwordController.text,
//                           //       confirmPassword: confirmPasscontroller.text,
//                           //       role: role,
//                           //       gender: "Female",
//                           //     );
//                           //     print('fffffffffffffffffffffff');
//                           //   }
//                           // },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Already have an account? ',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: const Color(0xFF8D6E63),
//                                 fontSize: 12.25,
//                                 fontFamily: 'Arimo',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) {
//                                       return LoginView();
//                                     },
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   color: const Color(0xFF6D4C41),
//                                   fontSize: 12.25,
//                                   fontFamily: 'Arimo',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       FocusScope.of(context).unfocus(); // يخفي الكيبورد
//       await BlocProvider.of<AuthCubit>(context).register(
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         email: emailController.text,
//         password: passwordController.text,
//         confirmPassword: confirmPasscontroller.text,
//         role: role,
//         gender: "Female",
//       );
//       print('ffffffffffffffffff');
//     }
//   }
// }
