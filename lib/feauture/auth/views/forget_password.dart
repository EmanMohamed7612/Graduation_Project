import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';


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
               Container(
                      height: heightScreen * .2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Container-5.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                 _buildLabel('Email Address'),
                  _buildTextField(
                    hintText: 'Enter your email address',
                    controller: TextEditingController(),
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: heightScreen * .09),
                  GestureDetector(
      onTap: (){},
      child: Opacity(
        opacity:.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment(0.50, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
              
            ),
          ),
          width: widthScreen,
          height:heightScreen * .05,
          child: Center(
            child: Text(
              'Send Reset Link',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
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
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 12),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}