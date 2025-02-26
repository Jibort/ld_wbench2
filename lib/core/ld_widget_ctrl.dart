// Classe controladora de Widgets.
// CreatedAt: 2025/02/21 dv. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidgetCtrl
extends LdCtrl {
  
  // 📝 ESTÀTICS -----------------------
  static const className = "LdWidgetCtrl";

// MEMBRES --------------------------
  final LdViewCtrl _viewCtrl;
  
  // CONSTRUCTORS ---------------------
  LdWidgetCtrl({ required LdViewCtrl pVCtrl, required super.pState, super.pTag })
  : _viewCtrl = pVCtrl;

  // GETTERS/SETTERS ------------------
  LdWidgetState get wState   => super.state as LdWidgetState;
  LdViewCtrl    get viewCtrl => _viewCtrl;

  // FUNCIONS ABSTRACTES --------------
  Widget buildWidget(BuildContext pCtx);
}