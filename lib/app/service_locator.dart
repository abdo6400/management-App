import 'package:baraneq/features/client/data/datasources/client_local_data_source.dart';
import 'package:baraneq/features/client/data/repositories/client_repository_impl.dart';
import 'package:baraneq/features/client/domain/repositories/client_repository.dart';
import 'package:baraneq/features/home/data/datasources/home_local_data_source.dart';
import 'package:baraneq/features/home/data/repositories/home_repository_impl.dart';
import 'package:baraneq/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:baraneq/features/home/domain/usecases/get_clients_with_filters_usecase.dart';
import 'package:baraneq/features/home/presentation/bloc/balance_bloc/balance_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/exporter_bloc/exporter_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/importers_bloc/importers_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../config/database/api/api_consumer.dart';
import '../config/database/api/app_interceptors.dart';
import '../config/database/api/dio_consumer.dart';
import '../config/database/cache/cache_consumer.dart';
import '../config/database/cache/secure_cache_helper.dart';
import '../config/database/local/hive_local_database.dart';
import '../config/database/network/netwok_info.dart';

//import '../core/utils/google_mpas_tools.dart';
import '../features/client/domain/usecases/add_client_usecase.dart';
import '../features/client/presentation/bloc/client_bloc.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/presentation/bloc/client_search_bloc/client_search_bloc.dart';
import '/core/bloc/global_cubit/locale_cubit.dart';
import '/core/bloc/global_cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  await _authInit();
  await _app();
  //External
  final sharedPreferences = await SecureSharedPref.getInstance();
  sl.registerLazySingleton<CacheConsumer>(
      () => SecureCacheHelper(sharedPref: sharedPreferences));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: sl(), networkInfo: sl()));
  sl.registerLazySingleton<HiveLocalDatabase>(() => HiveLocalDatabase());
  sl.registerLazySingleton(() => LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      requestBody: true));
  sl.registerLazySingleton(() => AppIntercepters(
        client: sl(),
      ));
  //google maps tools
  // sl.registerLazySingleton(() => GoogleMapsTools());
}

Future<void> _app() async {
  //! Blocs or cubits
  sl.registerLazySingleton<ClientBloc>(() => ClientBloc(sl()));
  sl.registerLazySingleton<ExporterBloc>(() => ExporterBloc(sl()));
  sl.registerLazySingleton<ImportersBloc>(() => ImportersBloc(sl()));
  sl.registerLazySingleton<ClientSearchBloc>(() => ClientSearchBloc(sl()));
  sl.registerLazySingleton<BalanceBloc>(() => BalanceBloc(sl()));

  //! Use cases
  sl.registerLazySingleton<AddClientUsecase>(
      () => AddClientUsecase(repository: sl()));
  sl.registerLazySingleton<GetClientsWithFiltersUsecase>(
      () => GetClientsWithFiltersUsecase(repository: sl()));
  sl.registerLazySingleton<GetBalanceUsecase>(
      () => GetBalanceUsecase(repository: sl()));
  //! repositories
  sl.registerLazySingleton<ClientRepository>(
      () => CLientRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(dataSource: sl()));
  //! Data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<ClientLocalDataSource>(
      () => ClientLocalDataSourceImpl(localConsumer: sl()));
}

Future<void> _authInit() async {
  //! Blocs or cubits

  //! Use cases

  //! repositories

  //! Data sources
}
