import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/auth/presentation/view/loginview.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_button.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImageAuth(
                  image: 'assets/images/forget_password.png',
                  height: MediaQuery.of(context).size.height * .25,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: heightScreen * .035,
                    left: widthScreen * .035,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            // SizedBox(height: heightScreen * .03),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthScreen * .07,
                vertical: heightScreen * .03,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 24,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * .01),
                  Text(
                    "No worries! Enter your email address and we'll send you a link to reset your password.",
                    style: TextStyle(
                      color: const Color(0xFF8D6E63),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  SizedBox(height: heightScreen * .03),
                  CustomText(text: 'Email Adderss'),
                  CustomFormTextField(hintText: 'Enter your email address',controller: TextEditingController(),
                  icon:Icons.lock_outline),
                  SizedBox(height: heightScreen * .09),
                  CustomButton(
                    opacity: .5,
                    buttonText: 'Send Reset Link',
                    onTap: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember your password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF8D6E63),
                          fontSize: 13.5,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                      SizedBox(width: widthScreen * .03),
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
                          'Back to Login',
                          style: TextStyle(
                            color: const Color(0xFF6D4C41),
                            fontSize: 13.5,
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
    );
  }
}
