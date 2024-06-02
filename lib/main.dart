import 'core/constants_finals.dart';
import 'core/routes.dart';
import 'features/invoice/presentation/cubit/barang_cubit.dart';
import 'features/invoice/presentation/cubit/invoice_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/queue/presentation/cubit/queue_cubit.dart';
import 'injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection();
  final prefs = locator<SharedPreferences>();
  final String? token = prefs.getString('token');

  runApp(MyApp(route: token != null ? homePage : loginPage));
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
        BlocProvider(create: (context) => QueueCubit()),
      ],
      child: MaterialApp(
        title: 'Bengkel Pak Bowo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF375DFF),
            secondary: const Color(0xFFFFEE00),
            outline: const Color(0xFF6C6C6C),
          ),
          useMaterial3: true,
        ),
        initialRoute: route,
        routes: Routes.generateRoute,
      ),
    );
  }
}
