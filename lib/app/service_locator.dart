import 'package:baraneq/features/client/data/datasources/client_local_data_source.dart';
import 'package:baraneq/features/client/data/repositories/client_repository_impl.dart';
import 'package:baraneq/features/client/domain/repositories/client_repository.dart';
import 'package:baraneq/features/home/data/datasources/home_local_data_source.dart';
import 'package:baraneq/features/home/data/repositories/home_repository_impl.dart';
import 'package:baraneq/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:baraneq/features/home/domain/usecases/get_daily_clients.dart';
import 'package:baraneq/features/home/domain/usecases/search_about_client_usecase.dart'
    as home;
import 'package:baraneq/features/home/presentation/bloc/blocs/balance_bloc/balance_bloc.dart';

import 'package:baraneq/features/home/presentation/bloc/blocs/clients_bloc/clients_bloc.dart';
import 'package:baraneq/features/invoices/data/datasources/invoices_local_data_source.dart';
import 'package:baraneq/features/invoices/data/repositories/invoices_repository_impl.dart';
import 'package:baraneq/features/invoices/domain/repositories/invoices_repository.dart';
import 'package:baraneq/features/invoices/domain/usecases/account_statement_with_filters_usecase.dart';
import 'package:baraneq/features/invoices/presentation/bloc/invoices_bloc.dart';
import 'package:baraneq/features/tanks/data/datasources/tanks_local_data_source.dart';
import 'package:baraneq/features/tanks/data/repositories/tanks_repository_impl.dart';
import 'package:baraneq/features/tanks/domain/repositories/tanks_repository.dart';
import 'package:baraneq/features/tanks/domain/usecases/add_tank_usecase.dart';
import 'package:baraneq/features/tanks/presentation/bloc/tank_crud_bloc/tank_crud_bloc.dart';
import 'package:baraneq/features/tanks/presentation/bloc/tanks_bloc/tanks_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../config/database/api/api_consumer.dart';
import '../config/database/api/app_interceptors.dart';
import '../config/database/api/dio_consumer.dart';
import '../config/database/cache/cache_consumer.dart';
import '../config/database/cache/secure_cache_helper.dart';
import '../config/database/local/sql_local_database.dart';
import '../config/database/network/netwok_info.dart';

//import '../core/utils/google_mpas_tools.dart';
import '../features/client/domain/usecases/add_client_usecase.dart';
import '../features/client/domain/usecases/delete_client_usecase.dart';
import '../features/client/domain/usecases/edit_client_usecase.dart';
import '../features/client/domain/usecases/get_clients_usecase.dart';
import '../features/client/presentation/bloc/client_bloc/client_information_bloc.dart';
import '../features/client/presentation/bloc/client_crud_bloc/client_crud_bloc.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/add_receipt_usecase.dart';
import '../features/home/domain/usecases/delete_receipt_usecase.dart';
import '../features/home/domain/usecases/edit_receipt_usecase.dart';
import '../features/home/domain/usecases/get_tanks_information_usecase.dart';
import '../features/home/domain/usecases/search_about_client_usecase.dart';
import '../features/home/presentation/bloc/blocs/client_search_bloc/client_search_bloc.dart'
    as home;
import '../features/home/presentation/bloc/cubits/appbar_cubit/appbar_cubit.dart';
import '../features/home/presentation/bloc/blocs/receipt_bloc/recepit_bloc.dart';
import '../features/home/presentation/bloc/blocs/tanks_bloc/tanks_bloc.dart';
import '../features/profile/data/datasources/profile_local_data_source.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/search/domain/usecases/search_about_client_usecase.dart'
    as search;
import '../features/search/presentation/bloc/client_search_bloc/client_search_bloc.dart'
    as search;
import '../features/tanks/domain/usecases/delete_tank_usecase.dart';
import '../features/tanks/domain/usecases/edit_tank_usecase.dart';
import '../features/tanks/domain/usecases/get_tanks_usecase.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/search/data/datasources/search_local_data_source.dart';
import '../features/search/data/repositories/search_repository_impl.dart';
import '../features/search/domain/repositories/search_repository.dart';
import '../features/search/domain/usecases/search_with_filters_usecase.dart';
import '../features/search/presentation/bloc/search_bloc.dart';
import '/core/bloc/global_cubit/locale_cubit.dart';
import '/core/bloc/global_cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  await _authInit();
  await _app();
  //External
  // AndroidOptions _getAndroidOptions() => const AndroidOptions(
  //       encryptedSharedPreferences: true,
  //     );
  final sharedPreferences = FlutterSecureStorage(
      // aOptions: _getAndroidOptions(),
      wOptions: WindowsOptions(useBackwardCompatibility: true));
  sqfliteFfiInit();
  databaseFactoryOrNull = databaseFactoryFfi;
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
  sl.registerLazySingleton<SqlLocalDatabase>(() => SqlLocalDatabase.instance);

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
  sl.registerLazySingleton<ClientInformationBloc>(
      () => ClientInformationBloc(sl()));
  sl.registerLazySingleton<ClientCrudBloc>(
      () => ClientCrudBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<ClientsBloc>(() => ClientsBloc(sl()));
  sl.registerLazySingleton<home.ClientSearchBloc>(
      () => home.ClientSearchBloc(sl()));
  sl.registerLazySingleton<search.ClientSearchBloc>(
      () => search.ClientSearchBloc(sl()));
  sl.registerLazySingleton<BalanceBloc>(() => BalanceBloc(sl()));
  sl.registerLazySingleton<RecepitBloc>(() => RecepitBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<SearchBloc>(() => SearchBloc(sl()));
  sl.registerLazySingleton<InvoicesBloc>(() => InvoicesBloc(sl()));
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  sl.registerLazySingleton<AppbarCubit>(() => AppbarCubit());
  sl.registerLazySingleton<TanksBloc>(() => TanksBloc(sl()));
  sl.registerLazySingleton<TankCrudBloc>(() => TankCrudBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<TanksInformationBloc>(
      () => TanksInformationBloc(sl()));
  //! Use cases
  sl.registerLazySingleton<AddClientUsecase>(
      () => AddClientUsecase(repository: sl()));
  sl.registerLazySingleton<EditClientUsecase>(
      () => EditClientUsecase(repository: sl()));
  sl.registerLazySingleton<DeleteClientUsecase>(
      () => DeleteClientUsecase(repository: sl()));
  sl.registerLazySingleton<GetClientsUsecase>(
      () => GetClientsUsecase(repository: sl()));
  sl.registerLazySingleton<getDailyClientsUsecase>(
      () => getDailyClientsUsecase(repository: sl()));
  sl.registerLazySingleton<GetBalanceUsecase>(
      () => GetBalanceUsecase(repository: sl()));
  sl.registerLazySingleton<AddReceiptUsecase>(
      () => AddReceiptUsecase(repository: sl()));
  sl.registerLazySingleton<EditReceiptUsecase>(
      () => EditReceiptUsecase(repository: sl()));
  sl.registerLazySingleton<DeleteReceiptUsecase>(
      () => DeleteReceiptUsecase(repository: sl()));
  sl.registerLazySingleton<SearchWithFiltersUsecase>(
      () => SearchWithFiltersUsecase(repository: sl()));
  sl.registerLazySingleton<search.SearchAboutClientUsecase>(
      () => search.SearchAboutClientUsecase(repository: sl()));
  sl.registerLazySingleton<AccountStatementWithFiltersUsecase>(
      () => AccountStatementWithFiltersUsecase(repository: sl()));
  sl.registerLazySingleton<GetTanksUsecase>(
      () => GetTanksUsecase(repository: sl()));
  sl.registerLazySingleton<AddTankUsecase>(
      () => AddTankUsecase(repository: sl()));
  sl.registerLazySingleton<EditTankUsecase>(
      () => EditTankUsecase(repository: sl()));
  sl.registerLazySingleton<DeleteTankUsecase>(
      () => DeleteTankUsecase(repository: sl()));
  sl.registerLazySingleton<GetTanksInformationUsecase>(
      () => GetTanksInformationUsecase(repository: sl()));
  sl.registerLazySingleton<home.SearchAboutClientUsecase>(
      () => home.SearchAboutClientUsecase(repository: sl()));
  //! repositories
  sl.registerLazySingleton<ClientRepository>(
      () => CLientRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<InvoicesRepository>(
      () => InvoicesRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<TanksRepository>(
      () => TanksRepositoryImpl(dataSource: sl()));
  //! Data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<ClientLocalDataSource>(
      () => ClientLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<InvoicesLocalDataSource>(
      () => InvoicesLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<TanksLocalDataSource>(
      () => TanksLocalDataSourceImpl(localConsumer: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(localConsumer: sl()));
}

Future<void> _authInit() async {
  //! Blocs or cubits

  //! Use cases

  //! repositories

  //! Data sources
}
