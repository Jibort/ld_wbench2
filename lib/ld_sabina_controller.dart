// Controlador principal de l'aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id_mixin.dart';
import 'package:ld_wbench2/services/services.dart';
import 'package:ld_wbench2/tools/debug.dart';

class   LdSabinaController 
extends FullLifeCycleController
with    LdIdMixin {
  // ESTÀTICS -------------------------
  static const className = "LdSabinaCtrl";

  // MEMBRES --------------------------
  final LdSecureStorageService _secStg = LdSecureStorageService.inst; // LdController.find(LdSecureStorageService.className) as LdSecureStorageService;

  // CONSTRUCTOR ----------------------
  LdSabinaController() {
    tag = className;
    Get.put(this, tag: tag);
    var _ = _secStg;
    Debug.debug(DebugLevel.debug_0, "[LdSabinaController]: ...controlador '$tag' creat.");
  }

  // 🔹 GESTIÓ DEL TEMA ----------------
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  void toggleTheme() {
    themeMode.value = (Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
  }

  void setLightTheme() {
    themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
  }

  void setDarkTheme() {
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
  }

  // 🔹 GESTIÓ DE L'IDIOMA --------------
  RxString currentLocale = 'ca'.obs;

  void changeLanguage(String langCode) {
    currentLocale.value = langCode;
    Get.updateLocale(Locale(langCode));
  }

  // 🔹 ESTAT DE CONNEXIÓ ----------------
  RxBool isOnline = false.obs;

  void updateNetworkStatus(bool status) {
    isOnline.value = status;
  }

  // Carrega les preferències ---------
  Future<void> loadPreferences() async {
    // Implementació futura: carregar configuracions de SharedPreferences o una BD
  }

  // 'WidgetsBindingObserver' ------------
  // Quan es produeix un canvi en l'estat del cicle de vida de l'aplicacio.
  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState pState) {
    switch (pState) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }

  // Quan l'aplicació torna a primer pla
  void onResumed() {
    Debug.info("[onResumed.${runtimeType.toString()}]: L'aplicació ha tornat a primer pla.");
  }

  // Quan l'aplicació és minimitzada o passa a segon pla
  void onPaused() {
    Debug.info("[onPaused.${runtimeType.toString()}]: L'aplicació ha estat minimitzada.");
  }

  // Quan l'aplicació està en estat inactiu (com per exemple, en una trucada)
  void onInactive() {
    Debug.info("[onInactive.${runtimeType.toString()}]: L'aplicació està en estat inactiu.");
  }

  // Quan l'aplicació és tancada pel sistema operatiu
  void onDetached() {
    Get.delete(tag: className);
    Debug.info("[onDetached.${runtimeType.toString()}]: L'aplicació ha estat completament tancada.");
  }

  // Quan l'aplicació es ocultada.
  void onHidden() {
    Debug.info("[onHidden.${runtimeType.toString()}]: L'aplicació ha estat ocultada.");
  }
}
