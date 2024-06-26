import 'package:baraneq/features/client/presentation/bloc/client_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/balance_bloc/balance_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/exporter_bloc/exporter_bloc.dart';
import 'package:baraneq/features/home/presentation/bloc/importers_bloc/importers_bloc.dart';
import 'package:baraneq/features/invoices/presentation/bloc/invoices_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../config/locale/app_localizations_setup.dart';
import '../config/routes/app_routes.dart';
import '../config/themes/app_theme.dart';
import '../core/bloc/global_cubit/locale_cubit.dart';
import '../core/bloc/global_cubit/theme_cubit.dart';
import '../core/utils/app_strings.dart';
import '../core/utils/app_values.dart';
import '../features/home/presentation/bloc/client_search_bloc/client_search_bloc.dart';
import '../features/home/presentation/bloc/receipt_bloc/recepit_bloc.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/search/presentation/bloc/search_bloc.dart';
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => sl<ThemeCubit>()),
          BlocProvider(create: (context) => sl<ClientBloc>()),
          BlocProvider(
              create: (context) =>
                  sl<ImportersBloc>()..add(GetImportersClientsEvent())),
          BlocProvider(
              create: (context) =>
                  sl<ExporterBloc>()..add(GetExportersClientsEvent())),
          BlocProvider(create: (context) => sl<ClientSearchBloc>()),
          BlocProvider(
              create: (context) => sl<BalanceBloc>()..add(GetBalanceEvent())),
          BlocProvider(create: (context) => sl<RecepitBloc>()),
          BlocProvider(create: (context) => sl<SearchBloc>()),
          BlocProvider(create: (context) => sl<InvoicesBloc>()),
          BlocProvider(
              create: (context) => sl<ProfileBloc>()..add(GetTanksEvent())),
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