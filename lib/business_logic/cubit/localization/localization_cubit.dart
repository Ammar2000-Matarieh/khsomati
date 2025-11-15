import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/localization/localization_state.dart';
import 'package:khsomati/constants/translation/ar.dart';
import 'package:khsomati/constants/translation/en.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit()
    : super(LocalizationState(locale: Locale("en"), localizationString: {})) {
    loadLanguage("en");
  }

  Future<void> loadLanguage(String code) async {
    
    final map = code=='ar'?Ar.trannslation:En.trannslation;

    emit(LocalizationState(localizationString: map, locale: Locale(code)));
  }

  String translate(String key) {
    return state.localizationString[key] ?? "";
  }
}
