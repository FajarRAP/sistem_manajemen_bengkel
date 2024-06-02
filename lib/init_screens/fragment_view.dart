import 'package:bengkel_pak_bowo/features/admin/home.dart'
    as admin;
import 'package:bengkel_pak_bowo/features/invoice/presentation/pages/transaction.dart'
    as admin;
import 'package:bengkel_pak_bowo/features/admin/profile.dart'
    as admin;
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/customer/home.dart'
    as cust;
import 'package:bengkel_pak_bowo/features/customer/profile.dart'
    as cust;
import 'package:bengkel_pak_bowo/features/customer/transaction.dart'
    as cust;
import 'package:bengkel_pak_bowo/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragmentPage extends StatefulWidget {
  const FragmentPage({super.key});

  @override
  State<FragmentPage> createState() => _FragmentPageState();
}

class _FragmentPageState extends State<FragmentPage> {
  final pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();
    final token = locator<SharedPreferences>().getString('token');
    if (token != null) {
      authCubit.credentials = JwtDecoder.decode(token);
    }
    final isAdmin = authCubit.credentials['role'] == 1;

    const userPages = [
      cust.HomePage(),
      cust.TransactionPage(),
      cust.ProfilePage(),
    ];
    const adminPages = [
      admin.HomePage(),
      admin.TransactionPage(),
      admin.ProfilePage(),
    ];
    final destinations = [
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
        label: 'Profile',
        selectedIcon: Icon(
          Icons.person,
          color: color.primary,
          size: 28,
        ),
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => setState(() => currentPage = value),
        children: isAdmin ? adminPages : userPages,
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
          destinations: destinations,
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
