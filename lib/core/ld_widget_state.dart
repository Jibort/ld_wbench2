

import 'package:get/get_instance/src/lifecycle.dart';
import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdWidgetState<
  S extends LdWidgetState<S, C>, 
  C extends LdWidgetCtrl<C, S>>
extends LdState<S, C> {
  // MEMBRES --------------------------
  final LdViewCtrl _vCtrl;
  String _label;
  C? _wCtrl;

  // CONSTRUCTORS ---------------------
  LdWidgetState({
    required super.pTag,
    required String pLabel,
    required LdViewCtrl pVCtrl,
  }):
    _label = pLabel,
    _vCtrl = pVCtrl;

  // GETTERS/SETTERS ------------------
  C get wCtrl {
    if (_wCtrl == null) {
      String msg = "El controlador del widget encara no ha estat assignat a l'estat '$tag'.";
      Debug.fatal(msg, Exception(msg));
    }
    return _wCtrl!;
  }
  set wCtrl(C pWCtrl) => _wCtrl = pWCtrl;

  String get label => _label;
  set label(String pLabel) { 
    _label = pLabel;
    _vCtrl.notify(pTgts: [ tag ]);
  }

  @override
  void onClose() {
    super.onClose();
    Debug.debug(DebugLevel.debug_6, "🗑️ [LdWidgetState] onClose per defecte");
  }

  @override void $configureLifeCycle()  => throw UnimplementedError();
  @override bool get initialized => throw UnimplementedError();
  @override bool get isClosed => throw UnimplementedError();
  @override bool get isError => throw UnimplementedError();
  @override bool get isLoaded => throw UnimplementedError();
  @override bool get isLoading => throw UnimplementedError();
  @override bool get isLoadingAgain => throw UnimplementedError();
  @override bool get isNew => throw UnimplementedError();
  @override bool get isPreparing => throw UnimplementedError();
  @override bool get isPreparingAgain => throw UnimplementedError();
  
  @override InternalFinalCallback<void> get onStart => throw UnimplementedError();
  @override InternalFinalCallback<void> get onDelete => throw UnimplementedError();
  @override void onInit() => throw UnimplementedError();
  @override void onReady() => throw UnimplementedError();

}


