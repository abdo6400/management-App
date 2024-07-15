import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/service_locator.dart';
import '../../../config/database/cache/cache_consumer.dart';
import '../../utils/app_enums.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeThemeState extends ThemeState {
  const ChangeThemeState(super.themeMode);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ChangeThemeState(ThemeMode.light));

  ThemeMode currentThemeMode = ThemeMode.light;

  bool isDark() => currentThemeMode == ThemeMode.dark;

  Future<void> getThemeMode() async {
    final String? value =await
        sl<CacheConsumer>().getData(key: MySharedKeys.theme.name);

    if (value != null && value.compareTo(ThemeMode.dark.name) == 0) {
      currentThemeMode = ThemeMode.dark;
      emit(const ChangeThemeState(ThemeMode.dark));
    } else if (value != null && value.compareTo(ThemeMode.light.name) == 0) {
      currentThemeMode = ThemeMode.light;
      emit(const ChangeThemeState(ThemeMode.light));
    } else {
      currentThemeMode = ThemeMode.light;
      emit(const ChangeThemeState(ThemeMode.light));
    }
  }

  Future<void> _changeTheme(ThemeMode mode) async {
    sl<CacheConsumer>()
        .saveData(key: MySharedKeys.theme.name, value: mode.name);
    currentThemeMode = mode;
    emit(ChangeThemeState(mode));
  }

  void toLightMode() => _changeTheme(ThemeMode.light);
  void toDarkMode() => _changeTheme(ThemeMode.dark);
  void toSystemMode() => _changeTheme(ThemeMode.system);
}
