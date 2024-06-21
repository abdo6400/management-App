import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'config/database/local/hive_local_database.dart';
import 'core/bloc/bloc_observer.dart';
import 'app/service_locator.dart';
import 'package:window_manager/window_manager.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1366, 768),
    minimumSize: Size(1366, 768),
    maximumSize: Size(1366, 768),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  Bloc.observer = MyBlocObserver();
  await Future.wait(
    [
      serviceLocatorInit(),
      HiveLocalDatabase.initializeHiveLocalDatabase(),
      Future.delayed(
        const Duration(milliseconds: 300),
      ),
    ],
  );
  runApp(const UserApp());
}
