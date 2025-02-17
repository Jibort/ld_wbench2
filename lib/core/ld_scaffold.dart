// Especialització d'Scaffold per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_app_bar.dart';
import 'package:ld_wbench2/core/ld_deep.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/views/widget_key.dart';

class LdScaffold extends Scaffold with LdId {
  // ESTÀTICS -------------------------
  static const className = "LdScaffold";

  LdScaffold({
    super.key,
    required Widget pBody,
    required LdViewController pVCtrl,
    super.floatingActionButton,
    super.drawer,
    super.bottomNavigationBar,
    Color? pBgColor,
  }) : super(
          backgroundColor: pBgColor ?? Get.theme.scaffoldBackgroundColor,
          appBar: LdAppBar(title: "Vista Mockup", pVCtrl: pVCtrl),
          body: GetBuilder<LdViewController>(
            init: pVCtrl,
            id: WidgetKey.scaffold.idx, // pVCtrl.tag,
            builder: (vctrl) => vctrl.vState.isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Get.theme.primaryColor),
                        SizedBox(height: 10),
                        Text("Carregant dades...", style: Get.textTheme.bodyMedium),
                      ],
                    ),
                  )
                : pBody,
          ),
        ) {
    rtType = LdDeep.className;
  }
}
