// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_controller.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';

abstract class LdViewController<C extends LdViewController<C, S>, S extends LdViewState<S, C>> extends LdController {
  // MEMBRES --------------------------
  final S _vState;

  // CONSTRUCTORS ---------------------
  LdViewController({ required S pState, super.pTag })
  : _vState = pState;

  // GETTERS/SETTERS ------------------
  S get vState => _vState;

  // FUNCIONS ABSTRACTES --------------
  Widget buildView(BuildContext pCtx);
}