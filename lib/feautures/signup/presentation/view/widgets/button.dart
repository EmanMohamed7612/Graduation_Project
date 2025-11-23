import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
          ),
        ),
        width: size.width,
        height: size.height * .05,
        child: Center(
          child: Text(
            buttonText,
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
    );
  }
}
