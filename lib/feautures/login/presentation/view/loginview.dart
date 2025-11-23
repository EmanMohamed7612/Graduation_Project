import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/sign_up_view.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/button.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                image: 'assets/images/Container-3.png',
                height: MediaQuery.of(context).size.height * .25,
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
                      'Welcome Back',
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
                      'Sign in to continue crafting',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: heightScreen * .03),

                    CustomText(text: 'Email Address'),
                    CustomFormTextField(hintText: 'Enter your email'),
                    CustomText(text: 'Password'),
                    CustomFormTextField(
                      hintText: 'Enrer your password',
                      obscureText: true,
                    ),
                    Align(
                      alignment: AlignmentGeometry.topRight,
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFFC9A875),
                          fontSize: 14,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ),

                    SizedBox(height: heightScreen * .08),
                    Button(
                      buttonText: 'Login',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                       
                          print("Form is valid");
                        } else {
                          
                          print("Form not valid");
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.5,
                              color: const Color(0xFFD7CCC8),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .05,
                        child: Center(
                          child: Text(
                            'Continue Guest',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF6D4C41),
                              fontSize: 18,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 13,
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
                                  return SignUpView();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
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
