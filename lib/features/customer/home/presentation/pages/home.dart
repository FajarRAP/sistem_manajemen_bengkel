import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/customer/home/presentation/widgets/item_jasa.dart';
import 'package:bengkel_pak_bowo/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();
    final token = locator<SharedPreferences>().getString('token');
    if (token != null) {
      authCubit.credentials = JwtDecoder.decode(token);
    }

    return Scaffold(
      body: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                color: color.primary,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    authCubit.credentials['name'] ?? 'Default',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 170,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: const Offset(0, 1),
                        color: Colors.black.withOpacity(.1)),
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                        color: Colors.black.withOpacity(.09)),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 28),
                height: 210,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Ambil Antrianmu',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Gap(12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: color.primary,
                          ),
                          child: Text(
                            'Ambil',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Gap(40),
                      Row(
                        children: [
                          Text(
                            'Antrian saat ini :',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Gap(10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: color.primary,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.timer,
                                    color: Colors.white),
                                const Gap(12),
                                Text(
                                  '9',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 400,
              left: 16,
              child: Text(
                'Jasa Yang Ditawarkan',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Positioned(
              bottom: 185,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemJasa(src: 'ac.png', title: 'Service AC'),
                      ItemJasa(src: 'cat_body.png', title: 'Cat Full Body'),
                      ItemJasa(src: 'tune_up.png', title: 'Tune Up'),
                      ItemJasa(src: 'kampas.png', title: 'Service Kampas'),
                    ],
                  ),
                  Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemJasa(src: 'poles.png', title: 'Poles'),
                      ItemJasa(src: 'cat_panel.png', title: 'Cat Panel'),
                      ItemJasa(src: 'modif.png', title: 'Modifikasi'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
