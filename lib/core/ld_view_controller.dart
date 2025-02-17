// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_controller.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdViewController<C extends LdViewController<C, S>, S extends LdViewState<S, C>> 
extends LdController {
  // MEMBRES --------------------------
  final List<String> wgIds = <String>[];
  final S _vState;

  // CONSTRUCTORS ---------------------
  LdViewController({ required S pState, super.pTag })
  : _vState = pState;

  // GETTERS/SETTERS ------------------
  S get vState => _vState;

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
    vState.dataReset();
  }

  // 'GetxController' -----------------
  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    vState.loadData();
    Debug.debug(DebugLevel.debug_1, "[onReady]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }

  // FUNCIONS ABSTRACTES --------------
  Widget buildView(BuildContext pCtx);
}