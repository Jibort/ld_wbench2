// Widget del Botó genèric de l'aplicació.
// CreatedAt: 2025/02/19 dc. JIQ

import 'package:get/get_instance/src/lifecycle.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

class LdButton<S extends LdWidgetState<S, C>, C extends LdWidgetCtrl<C, S>> 
extends LdWidget<S, C> {
  LdButton({
    super.key, 
    required super.pState, 
    required super.pVCtrl, 
    required super.pTag
  });


  @override
  // TODO: implement initialized
  bool get initialized => throw UnimplementedError();

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => throw UnimplementedError();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => throw UnimplementedError();
  
}