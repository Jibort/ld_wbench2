// Classe base dels controladors de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdViewCtrl
extends LdCtrl<LdViewCtrl, LdViewState> {

  // 🧩 MEMBRES --------------------------
  final List<String> wgIds = <String>[];

  // 🛠️ CONSTRUCTORS ---------------------
  LdViewCtrl({ required super.pState, required super.pTag }) {
    if (state.isNew) {
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
    
    // Aquesta crida no sembla fer-se mai.
    // state.loadData();
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
  }

  // FUNCIONS ABSTRACTES --------------
  Widget buildView(BuildContext pCtx);

  // Updates controlats.
  @override
  void notify({List<String>? pTgts}) {
    List<String> tgts = pTgts ?? [...wgIds, tag];
    super.notify(pTgts: tgts);
  }
}