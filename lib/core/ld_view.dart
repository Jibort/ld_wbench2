// Classe genèrica per a totes les vistes de l'aplicació.
// CreateAt: 2025/02/17 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/theme/ld_theme_controller.dart';

abstract class LdView<S extends LdViewState, C extends LdViewCtrl>
extends GetView<C> {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdView";

  // 🧩 MEMBRES ------------------------
  GetBuilder<LdThemeController>? getBuilder;
  final S _state;
  final C _ctrl;

  // 🛠️ CONSTRUCTORS -------------------
  LdView({ 
    super.key, 
    required C pCtrl
  }): _ctrl = pCtrl, _state = pCtrl.state as S;

  // 📥 GETTERS/SETTERS ----------------
  S get state => _state;
  C  get ctrl => _ctrl;

  // 🛠️ CONSTRUCCIÓ DE LA VISTA -------
  @override
  @mustCallSuper
  Widget build(BuildContext pCtx) {
    getBuilder ??= GetBuilder<LdThemeController>(
      tag: LdThemeController.ctrlTag,
      builder: (themeController) => GetBuilder<C>(
        id: ctrl.tag,     // Identificador per a l'actualització del GetBuilder.
        tag: ctrl.tag,    // Identificador per a la cerca dins el registre de GetX.
        init: ctrl,       // Controlador on escolta el GetBuilder. 
        builder: (vCtrl) => _ctrl.buildView(pCtx),
      ),
    );

    return getBuilder!;
  }
  // @override
  // @mustCallSuper
  // Widget build(BuildContext pCtx) {
  //   getBuilder ??= GetBuilder<C>(
  //     id: ctrl.tag,     // Identificador per a l'actualització del GetBuilder.
  //     tag: ctrl.tag,    // Identificador per a la cerca dins el registre de GetX.
  //     init: ctrl,       // Controlador on escolta el GetBuilder. 
  //     builder: (vCtrl) => GetBuilder<LdThemeController>(
  //       init: LdThemeController.inst,
  //       tag:  LdThemeController.ctrlTag,
  //       builder: (themeController) => _ctrl.buildView(pCtx),
  //     ),  // Construcció de la vista.
  //   );

  //   return getBuilder!;
  // }
}