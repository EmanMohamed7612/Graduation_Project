import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/widgets/custom_image.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widthScreen * .07,
                vertical: heightScreen * .03,
              ),
              child: Column(
                children: [
                  Container(
                    height: heightScreen * .06,
                    width: widthScreen * .1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, 0.00),
                        end: Alignment(1.00, 1.00),
                        colors: [
                          const Color(0x33C9A874),
                          const Color(0x33A0877E),
                        ],
                      ),
                    ),
                    child: Image.asset('assets/images/Icon (4).svg'),
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
