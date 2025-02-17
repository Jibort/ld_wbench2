// Classe embolcall per a tots els controladors de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/core/ld_registrable.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdController
extends GetxController 
with LdId, LdRegistrable {
  // ESTÀTICS -------------------------
  static const className = "LdController";

  // CONSTRUCTORS --------------------- 
  LdController({ String? pTag }) {
    rtType = className;
    register(pTag);
    Debug.debug(DebugLevel.debug_0, "[LdController]: ...controlador '$tag' creat.");
  }

  // CICLE DE VIDA --------------------
  // Quan el controlador ha estat inicialitzat
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit]: El controlador '$type(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }

  // Quan el controlador s'està destruint
  @override
  void onClose() {
    Debug.debug(DebugLevel.debug_1, "[onClose]: El controlador '$type(tag: $tag)' s'està destruint.");
    super.onClose();
  }
}