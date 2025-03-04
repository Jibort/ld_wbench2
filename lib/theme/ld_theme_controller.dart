// Controlador del tema visual de l'aplicació.
// CreatedAt: 2025/03/03 dl. JIQ

import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/theme/ld_theme.dart';

class   LdThemeController
extends GetxController {
  // ESTÀTICS -------------------------
  static String ctrlTag = "themeCtrl"; 
  
  // Instància única (singleton)
  static LdThemeController get inst => Get.find<LdThemeController>(tag: ctrlTag);
  
  // MEMBRES --------------------------
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;
  
  // Temes personalitzats
  ThemeData get lightTheme => LdTheme.lightTheme;
  ThemeData get darkTheme => LdTheme.darkTheme;
  
  // 📥 GETTERS/SETTERS ------------------
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;
  
  // CONSTRUCTORS ---------------------
  LdThemeController() {
    // Detectar el mode actual del sistema
    final brightness = PlatformDispatcher.instance.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
  }
  
  // MÈTODES PÚBLICS ------------------
  void changeThemeMode(ThemeMode mode) {
    _themeMode = mode;
    
    if (mode == ThemeMode.system) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      _isDarkMode = brightness == Brightness.dark;
    } else {
      _isDarkMode = (mode == ThemeMode.dark);
    }
    
    Get.changeThemeMode(mode);
    update([ctrlTag]); // Actualitzar els GetBuilders que escolten aquest controlador
  }
  
  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      // Si estem en mode sistema, canviem a fosc o clar depenent de l'actual
      changeThemeMode(_isDarkMode ? ThemeMode.light : ThemeMode.dark);
    } else {
      // Si ja estem en mode manual, alternem entre fosc i clar
      changeThemeMode(_themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }
  
  // Per detectar canvis en el tema del sistema
  void updateSystemTheme() {
    if (_themeMode == ThemeMode.system) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      final newIsDarkMode = brightness == Brightness.dark;
      
      if (_isDarkMode != newIsDarkMode) {
        _isDarkMode = newIsDarkMode;
        update([ctrlTag]);
      }
    }
  }
}
