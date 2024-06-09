import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_error.dart';
import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants_finals.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/form_auth.dart';
import '../widgets/text_field_auth.dart';
import '../widgets/top_section.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final color = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterError) {
          errorSnackBar(context, state.message);
        }

        if (state is RegisterAuthenticated) {
          successSnackBar(context, state.message);
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
                'Register',
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: color.primary),
              ),
              form: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Form Nama
                    TextFieldAuth(controller: nameController, label: 'Nama'),
                    const Gap(12),
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
              forgotPassword: const SizedBox(),
              textButton: Text(
                'Daftar',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              footer: [
                TextSpan(
                  text: 'Sudah Punya Akun? ',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: 'Masuk!',
                  style: GoogleFonts.plusJakartaSans(
                      color: color.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
              goingTo: () => Navigator.pushReplacementNamed(context, loginPage),
              onPressed: () => formKey.currentState!.validate()
                  ? authCubit.authRegister(authCubit.accountData(
                      nameController.text,
                      usernameController.text,
                      passwordController.text))
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
