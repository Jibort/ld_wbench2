// Classe genèrica per a totes les vistes de l'aplicació.
// CreateAt: 2025/02/17 ds. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdView<S extends LdViewState<S, C>, C extends LdViewController<C, S>> extends GetView<S> {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdView> _views = LiFoMap<LdView>(pMaxLength: 100);
  static const className = "LdView";

  // MEMBRES --------------------------
  final S _state;
  final C _ctrl;

  // CONSTRUCTORS ---------------------
  LdView({ 
    super.key, 
    required S pState
  }): _state = pState, _ctrl = pState.vCtrl;

  // GETTERS/SETTERS ------------------
  List<LdView> get views => _views.list;
  S get state => _state;
  C get ctrl => _ctrl;

}