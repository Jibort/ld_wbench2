// Classe embolcall per a tots els widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable_id.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidget<
  S extends LdWidgetState<S, C>, 
  C extends LdWidgetCtrl<C, S>> 
extends GetWidget<S> 
with    LdRegistrableId, GetLifeCycleBase {

  // MEMBRES ---------------------
  final LdViewCtrl _vCtrl; // Cotrolador de la vista on es renderitza el Widget.
  final S          _state; // Estat del Widget.
  final C          _ctrl;  // Controlador del Widget.

  // CONSTRUCTOR ------------------
  LdWidget({ 
    super.key, 
    required S pState,
    required LdViewCtrl pVCtrl, 
    String? pTag, 
  }): 
    _vCtrl = pVCtrl,
    _state = pState, 
    _ctrl =  pState.wCtrl {
      register(pTag);
    }

  // GETTERS/SETTERS ------------------
  LdViewCtrl get vCtrl => _vCtrl;
  S get state => _state;
  C get ctrl => _ctrl;

  // CONSTRUCCIÓ DE LA VISTA ----------
  @override
  @mustCallSuper
  Widget build(BuildContext pCtx) {
    return GetBuilder<C>(
      id: ctrl.tag,
      tag: ctrl.tag,
      init: ctrl,
      builder: (vCtrl) => vCtrl.buildWidget(pCtx),
    );
  }
}
