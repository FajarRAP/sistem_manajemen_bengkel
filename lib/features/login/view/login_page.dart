import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants_finals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: GoogleFonts.roboto(
                fontSize: 16,
              ),
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
                        const TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                        ),
                        const Gap(16),
                        TextField(
                          obscureText: _isObsecure,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure = !_isObsecure),
                              icon: !_isObsecure
                                  ? const Icon(CupertinoIcons.eye_fill)
                                  : const Icon(CupertinoIcons.eye_slash_fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      width: 125,
                      height: 40,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () =>
                              Navigator.pushNamed(context, invoicePage),
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
    );
  }
}
