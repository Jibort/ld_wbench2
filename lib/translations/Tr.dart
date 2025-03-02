// Diccionari de traduccions.
// CreatedAt: 2025/02/17 dl. JIQ

import 'dart:ui';

import 'package:get/get.dart';

import 'ca.dart';
import 'en.dart';
import 'es.dart';
import 'fr.dart';
import 'pt.dart';

class Tr extends Translations {
  // Claus constants.
  static const sabinaApp = "sabinaApp";
  static const sabinaWelcome = "sabinaWelcome";
  static const loading = "loading";
  static const of = "of";
  
  static final Tr inst = Tr();
  static const Map<String, Map<String, String>> _keys = {
    'ca': caMap, 
    'en': enMap, 
    'es': esMap, 
    'fr': frMap, 
    'pt': ptMap 
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;

  void changeLocale(String langCode) {
    var locale = Locale(langCode);
    Get.updateLocale(locale);
  } 
}
