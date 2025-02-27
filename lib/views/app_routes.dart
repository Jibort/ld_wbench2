// Definició de les rutes per a les vistes de l'aplicació.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:get/get.dart';
import 'package:ld_wbench2/views/form_test/view.dart';
import 'package:ld_wbench2/views/mockup/view.dart';

class AppRoutes {
  static const String mockup = '/mockup';
  static const String formTest = '/form-test';
  
   // Variable per canviar la ruta inicial dinàmicament
  static String initialRoute = mockup;
  
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
  ];
}
