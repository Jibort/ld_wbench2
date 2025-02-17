// Funció d'entrada principal a l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_service.dart';
import 'package:ld_wbench2/ld_sabina_application.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.isLogEnable = kDebugMode;
  
  // ✅ Inicialitzem serveis de forma asíncrona
  await LdService.putAsync(() => LdSecureStorageService().init(), pTag: LdSecureStorageService.className);
  await LdService.putAsync(() => LdDatabaseService().init(), pTag: LdDatabaseService.className);
  await LdService.putAsync(() => LdNetworkService().init(), pTag: LdNetworkService.className);
  await LdService.putAsync(() => LdAuthService().init(), pTag: LdAuthService.className);

  
  runApp(LdSabinaApplication(pSCtrl: LdSabinaController()));
}
