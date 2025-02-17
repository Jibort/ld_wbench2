// Classe embolcall per a tots els serveis de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ


import 'package:ld_wbench2/core/ld_id.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdService
extends GetxService
with LdId, LdRegistrable { 
  // ESTÀTICS -------------------------
  static const className = "LdService";

  // CONSTRUCTORS ---------------------
  LdService({ String? pTag }) {
    rtType = className;
    register(pTag);
    Debug.debug(DebugLevel.debug_0, "[LdService]: Servei '$tag' creat.");
  }

  // CICLE DE VIDA --------------------
  // Quan el servei ha estat inicialitzat
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit]: El servei '$type(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan el servei està completament carregat
  @override
  void onReady() {
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady]: El servei ${runtimeType.toString()} està completament carregat.");
  }
  
  // Quan el servei s'està destruint
  @override
  void onClose() {
    Debug.debug(DebugLevel.debug_1, "[onClose]: El servei '$tag' s'està destruint.");
    super.onClose();
  } 
}
