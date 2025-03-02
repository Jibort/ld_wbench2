// Classe controladora de Widgets.
// CreatedAt: 2025/02/21 dv. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidgetCtrl
extends LdCtrl<LdWidgetCtrl, LdWidgetState> {
  
  // 📝 ESTÀTICS -----------------------
  static const className = "LdWidgetCtrl";

  // 🧩 MEMBRES ------------------------
  final LdViewCtrl _viewCtrl;
  
  // 🛠️ CONSTRUCTORS ---------------------
  LdWidgetCtrl({ required super.pTag, required LdViewCtrl pViewCtrl, required super.pState })
  : _viewCtrl = pViewCtrl;

  // GETTERS/SETTERS ------------------
  LdWidgetState get widgetState => super.state;
  LdViewCtrl    get viewCtrl    => _viewCtrl;

  // FUNCIONS ABSTRACTES --------------
  Widget buildWidget(BuildContext pCtx);

} // abstract class LdWidgetCtrl