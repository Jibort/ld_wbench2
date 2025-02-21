// Estat del widget LdScaffold.
// CreatedAt: 2025/02/19 dc. JIQ

import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_ctrl.dart';

class LdAppBarState<
  S extends LdAppBarState<S, C, SV, CV>, 
  C extends LdAppBarCtrl<C, S, CV, SV>,
  SV extends LdViewState<SV, CV>,
  CV extends LdViewCtrl<CV, SV>>
extends LdWidgetState<S, C> {
  // MEMBRES --------------------------
  String _title;
  String? _subtitle;

  // CONSTRUCTORS ---------------------
  LdAppBarState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pTag, 
    required super.pVCtrl, 
    required super.pLabel, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle;
    
  @override
  void loadData() {
    // TODO: implement loadData
  }

  // GETTERS/SETTERS ------------------
  String get title => _title;
  set title(String value) => _title = value;

  String? get subtitle => _subtitle;
  set subtitle(String? value) => _subtitle = value;

}