// Estat d'un widget dins el controlador d'una vista.

import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdWidgetState
extends LdState {
  // MEMBRES --------------------------
  final LdViewCtrl _vCtrl;
  String           _label;
  LdWidgetCtrl?    _wCtrl;

  // CONSTRUCTORS ---------------------
  LdWidgetState({
    required super.pTag,
    required String pLabel,
    required LdViewCtrl pVCtrl,
  }):
    _label = pLabel,
    _vCtrl = pVCtrl;

  // 📥 GETTERS/SETTERS ----------------
  LdWidgetCtrl get wCtrl {
    if (_wCtrl == null) {
      String msg = "El controlador del widget encara no ha estat assignat.";
      Debug.fatal(msg, Exception(msg));
    }
    return _wCtrl!;
  }
  set wCtrl(LdWidgetCtrl pWCtrl) => _wCtrl = pWCtrl;

  LdWidgetState get viewState => wCtrl.state as LdWidgetState;

  String get label => _label;
  set label(String pLabel) { 
    _label = pLabel;
    _vCtrl.notify(pTgts: [ wCtrl.tag ]);
  }

  // 'LdState' ------------------------
  @override bool get isNew            => (viewState.isNew);
  @override bool get isPreparing      => (viewState.isPreparing);
  @override bool get isLoading        => (viewState.isLoading);
  @override bool get isLoaded         => (viewState.isLoaded);
  @override bool get isPreparingAgain => (viewState.isPreparingAgain);
  @override bool get isLoadingAgain   => (viewState.isLoadingAgain);
  @override bool get isError          => (super.errorCode != null);


}


