import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../app/service_locator.dart';
import '../../../config/database/cache/cache_consumer.dart';
import '../../utils/app_enums.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(const ChangeLocaleState(Locale(AppStrings.arabicCode)));

  String currentLangCode = AppStrings.arabicCode;

  Future<void> getSavedLang() async {
    final currentLangCode = await sl<CacheConsumer>()
            .getData(key: MySharedKeys.language.name) ??
        AppStrings.arabicCode;
    await sl<CacheConsumer>().saveData(
        key: MySharedKeys.language.name, value: AppStrings.arabicCode);
    emit(ChangeLocaleState(Locale(currentLangCode)));
  }

  Future<void> _changeLang(String langCode) async {
    await sl<CacheConsumer>()
        .saveData(key: MySharedKeys.language.name, value: langCode);
    currentLangCode = langCode;

    emit(ChangeLocaleState(Locale(currentLangCode)));
  }

  void toEnglish() => _changeLang(AppStrings.englishCode);
  void toArabic() => _changeLang(AppStrings.arabicCode);
}
