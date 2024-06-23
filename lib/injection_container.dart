import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/remote_datasource.dart';
import 'features/auth/data/repositories/auth_repositories_impl.dart';
import 'features/auth/domain/repositories/auth_repositories.dart';
import 'features/auth/domain/usecases/auth_login.dart';
import 'features/auth/domain/usecases/auth_register.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/invoice/data/datasources/remote.dart';
import 'features/invoice/data/repositories/invoice_repositories_impl.dart';
import 'features/invoice/domain/repositories/invoice_repositories.dart';
import 'features/invoice/domain/usecases/create_invoice_use_case.dart';
import 'features/invoice/domain/usecases/get_invoice_by_username_use_case.dart';
import 'features/invoice/domain/usecases/get_invoices_use_case.dart';
import 'features/invoice/presentation/cubit/invoice_cubit.dart';
import 'features/queue/data/datasources/remote_datasource.dart';
import 'features/queue/data/repositories/queue_repositories_impl.dart';
import 'features/queue/domain/repositories/queue_repositories.dart';
import 'features/queue/domain/usecases/get_my_queue_today_use_case.dart';
import 'features/queue/domain/usecases/get_queue_num_today_use_case.dart';
import 'features/queue/domain/usecases/get_queue_today_use_case.dart';
import 'features/queue/domain/usecases/pick_queue_use_case.dart';
import 'features/queue/presentation/cubit/queue_cubit.dart';

final GetIt locator = GetIt.instance;

Future<void> dependencyInjection() async {
  // Invoice
  locator.registerLazySingleton<InvoiceRemoteDataSource>(
      () => InvoiceRemoteDataSourceImpl());
  locator.registerLazySingleton<InvoiceRepositories>(
      () => InvoiceRepositoriesImpl(locator()));

  // Use Case Invoice
  locator.registerLazySingleton(() => CreateInvoiceUseCase(locator()));
  locator.registerLazySingleton(()=> GetInvoicesUseCase(locator()));
  locator.registerLazySingleton(()=> GetInvoiceByUsernameUseCase(locator()));

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
  locator.registerLazySingleton(() => AuthCubit(
        authLoginUseCase: locator(),
        authRegisterUseCase: locator(),
      ));
  locator.registerLazySingleton(() => QueueCubit(
        getQueueNumTodayUseCase: locator(),
        pickQueueUseCase: locator(),
        getMyQueueTodayUseCase: locator(),
        getQueueTodayUseCase: locator(),
      ));
  locator.registerLazySingleton(() => InvoiceCubit(
        createInvoiceUseCase: locator(),
        getInvoicesUseCase: locator(),
        getInvoiceByUsernameUseCase: locator(),
      ));

  // Sharedpreferences
  locator.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
}
