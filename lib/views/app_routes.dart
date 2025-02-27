// Definició de les rutes per a les vistes de l'aplicació.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

// lib/views/app_routes.dart - Actualitzat per incloure la nova vista

import 'package:get/get.dart';
import 'package:ld_wbench2/views/basic_test/view.dart'; // Importem la nova vista
import 'package:ld_wbench2/views/form_test/view.dart';
import 'package:ld_wbench2/views/mockup/view.dart';

class AppRoutes {
  static const String mockup = '/mockup';
  static const String formTest = '/form-test';
  static const String basicTest = '/basic-test'; // Nova ruta
  
  // Variable per canviar la ruta inicial dinàmicament
  static String initialRoute = basicTest; // Establim la nova vista com a inicial
  
  static final List<GetPage> pages = [
    GetPage(
      name: mockup,
      middlewares: [],
      participatesInRootNavigator: true,
      children: [],
      binding: MockupViewBinding(),
      page: () => MockupView(),
    ),
    GetPage(
      name: formTest,
      middlewares: [],
      participatesInRootNavigator: true,
      children: [],
      binding: FormTestViewBinding(),
      page: () => FormTestView(),
    ),
    // Afegim la nova vista
    GetPage(
      name: basicTest,
      middlewares: [],
      participatesInRootNavigator: true,
      children: [],
      binding: BasicTestViewBinding(),
      page: () => BasicTestView(),
    ),
  ];
}