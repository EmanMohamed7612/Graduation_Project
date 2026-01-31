import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;
  final String otpCode;

  ResetPasswordView({super.key, required this.email, required this.otpCode});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF3E2723)),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitialState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password Reset Successfully! Login now."), backgroundColor: Colors.green),
            );
            // الرجوع لصفحة اللوجين
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(color: Color(0xFF3E2723), fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your new password.',
                  style: TextStyle(color: Color(0xFF8D6E63), fontSize: 16),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? 'Password too short' : null,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (val) => val != passwordController.text ? 'Passwords do not match' : null,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return state is AuthLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().resetPassword(
                            email: email,
                            otp: otpCode,
                            newPassword: passwordController.text.trim(),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6D4C41),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}