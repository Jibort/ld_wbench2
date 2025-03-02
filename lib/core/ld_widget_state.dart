// Estat d'un widget dins el controlador d'una vista.

import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdWidgetState
extends LdState<LdWidgetState, LdWidgetCtrl> {
  // 🧩 MEMBRES --------------------------
  final LdViewCtrl  _viewCtrl;
  final LdViewState _viewState;
  String            _label;
  LdWidgetCtrl?     _widgetCtrl;

  // 🛠️ CONSTRUCTORS ---------------------
  LdWidgetState({
    required String      pLabel,
    required LdViewState pViewState,
    required LdViewCtrl  pViewCtrl,
  }):
    _label = pLabel,
    _viewState = pViewState,
    _viewCtrl = pViewCtrl;

  // 📥 GETTERS/SETTERS ----------------
  LdWidgetCtrl get widgetCtrl {
    if (_widgetCtrl == null) {
      String msg = "El controlador del widget encara no ha estat assignat.";
      Debug.fatal(msg, Exception(msg));
    }
    return _widgetCtrl!;
  }
  set widgetCtrl(LdWidgetCtrl pWCtrl) => _widgetCtrl = pWCtrl;

  LdViewState get viewState => _viewState;
  LdViewCtrl get  viewCtrl  => _viewCtrl;

  String get label => _label;
  set label(String pLabel) { 
    _label = pLabel;
    _viewCtrl.notify(pTgts: [ widgetCtrl.tag ]);
  }

  // 'LdState' ------------------------
  @override bool get isNew            => (viewState.isNew);
  @override bool get isPreparing      => (viewState.isPreparing);
  @override bool get isLoading        => (viewState.isLoading);
  @override bool get isLoaded         => (viewState.isLoaded);
  @override bool get isPreparingAgain => (viewState.isPreparingAgain);
  @override bool get isLoadingAgain   => (viewState.isLoadingAgain);
  @override bool get isError          => (super.errorCode != null);

} // abstract class LdWidgetState


