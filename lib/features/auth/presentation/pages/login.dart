import 'package:bengkel_pak_bowo/features/auth/data/models/login_credentials.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final AuthCubit authCubit = context.read<AuthCubit>();
    final color = Theme.of(context).colorScheme;
    final iconPassword = !authCubit.getIsObsecure
        ? Icon(CupertinoIcons.eye_fill, color: color.primary)
        : Icon(CupertinoIcons.eye_slash_fill, color: color.primary);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
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

        if (state is LoginAuthenticated) {
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
          // Navigator.pushNamed(context, invoicePage);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 36,
                    spreadRadius: 1,
                    offset: const Offset(0, -5),
                    color: Colors.black.withOpacity(.25),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo-no-bg.png',
                    scale: 2,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: color.primary,
                    ),
                  ),
                  const Gap(12),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Username'),
                            ),
                            validator: authCubit.validate),
                        const Gap(12),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  label: const Text('Password'),
                                  suffixIcon: IconButton(
                                    onPressed: authCubit.obsecurePassword,
                                    icon: iconPassword,
                                  ),
                                ),
                                obscureText: !authCubit.getIsObsecure,
                                validator: authCubit.validate);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Lupa Password? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Klik Di Sini',
                          style: TextStyle(
                            color: color.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(36),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final LoginCredentials data = LoginCredentials(
                            email: usernameController.text,
                            password: passwordController.text,
                          );
                          authCubit.authLogin(data);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Gap(18),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        print('register');
                      },
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Belum Punya Akun? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Daftar Di Sini',
                              style: TextStyle(
                                color: color.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
