// Classe embolcall per a tots els controladors de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable_id.dart';
import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdCtrl<
  C extends LdCtrl<C, S>, 
  S extends LdState<S, C>> 
extends GetxController 
with LdRegistrableId {
  // ESTÀTICS -------------------------
  static const className = "LdController";

  // MEMBRES --------------------------
  S _state;

  // CONSTRUCTORS --------------------- 
  LdCtrl({ String? pTag, required S pState })
  : _state = pState {
    register(pTag);
    Debug.debug(DebugLevel.debug_0, "[LdController]: ...controlador '$tag' creat.");
  }

  // GETTERS/SETTERS ------------------
  S get state => _state;
  set vState (S pState) => _state = pState;

  // CICLE DE VIDA --------------------
  // Configura el cicle de vida el controlador.
  @override
  void $configureLifeCycle() {
    Debug.debug(DebugLevel.debug_5, "🔄 [${runtimeType.toString()}] Configurant cicle de vida...");
    super.$configureLifeCycle();
  }

  // Quan el controlador ha estat inicialitzat.
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit.$type]: El controlador '$type(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    _state.loadData();
    Debug.debug(DebugLevel.debug_1, "[onReady.$type]: La interfície gràfica del widget ${runtimeType.toString()} està completament carregada.");
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady.$type]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }

  // Quan el controlador s'està destruint
  @override
  void onClose() {
    Debug.debug(DebugLevel.debug_1, "[onClose]: El controlador '$type(tag: $tag)' s'està destruint.");
    super.onClose();
  }
}