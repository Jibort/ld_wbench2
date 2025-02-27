// Classe embolcall per a tots els controladors de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id_mixin.dart';
import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdCtrl
extends GetxController 
with LdIdMixin {

  // 📝 ESTÀTICS -----------------------
  static const className = "LdCtrl";

  // 🧩 MEMBRES ------------------------
  final LdState _state;

  // 🛠️ CONSTRUCTORS -------------------
  LdCtrl({ String? pTag, required LdState pState })
  : _state = pState {
    
    tag = pTag?? "${className}_$id";
    pState.ctrl = this;
    Get.put(this, tag: tag,  permanent: false);
    Debug.debug(DebugLevel.debug_0, "[LdController]: ...controlador '$tag' creat.");
  }

  // 📥 GETTERS/SETTERS ----------------
  LdState get state => _state;

  // 🔄 'GetLifeCycleMixin' ------------
  // Quan el controlador ha estat inicialitzat.
  @override
  void onInit() {
    super.onInit();
    // Aquesta crida no sembla fer-se mai.
    // _state.loadData();
    Debug.debug(DebugLevel.debug_1, "[onInit.$typeName]: El controlador '$typeName(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    Debug.debug(DebugLevel.debug_1, "[onReady.$typeName]: La interfície gràfica del widget $typeName està completament carregada.");
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady.$typeName]: La interfície gràfica del controlador $typeName està completament carregada.");
  }

  // Quan el controlador s'està destruint
  @override
  void onClose() {
    Get.delete(tag: tag, force: true);
    Debug.debug(DebugLevel.debug_1, "[onClose]: El controlador '$typeName(tag: $tag)' s'està destruint.");
    super.onClose();
  }

  // Updates controlats.
  void notify({List<String>? pTgts}) {
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): Notificants Widgets...");
    if (pTgts != null) {
      for (var wgId in pTgts) {
        update([wgId], true);
      }
    }
    Debug.debug(DebugLevel.debug_4, "${runtimeType.toString()}.notify(): ...Widgets notificats.");
  }
}