import 'package:bengkel_pak_bowo/features/auth/domain/repositories/auth_repositories.dart';
import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/queue/data/datasources/remote_datasource.dart';
import 'package:bengkel_pak_bowo/features/queue/data/repositories/queue_repositories_impl.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/repositories/queue_repositories.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/usecases/get_my_queue_today_use_case.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/usecases/get_queue_num_today_use_case.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/usecases/get_queue_today_use_case.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/usecases/pick_queue_use_case.dart';
import 'package:bengkel_pak_bowo/features/queue/presentation/cubit/queue_cubit.dart';

import 'features/invoice/data/data_sources/remote.dart';
import 'features/invoice/data/repositories/invoice_repositories_impl.dart';
import 'features/auth/data/datasources/remote_datasource.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/domain/usecases/auth_login.dart';
import 'features/auth/domain/usecases/auth_register.dart';

final GetIt locator = GetIt.instance;

Future<void> dependencyInjection() async {
  // Invoice
  locator.registerLazySingleton(() => InvoiceServices());
  locator.registerLazySingleton(() => InvoiceRepositoriesImpl(locator()));

  // Auth
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  locator.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImpl(locator()));

  // Use Case Auth
  locator.registerLazySingleton(() => AuthRegisterUseCase(locator()));
  locator.registerLazySingleton(() => AuthLoginUseCase(locator()));

  // Queue
  locator.registerLazySingleton<QueueRemoteDataSource>(
      () => QueueRemoteDataSourceImpl());
  locator.registerLazySingleton<QueueRepositories>(
      () => QueueRepositoriesImpl(locator()));

  // Use Case Queue
  locator
      .registerLazySingleton(() => GetQueueNumTodayUseCase(locator())); // User
  locator.registerLazySingleton(() => PickQueueUseCase(locator())); // User
  locator
      .registerLazySingleton(() => GetMyQueueTodayUseCase(locator())); // User
  locator.registerLazySingleton(() => GetQueueTodayUseCase(locator())); // Admin

  // BLoC
  locator.registerLazySingleton(() =>
      AuthCubit(authLoginUseCase: locator(), authRegisterUseCase: locator()));
  locator.registerLazySingleton(() => QueueCubit(
        getQueueNumTodayUseCase: locator(),
        pickQueueUseCase: locator(),
        getMyQueueTodayUseCase: locator(),
        getQueueTodayUseCase: locator(),
      ));

  // Sharedpreferences
  locator.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
}
