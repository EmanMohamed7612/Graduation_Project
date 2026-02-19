import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/feauture/language_screens/presentation/view/widget/continue_button.dart';
import 'package:graduation2/feauture/language_screens/presentation/view/widget/language_card.dart';
import 'package:graduation2/feauture/language_screens/presentation/view/widget/language_icon.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1EE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: height * 0.20),

                const LanguageIcon(),

                const SizedBox(height: 24),

                const Text(
                  "Choose Your Language",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5C4033),
                  ),
                ),

                SizedBox(height: height * 0.004),

                const Text(
                  "Select your preferred language",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0XFF8D6E63),
                  ),
                ),

                 SizedBox(height: height * 0.05),

                LanguageCard(
                  isSelected: selectedIndex == 0,
                  imagePath: "assets/images/En.png",
                  title: "English",
                  subtitle: "International Language",
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),

                 SizedBox(height: height * 0.01),

                LanguageCard(
                  isSelected: selectedIndex == 1,
                  imagePath: "assets/images/🇪🇬.png",
                  title: "العربية",
                  subtitle: "اللغة العربية - مصر",
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),

                SizedBox(height: height * 0.06),

                const ContinueButton(),

                SizedBox(height: height * 0.2),

                const Text(
                  "You can change this later in Settings",
style: TextStyle(color: Color(0XFFA1887F)),
                ),

                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
