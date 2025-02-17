// Funció d'entrada principal a l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable.dart';
import 'package:ld_wbench2/ld_sabina_application.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.isLogEnable = kDebugMode;
  
  // ✅ Inicialitzem els serveis de manera asíncrona
  LdSecureStorageService();
  LdDatabaseService();
  LdNetworkService();
  LdAuthService();
  
  runApp(LdSabinaApplication(pSCtrl: LdSabinaController()));
}
