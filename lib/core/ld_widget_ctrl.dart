

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

abstract class LdWidgetCtrl<
  C extends LdWidgetCtrl<C, S>, 
  S extends LdWidgetState<S, C>> 
extends LdCtrl<C, S> {
  // CONSTRUCTORS ---------------------
  LdWidgetCtrl({ required super.pState, super.pTag });

  // GETTERS/SETTERS ------------------
  S get wState => super.state;

  // FUNCIONS ABSTRACTES --------------
  Widget buildWidget(BuildContext pCtx);
}