import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/login/presentation/view/loginview.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/button.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomImageAuth(
                image: 'assets/images/Container-4.png',
                height: MediaQuery.of(context).size.height * .2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widthScreen * .07,
                  vertical: heightScreen * .03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 22,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w700,
                        // height: 1.33,
                      ),
                    ),
                    SizedBox(height: heightScreen * .01),
                    Text(
                      'Join the handmade community',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: heightScreen * .03),
                    CustomText(text: 'Full Name'),
                    CustomFormTextField(hintText: 'Enter your full name'),
                    CustomText(text: 'Email Address'),
                    CustomFormTextField(hintText: 'Enter your email'),
                    CustomText(text: 'Password'),
                    CustomFormTextField(
                      hintText: 'Enrer your password',
                      obscureText: true,
                    ),
                    CustomText(text: 'Confirm Password'),
                    CustomFormTextField(hintText: 'Enrer your password'),
                    SizedBox(height: heightScreen * .06),
                    Button(
                      buttonText: 'Sign Up',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          
                          print("Form is valid");
                        } else {
                      
                          print("Form not valid");
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 12.25,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginView();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: const Color(0xFF6D4C41),
                              fontSize: 12.25,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
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
  }
}
