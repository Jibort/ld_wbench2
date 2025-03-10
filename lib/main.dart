// Funció d'entrada principal a l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/ld_sabina_application.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/theme/ld_theme_controller.dart';
import 'package:ld_wbench2/services/services.dart';
import 'package:ld_wbench2/tools/debug.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.isLogEnable = kDebugMode;
  Debug.activateAllLevels();
    
  initializeThemeController();

  // ✅ Inicialitzem serveis de forma asíncrona
  await Get.put(LdSecureStorageService().init(),  tag: LdSecureStorageService.className);
  await Get.put(LdDatabaseService().init(),       tag: LdDatabaseService.className);
  await Get.put(LdNetworkService().init(),        tag: LdNetworkService.className);
  await Get.put(LdAuthService().init(),           tag: LdAuthService.className);

  runApp(LdSabinaApplication(pSCtrl: LdSabinaController.inst));
}

void initializeThemeController() {
  // Inicialitzar el controlador de tema com a singleton
  Get.put(LdThemeController(), tag: LdThemeController.ctrlTag, permanent: true);
}
