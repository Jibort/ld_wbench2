// Classe embolcall per a tots els widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id_mixin.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidget<C extends LdWidgetCtrl>
extends GetWidget<C> 
with    LdIdMixin {

  // 🧩 MEMBRES ------------------------
  final LdViewCtrl        _vCtrl; // Cotrolador de la vista on es renderitza el Widget.
  final LdWidgetState     _state; // Estat del Widget.
  late final LdWidgetCtrl _ctrl;  // Controlador del Widget.

  // CONSTRUCTOR ------------------
  LdWidget({ 
    super.key, 
    required LdViewCtrl pVCtrl, 
    required LdWidgetState pState,
  }): 
    _vCtrl = pVCtrl,
    _state = pState;
    // _ctrl =  pState.wCtrl;

  // GETTERS/SETTERS ------------------
  LdViewCtrl    get vCtrl => _vCtrl;
  LdWidgetState get state => _state;
  // set state(LdWidgetState pState) => _state = pState; 
  LdWidgetCtrl  get ctrl  => _ctrl;
  set ctrl(LdWidgetCtrl pCtrl) => _ctrl = pCtrl;

  // CONSTRUCCIÓ DE LA VISTA ----------
  @override
  Widget build(BuildContext pCtx) {
    return GetBuilder<LdWidgetCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      init: ctrl,
      builder: (pWCtrl) => pWCtrl.buildWidget(pCtx),
    );
  }
}
