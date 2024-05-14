import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'config/database/local/hive_local_database.dart';
import 'core/bloc/bloc_observer.dart';
import 'app/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Future.wait(
      [serviceLocatorInit(), HiveLocalDatabase.initializeHiveLocalDatabase()]);

  runApp(const UserApp());
}
