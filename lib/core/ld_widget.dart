// Classe embolcall per a tots els widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id_mixin.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidget<S extends LdWidgetState, C extends LdWidgetCtrl>
extends GetWidget<C> 
with    LdIdMixin {

  // 🧩 MEMBRES ------------------------
  GetBuilder<LdViewCtrl>? _getBuilder;
  final LdViewCtrl        _viewCtrl; // Cotrolador de la vista on es renderitza el Widget.
  final S                 _state;    // Estat del Widget.
  late final C            _ctrl;     // Controlador del Widget.

  // CONSTRUCTOR ------------------
  LdWidget({ 
    super.key, 
    required LdViewCtrl pViewCtrl, 
    required S          pState,
  }): 
    _viewCtrl = pViewCtrl,
    _state    = pState;

  // GETTERS/SETTERS ------------------
  LdViewCtrl    get viewCtrl  => _viewCtrl;
  LdViewState   get viewState => _viewCtrl.state;

  S get state => _state;
  C  get ctrl  => _ctrl;
  set ctrl(C pCtrl) { _ctrl = pCtrl; state.ctrl = _ctrl; }

  // CONSTRUCCIÓ DE LA VISTA ----------
  @override
  Widget build(BuildContext pCtx) {
    _getBuilder ??= GetBuilder<LdViewCtrl>( // GetBuilder<LdViewCtrl>(
      id: ctrl.tag,
      tag: ctrl.tag,
      init: viewCtrl,
      builder: (pWCtrl) => _ctrl.buildWidget(pCtx),
    );
    return _getBuilder!; 
  }
}
