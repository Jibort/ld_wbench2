// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdViewCtrl<
  C extends LdViewCtrl<C, S>, 
  S extends LdViewState<S, C>> 
extends LdCtrl<C, S> {
  // MEMBRES --------------------------
  final List<String> wgIds = <String>[];

  // CONSTRUCTORS ---------------------
  LdViewCtrl({ required super.pState, super.pTag });

  // GESTIÓ DE WIDGETS ----------------
  void addWidgets(List<String> pWgIds) {
    for (var wgId in pWgIds) {
      if (!wgIds.contains(wgId)) {
        wgIds.add(wgId);
      } else {
        Debug.error("${runtimeType.toString()}.addWidgets(): widget ja existeix: '$wgId'", null);
      }
    }
  }

  void notify({List<String>? pTgts}) {
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): Notificants Widgets...");
    List<String> tgts = pTgts ?? wgIds;
    for (var wgId in tgts) {
      update([wgId], true);
    }
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): ...Widgets notificats.");
  }

  // 
  void resetState() {
    state.dataReset();
  }

  // 'GetxController' -----------------
  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    state.loadData();
    Debug.debug(DebugLevel.debug_1, "[onReady]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }

  // FUNCIONS ABSTRACTES --------------
  Widget buildView(BuildContext pCtx);
}