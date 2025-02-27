// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdViewCtrl
extends LdCtrl {

  // MEMBRES --------------------------
  final List<String> wgIds = <String>[];

  // CONSTRUCTORS ---------------------
  LdViewCtrl({ required super.pState, super.pTag }) {
    if (state.isNew) {
      Debug.debug(DebugLevel.debug_0, "[LdViewCtrl]: Forçant inicialització manual del controlador");
      state.loadData();
    }
  }

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

  void resetState() {
    state.reset();
  }

  // 'GetxController' -----------------
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit]: Iniciant el controlador ${runtimeType.toString()}.");
    
    // Aquesta crida no sembla fer-se mai.
    // state.loadData();
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }

  // FUNCIONS ABSTRACTES --------------
  Widget buildView(BuildContext pCtx);

  // Updates controlats.
  @override
  void notify({List<String>? pTgts}) {
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): Notificants Widgets...");
    List<String> tgts = pTgts ?? [...wgIds, tag];
    super.notify(pTgts: tgts);
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): ...Widgets notificats.");
  }
}