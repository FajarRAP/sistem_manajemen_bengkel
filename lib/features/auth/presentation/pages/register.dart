import 'package:bengkel_pak_bowo/features/auth/data/models/account.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/widgets/text_field_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants_finals.dart';
import '../../../../injection_container.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.message,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        if (state is RegisterAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade200,
              content: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Seksi Atas
            Stack(
              children: [
                Image.asset('assets/login.png'),
                Positioned(
                  top: 110,
                  left: 20,
                  child: Text(
                    'SELAMAT DATANG',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 20,
                  child: Text(
                    'di Bengkel Bowo!',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            // Seksi Bawah
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Alphaworks
                  Image.asset(
                    'assets/logo-no-bg.png',
                    scale: 2,
                  ),
                  // Teks Daftar
                  Text(
                    'Daftar',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: color.primary),
                  ),
                  const Gap(12),
                  // Form Validasi
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Form Nama
                        TextFieldAuth(
                            controller: nameController,
                            isPassword: false,
                            label: 'Nama'),
                        const Gap(12),
                        // Form Username
                        TextFieldAuth(
                            controller: usernameController,
                            isPassword: false,
                            label: 'Username'),
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
                  const Gap(12),

                  const Gap(36),
                  // Button Masuk
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authCubit.authRegister(AccountModel(
                              name: nameController.text,
                              email: usernameController.text,
                              password: passwordController.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is RegisterAuthenticating) {
                            return const CircularProgressIndicator(
                                color: Colors.white);
                          }
                          return Text(
                            'Daftar',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Gap(18),
                  // Teks Belum Punya Akun
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, loginPage),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sudah Punya Akun? ',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: 'Masuk Di Sini',
                              style: GoogleFonts.plusJakartaSans(
                                  color: color.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
