import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/features/auth/data/models/login_credentials.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>();

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
          Navigator.pushNamed(context, invoicePage);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF62C664),
                Color(0xFF62C696),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 50,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'AlphaWorks',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                'Bengkel Pak Bowo',
                style: GoogleFonts.roboto(fontSize: 16),
              ),
              const Gap(35),
              SizedBox(
                width: 300,
                height: 270,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xFF89D98A),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.7),
                            blurRadius: 20,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      width: 300,
                      height: 250,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          const Gap(16),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        authCubit.obsecurePassword(),
                                    icon: authCubit.getIsObsecure
                                        ? const Icon(CupertinoIcons.eye_fill)
                                        : const Icon(
                                            CupertinoIcons.eye_slash_fill),
                                  ),
                                ),
                                obscureText: authCubit.getIsObsecure,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 125,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            final LoginCredentials data = LoginCredentials(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            authCubit.authLogin(data);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            splashFactory: InkRipple.splashFactory,
                          ),
                          child: Center(
                            child: BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is LoginAuthenticating) {
                                  return const CircularProgressIndicator();
                                }
                                return Text(
                                  'Login',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
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
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
