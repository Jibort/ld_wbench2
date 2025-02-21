// Controlador del Widget LdScaffold.
// CreatedAt: 2025/02/20 dj. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/widgets/ld_app_bar.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_ctrl.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_state.dart';
import 'package:ld_wbench2/widgets/ld_scaffold_state.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';

class LdScaffoldCtrl<
  C extends LdScaffoldCtrl<C, S, CA, SA, CV, SV>, 
  S extends LdScaffoldState<S, C, SA, CA, SV, CV>,
  CA extends LdAppBarCtrl<CA, SA, CV, SV>,
  SA extends LdAppBarState<SA, CA, SV, CV>,
  CV extends LdViewCtrl<CV, SV>,
   SV extends LdViewState<SV, CV>>
extends LdWidgetCtrl<C, S> {
  // MEMBRES --------------------------
  LdAppBar<SA, CA>? _appBar;

  // CONSTRUCTORS ---------------------
  LdScaffoldCtrl({ required super.pState, super.pTag });

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    _appBar ??= LdAppBar<SA, CA>(pTag: tag, pVCtrl: this);

      LdAppBarState(pTitle: pTitle, pTag: pTag, pVCtrl: pVCtrl, pLabel: pLabel));

    // TODO: Crear el widget de tipo Scaffold
    throw UnimplementedError();
  }}