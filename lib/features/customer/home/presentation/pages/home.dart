import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/customer/home/presentation/widgets/item_jasa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();

    final pages = [
      Container(
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
                    authCubit.credentials['name'],
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
              bottom: 375,
              left: 16,
              child: Text(
                'Jasa Yang Ditawarkan',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 24,
              right: 24,
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                children: const [
                  ItemJasa(src: 'ac.png', title: 'Service AC'),
                  ItemJasa(src: 'cat_body.png', title: 'Cat Full Body'),
                  ItemJasa(src: 'tune_up.png', title: 'Tune Up'),
                  ItemJasa(src: 'kampas.png', title: 'Service Kampas'),
                  ItemJasa(src: 'poles.png', title: 'Poles'),
                  ItemJasa(src: 'cat_panel.png', title: 'Cat Panel'),
                  ItemJasa(src: 'modif.png', title: 'Modifikasi'),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
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
              child: Align(
                alignment: const Alignment(0, -.6),
                child: Text(
                  'Daftar Transaksi',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                spreadRadius: 1,
                color: Colors.black.withOpacity(.25),
              ),
            ],
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          height: 640,
          child: Column(
            children: [
              Text(
                'Profil',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                authCubit.credentials['name'],
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => authCubit.authLogout(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: color.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => setState(() => currentPage = value),
        children: pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(.25),
            ),
          ],
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        height: 60,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: currentPage,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: 'Utama',
              selectedIcon: Icon(
                Icons.home,
                color: color.primary,
                size: 28,
              ),
            ),
            NavigationDestination(
              icon: const Icon(CupertinoIcons.news_solid),
              label: 'Transaksi',
              selectedIcon: Icon(
                CupertinoIcons.news_solid,
                color: color.primary,
                size: 28,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: 'Profil',
              selectedIcon: Icon(
                Icons.person,
                color: color.primary,
                size: 28,
              ),
            ),
          ],
          onDestinationSelected: (value) {
            pageController.jumpToPage(value);
            setState(() => currentPage = value);
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

