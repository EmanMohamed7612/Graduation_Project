import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/splash_onboarding/presentation/view/splash_view.dart';

void main() {
  runApp(const CratoriaApp());
}

class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
