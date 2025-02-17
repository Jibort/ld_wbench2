// Mixin per a abstraure la funcionalitat de registre per a LdService, LdDeep i LdController.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

mixin LdRegistrable
on LdId, DisposableInterface {
  // 🔹 Llista FIFO per mantenir el registre
  static final LiFoMap<LdRegistrable> _map = LiFoMap<LdRegistrable>();

  // FUNCIONALITAT ESTÀTICA -----------
  // 🔹 Registra un element amb `tag`
  void register(String? pTag) {
    tag = pTag ?? "${runtimeType}_$id";
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: Registrant '$tag'...");
    _map.push(tag, this);
    Get.put(this, tag: tag, permanent: true);
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: ...Registrat '$tag'");
  }

  // Registra una instància de manera síncrona
  static T put<T extends LdRegistrable>(T pInst, {String? pTag, bool pPerm = true}) {
    var tag = pTag ?? "${pInst.runtimeType.toString()}_$pInst.id";
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: Registrant '$tag'...");
    _map.push(tag, pInst);
    T ret = Get.put(pInst, tag: pTag, permanent: pPerm);
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: ...Registrat '$tag'");
    return ret;
  }

  // Retorna la instància enregistrada o nul.
  static T? findOrNull<T extends LdRegistrable>(String pTag) =>
      (_map.find(pTag) as T?)?? (Get.isRegistered<T>(tag: pTag) ? Get.find<T>(tag: pTag) : null);

  // Retorna la instància enregistrat o llança una excepción.
  static T find<T extends LdRegistrable>(String pTag) {
    final instance = findOrNull<T>(pTag);
    if (instance == null) {
      var msg = "[LdRegistrable]: '$pTag' no està enregistrat!";
      Debug.fatal(msg, Exception(msg));
    }
    return instance as T;
  }

  // 🔹 Elimina un element del registre
  static void delete<T extends LdRegistrable>(String pTag) {
    if (_map.remove(pTag)) {
      Get.delete(tag: pTag, force: true);
      Debug.info("[LdRegistrable]: Eliminat '$pTag'.");
    }
  }

  @override
  void onClose() {
    delete<LdRegistrable>(tag);
    Debug.info("[LdRegistrable]: '$tag' s'està destruint.");
    super.onClose();
  }
}
