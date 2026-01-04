import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_craftoria/feautures/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:project_craftoria/feautures/auth/presentation/view/sign_up_view.dart';

import 'feautures/descripe_persone/view/descripe_persone.dart';
import 'feautures/splash_onboarding/presentation/view/splash_view.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(),
      child: const CratoriaApp(),
    ),
  );
}
class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (_) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEFEBE9),
          textTheme: GoogleFonts.arimoTextTheme(),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF3E2723),
            secondary: Color(0xFF8D6E63),
          ),
        ),

        home: SplashView(),
      ),
    );
  }
}

