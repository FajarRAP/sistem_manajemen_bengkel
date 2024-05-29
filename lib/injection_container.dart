import 'package:bengkel_pak_bowo/queue/data/data_sources/remote.dart';
import 'package:bengkel_pak_bowo/queue/data/repositories/queue_repositories_impl.dart';
import 'package:bengkel_pak_bowo/queue/domain/usecases/get_my_queue_today_use_case.dart';
import 'package:bengkel_pak_bowo/queue/domain/usecases/get_queue_num_today_use_case.dart';
import 'package:bengkel_pak_bowo/queue/domain/usecases/get_queue_today_use_case.dart';
import 'package:bengkel_pak_bowo/queue/domain/usecases/pick_queue_use_case.dart';

import 'features/admin/transaction/data/data_sources/remote.dart';
import 'features/admin/transaction/data/repositories/invoice_repositories_impl.dart';
import 'features/auth/data/data_sources/remote.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/domain/usecases/auth_login.dart';
import 'features/auth/domain/usecases/auth_register.dart';

final GetIt locator = GetIt.instance;

Future<void> dependencyInjection() async {
  // Invoice
  locator.registerLazySingleton(() => InvoiceServices());
  locator.registerLazySingleton(
      () => InvoiceRepositoriesImpl(locator<InvoiceServices>()));

  // Auth
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(
      () => AuthRepositoriesImpl(locator<AuthService>()));

  // Queue
  locator.registerLazySingleton(() => QueueService());
  locator.registerLazySingleton(
      () => QueueRepositoriesImpl(locator<QueueService>()));

  // Use Case Auth
  locator.registerLazySingleton(
      () => AuthRegisterUseCase(locator<AuthRepositoriesImpl>()));
  locator.registerLazySingleton(
      () => AuthLoginUseCase(locator<AuthRepositoriesImpl>()));

  // Use Case Queue
  locator.registerLazySingleton(
      () => GetQueueTodayUseCase(locator<QueueRepositoriesImpl>()));
  locator.registerLazySingleton(
      () => GetQueueNumTodayUseCase(locator<QueueRepositoriesImpl>()));
  locator.registerLazySingleton(
      () => PickQueueUseCase(locator<QueueRepositoriesImpl>()));
  locator.registerLazySingleton(
      () => GetMyQueueTodayUseCase(locator<QueueRepositoriesImpl>()));

  // Sharedpreferences
  locator.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
}
