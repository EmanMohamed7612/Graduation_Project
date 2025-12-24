import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_craftoria/feautures/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:project_craftoria/feautures/auth/presentation/view/sign_up_view.dart';

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
        home: SignUpView(),
      ),
    );
  }
}

