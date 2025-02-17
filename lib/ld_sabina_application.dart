// Aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/tools/consts/devices.dart';
import 'package:ld_wbench2/views/app_routes.dart';

class LdSabinaApplication extends StatelessWidget {
  // ESTÀTICS -------------------------
  static const className = "LdSabinaApp";

  // MEMBRES --------------------------
  final LdSabinaController _sCtrl;

  // CONSTRUCTORS ---------------------
  const LdSabinaApplication({super.key, required LdSabinaController pSCtrl}): _sCtrl = pSCtrl;

  // 'StatelessWidget' ----------------
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
    designSize: iPhone8PlusSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) =>
      Obx(() => 
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LdSabinaApp',
          themeMode: _sCtrl.themeMode.value,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          locale: Locale(_sCtrl.currentLocale.value),
          fallbackLocale: Locale('ca'),
          initialRoute: AppRoutes.mockup,
          getPages: AppRoutes.pages,
        )
      )
    );
  }
}