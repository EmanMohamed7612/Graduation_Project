import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/splash_screen/presentation/view/splash.dart';

void main() {
  runApp(const CratoriaApp());
}

class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(ApiService()),
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
