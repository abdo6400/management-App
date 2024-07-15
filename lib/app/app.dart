import 'package:baraneq/features/client/presentation/bloc/client_bloc/client_information_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/blocs/balance_bloc/balance_bloc.dart';

import 'package:baraneq/features/home/presentation/bloc/blocs/clients_bloc/clients_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/appbar_cubit/appbar_cubit.dart';
import 'package:baraneq/features/home/presentation/bloc/cubits/tanks_cubit/tanks_cubit.dart';
import 'package:baraneq/features/invoices/presentation/bloc/invoices_bloc.dart';
import 'package:baraneq/features/tanks/presentation/bloc/tank_crud_bloc/tank_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../config/database/local/pagination_values.dart';
import '../config/locale/app_localizations_setup.dart';
import '../config/routes/app_routes.dart';
import '../config/themes/app_theme.dart';
import '../core/bloc/global_cubit/locale_cubit.dart';
import '../core/bloc/global_cubit/theme_cubit.dart';
import '../core/utils/app_strings.dart';
import '../core/utils/app_values.dart';
import '../features/client/presentation/bloc/client_crud_bloc/client_crud_bloc.dart';
import '../features/home/presentation/bloc/blocs/client_search_bloc/client_search_bloc.dart'
    as home;
import '../features/home/presentation/bloc/blocs/receipt_bloc/recepit_bloc.dart';
import '../features/home/presentation/bloc/blocs/tanks_bloc/tanks_bloc.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/search/presentation/bloc/client_search_bloc/client_search_bloc.dart'
    as search;
import '../features/search/presentation/bloc/search_bloc.dart';
import '../features/tanks/presentation/bloc/tanks_bloc/tanks_bloc.dart';
import 'service_locator.dart';

class UserApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black12,
    ));
    final options = PaginationValues.getOptions();
    options['type'] = AppStrings.exporter.toUpperCase();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => sl<ThemeCubit>()),
          BlocProvider(
              create: (context) => sl<ClientInformationBloc>()
                ..add(GetClientsInformationEvent(
                    options: PaginationValues.getOptions()))),
          BlocProvider(create: (context) => sl<ClientCrudBloc>()),
          BlocProvider(
              create: (context) =>
                  sl<ClientsBloc>()..add(GetClientsEvent(options: options))),
          BlocProvider(create: (context) => sl<home.ClientSearchBloc>()),
          BlocProvider(create: (context) => sl<search.ClientSearchBloc>()),
          BlocProvider(
              create: (context) => sl<BalanceBloc>()..add(GetBalanceEvent())),
          BlocProvider(create: (context) => sl<RecepitBloc>()),
          BlocProvider(create: (context) => sl<SearchBloc>()),
          BlocProvider(create: (context) => sl<InvoicesBloc>()),
          BlocProvider(create: (context) => sl<ProfileBloc>()),
          BlocProvider(create: (context) => sl<AppbarCubit>()),
          BlocProvider(
              create: (context) => sl<TanksInformationBloc>()
                ..add(GetTanksInformationEvent(
                    options: PaginationValues.getOptions()))),
          BlocProvider(
              create: (context) => sl<TanksBloc>()
                ..add(GetTanksEvent(options: PaginationValues.getOptions()))),
          BlocProvider(create: (context) => sl<TankCrudBloc>()),
          BlocProvider(create: (context) => TanksCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, mode) {
            return BlocBuilder<LocaleCubit, LocaleState>(
                buildWhen: (previousState, currentState) {
              return previousState != currentState;
            }, builder: (context, state) {
              return GlobalLoaderOverlay(
                child: ScreenUtilInit(
                    designSize: AppValues.getPlatformSize(),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, _) {
                      return MaterialApp(
                        title: AppStrings.appName,
                        debugShowCheckedModeBanner: false,
                        themeMode: mode.themeMode,
                        theme: AppTheme.getApplicationLightTheme(),
                        darkTheme: AppTheme.getApplicationDarkTheme(),
                        navigatorKey: UserApp.navigatorKey,
                        onGenerateRoute: AppRoutes.onGenerateRoute,
                        locale: state.locale,
                        supportedLocales:
                            AppLocalizationsSetup.supportedLocales,
                        localeResolutionCallback:
                            AppLocalizationsSetup.localeResolutionCallback,
                        localizationsDelegates:
                            AppLocalizationsSetup.localizationsDelegates,
                      );
                    }),
              );
            });
          },
        ));
  }
}

//./gradlew signingReport