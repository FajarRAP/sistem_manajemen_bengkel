import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/auth_cubit.dart';

class FormAuth extends StatelessWidget {
  const FormAuth({
    super.key,
    required this.form,
    required this.title,
    required this.textButton,
    required this.footer,
    required this.forgotPassword,
    required this.goingTo,
    required this.onPressed,
  });

  final Widget form;
  final Text title;
  final Text textButton;
  final List<TextSpan> footer;
  final Widget forgotPassword;
  final void Function() goingTo;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 36,
              spreadRadius: 1,
              offset: const Offset(0, -5),
              color: Colors.black.withOpacity(.25)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.infinity,
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Alphaworks
          Image.asset('assets/logo-no-bg.png', scale: 2),
          // Teks Title
          title,
          const Gap(12),
          // Form Validasi
          form,
          const Gap(12),
          // Lupa Password
          forgotPassword,
          const Gap(36),
          // Button Masuk
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is LoginAuthenticating ||
                      state is RegisterAuthenticating) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return textButton;
                },
              ),
            ),
          ),
          const Gap(18),

          // Teks Belum Punya Akun
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: goingTo,
              child: RichText(
                text: TextSpan(
                  children: footer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
