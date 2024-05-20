import 'package:bengkel_pak_bowo/features/admin/transaction/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/admin/transaction/data/repositories/invoice_repositories_impl.dart';
import 'package:bengkel_pak_bowo/features/auth/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

Future<void> dependencyInjection() async {
  // Invoice
  locator.registerLazySingleton(() => InvoiceServices());
  locator.registerLazySingleton(
    () => InvoiceRepositoriesImpl(locator<InvoiceServices>()),
  );

  // Auth
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(
    () => AuthRepositoriesImpl(locator<AuthService>()),
  );

  // Sharedpreferences
  locator.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
}
