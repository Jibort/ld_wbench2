// Funció d'entrada principal a l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

// Funció d'entrada principal a l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/ld_sabina_application.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/services/services.dart';
import 'package:ld_wbench2/views/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.isLogEnable = kDebugMode;
  
  // ✅ Inicialitzem serveis de forma asíncrona
  await Get.put(LdSecureStorageService().init(),  tag: LdSecureStorageService.className);
  await Get.put(LdDatabaseService().init(),       tag: LdDatabaseService.className);
  await Get.put(LdNetworkService().init(),        tag: LdNetworkService.className);
  await Get.put(LdAuthService().init(),           tag: LdAuthService.className);

  // Canviem la ruta inicial per mostrar la vista de proves de formulari
  // Comenta o descomenta la línia següent per canviar entre les vistes
  AppRoutes.initialRoute = AppRoutes.formTest; // Canvia a AppRoutes.mockup per veure l'original
  
  runApp(LdSabinaApplication(pSCtrl: LdSabinaController()));
}