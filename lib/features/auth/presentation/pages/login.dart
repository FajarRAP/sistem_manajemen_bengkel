import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/snackbar_error.dart';
import '../../../../core/common/widgets/snackbar_success.dart';
import '../../../../core/constants_finals.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/form_auth.dart';
import '../widgets/text_field_auth.dart';
import '../widgets/top_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final color = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          errorSnackBar(context, state.message);
        }

        if (state is LoginAuthenticated) {
          successSnackBar(context, state.message);
          Navigator.pushReplacementNamed(context, homePage);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Seksi Atas
            const TopSection(),

            // Seksi Bawah
            FormAuth(
              title: Text(
                'Login',
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: color.primary),
              ),
              form: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Form Username
                    TextFieldAuth(
                        controller: usernameController, label: 'Username'),
                    const Gap(12),
                    // Form Password
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) => TextFieldAuth(
                            controller: passwordController,
                            isPassword: true,
                            label: 'Password')),
                  ],
                ),
              ),
              
              textButton: Text(
                'Masuk',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              footer: [
                TextSpan(
                  text: 'Belum Punya Akun? ',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'Daftar!',
                  style: GoogleFonts.plusJakartaSans(
                      color: color.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
              goingTo: () =>
                  Navigator.pushReplacementNamed(context, registerPage),
              onPressed: () => formKey.currentState!.validate()
                  ? authCubit.authLogin(authCubit.loginData(
                      usernameController.text, passwordController.text))
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
