// Aplicació Sabina.
// CreatedAt: 2025/02/13 dj. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_controller.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/tools/consts/devices.dart';

class LdSabinaApplication extends StatelessWidget {
  // ESTÀTICS -------------------------
  static const className = "LdSabinaApp";

  // MEMBRES --------------------------
  final LdSabinaController _sCtrl;

  // CONSTRUCTORS ---------------------
  LdSabinaApplication({super.key, required LdSabinaController pSCtrl}): _sCtrl = pSCtrl {
    var _ = _sCtrl;
  }

  // 'StatelessWidget' ----------------
  @override
  Widget build(BuildContext context) {
    final LdSabinaController appCtrl = LdController.findOrNull(LdSabinaController.className)! as LdSabinaController;

    return ScreenUtilInit(
    designSize: iPhone8PlusSize,
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) =>
      Obx(() => 
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LdSabinaApp',
          themeMode: appCtrl.themeMode.value,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          locale: Locale(appCtrl.currentLocale.value),
          fallbackLocale: Locale('ca'),
          home: HomePage(),
        )
      )
    );
  }
}