// Classe embolcall per a tots els serveis de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ


import 'package:ld_wbench2/core/ld_id.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdService extends GetxService with LdId {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdService> _services = LiFoMap<LdService>();

  // CONSTRUCTORS ---------------------
  LdService({String? pTag}) {
    tag = pTag ?? "${type}_$id";
    Debug.debug(DebugLevel.debug_0, "[LdService]: Creant servei '$tag'...");
    _services.push(tag, this);
    Get.put(this, tag: tag,permanent: true);
    Debug.debug(DebugLevel.debug_0, "[LdService]: Servei '$tag' creat.");
  }

  // GESTIÓ DE SERVEIS ----------------
  static LdService? put(LdService pServ, {required String tag, bool pPerm = true}) {
    LdService? existing = _services.find(pServ.tag);
    if (existing != null) return existing;

    _services.push(pServ.tag, pServ);
    return Get.put(pServ, tag: pServ.tag, permanent: pPerm);
  }

  static Future<LdService> putAsync(Future<LdService> Function() pBuilder, {required String pTag}) async {
    LdService inst = await pBuilder();
    Get.put(inst, tag: pTag, permanent: true);
    return inst;
  }

  static LdService? findOrNull(String pTag) => 
  _services.find(pTag)
    ?? (Get.isRegistered(tag: pTag) 
      ? Get.find(tag: pTag) 
      : null);

  static LdService find(String pTag) {
    LdService? ctrl = _services.find(pTag);
    if (ctrl == null) {
      var msg = "El servei '$pTag' no està enregistrat!";
      Debug.fatal(msg, Exception(msg));
    }
    return ctrl!;
  }

  static void delete(String pTag) {
    if (_services.remove(pTag)) {
      Debug.info("[LdService]: Eliminant servei '$pTag'...");
      Get.delete(tag: pTag, force: true);
    }
  }

  // CICLE DE VIDA --------------------
  // Quan el servei ha estat inicialitzat
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit]: El servei '$type(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan el servei s'està destruint
  @override
  void onClose() {
    delete(tag);
    Debug.debug(DebugLevel.debug_1, "[onClose]: El servei '$tag' s'està destruint.");
    super.onClose();
  }

  // Quan el servei està completament carregat
  @override
  void onReady() {
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady]: El servei ${runtimeType.toString()} està completament carregada.");
  }
}
