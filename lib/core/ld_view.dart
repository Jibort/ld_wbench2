// Classe genèrica per a totes les vistes de l'aplicació.
// CreateAt: 2025/02/17 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable_id.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdView<
  S extends LdViewState<S, C>, 
  C extends LdViewCtrl<C, S>> 
extends GetView<S>
with LdRegistrableId {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdView> _views = LiFoMap<LdView>(pMaxLength: 100);
  static const className = "LdView";

  // MEMBRES --------------------------
  final S _state;
  final C _ctrl;

  // CONSTRUCTORS ---------------------
  LdView({ 
    super.key, 
    required S pState
  }): _state = pState, _ctrl = pState.vCtrl;

  // GETTERS/SETTERS ------------------
  List<LdView> get views => _views.list;
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
      builder: (vCtrl) => vCtrl.buildView(pCtx),
    );
  }
  
  @override void $configureLifeCycle() => throw UnimplementedError();
  @override bool get initialized => throw UnimplementedError();
  @override bool get isClosed => throw UnimplementedError();
  @override InternalFinalCallback<void> get onDelete => throw UnimplementedError();
  @override void onInit() => throw UnimplementedError();
  @override void onReady() => throw UnimplementedError();
  @override InternalFinalCallback<void> get onStart => throw UnimplementedError();
}