// Classe genèrica per a totes les vistes de l'aplicació.
// CreateAt: 2025/02/17 ds. JIQ

import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdView<S extends LdViewState<S, C>, C extends LdViewController<C, S>> extends LdViewState<S, C> {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdView> _views = LiFoMap<LdView>(pMaxLength: 100);
  static const className = "LdView";

  // CONSTRUCTORS ---------------------
  LdView({ 
    super.key, 
    required super.pTitle, 
    super.pSubtitle, 
    required super.pTag
  });

  // GETTERS/SETTERS ------------------
  List<LdView> get views => _views.list;
  
}