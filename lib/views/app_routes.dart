// Definició de les rutes per a les vistes de l'aplicació.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:get/get.dart';
import 'package:ld_wbench2/views/mockup/view.dart';

class AppRoutes {
  static const String mockup = '/mockup';

  static final List<GetPage> pages = [
    GetPage(
      name: mockup,
      middlewares: [],
      participatesInRootNavigator: true,
      children: [],
      binding: MockupViewBinding(),
      page: () => MockupView(),
    ),
  ];
}
