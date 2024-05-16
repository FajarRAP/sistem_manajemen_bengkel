import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:bengkel_pak_bowo/core/routes.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/barang_cubit.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection();
  final prefs = locator<SharedPreferences>();
  final String? token = prefs.getString('token');
  final role = JwtDecoder.decode(token ?? '');
  runApp(MyApp(
      route: token != null
          ? role['role'] == 0
              ? homePage
              : invoicePage
          : loginPage));
}

class MyApp extends StatelessWidget {
  final String route;

  const MyApp({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InvoiceCubit()),
        BlocProvider(create: (context) => BarangCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        title: 'Bengkel Pak Bowo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF375DFF),
          ),
          useMaterial3: true,
        ),
        initialRoute: route,
        routes: Routes.generateRoute,
      ),
    );
  }
}
