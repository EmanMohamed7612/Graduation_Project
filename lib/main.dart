import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/views/check_email.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/customer_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/junior_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/customer_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
import 'package:graduation2/feauture/product/view/product_datails.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/write_review.dart';
import 'package:graduation2/feauture/splash_screen/presentation/view/splash.dart';

void main() {
  runApp(const CratoriaApp());
}

class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(ApiService())),
        BlocProvider(
          create: (context) =>
              UserProfileCubit(UserProfileRepo())..fetchProfile(),
        ),
      ],
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
