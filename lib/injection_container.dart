import 'package:bengkel_pak_bowo/features/admin/invoice/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/admin/invoice/data/repositories/invoice_repositories_impl.dart';
import 'package:bengkel_pak_bowo/features/auth/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void dependencyInjection() {
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
}
