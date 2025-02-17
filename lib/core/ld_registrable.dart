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

  // Afegeix una nova instància.
  static void put(LdRegistrable pInst, { String? pTag }) {
    var tag = pTag ?? "${pInst.runtimeType.toString()}_$pInst.id";
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: Registrant '$tag'...");
    _map.push(tag, pInst);
    Get.put(pInst, tag: tag, permanent: true);
    Debug.debug(DebugLevel.debug_3, "[LdRegistrable]: ...Registrat '$tag'");
  }

  // 🔹 Enregistra una instància pel seu `tag`
  static T? findOrNull<T extends LdRegistrable>(String pTag) =>
      (_map.find(pTag) as T?)?? (Get.isRegistered<T>(tag: pTag) ? Get.find<T>(tag: pTag) : null);

  // 🔹 Cerca una instància pel seu `tag`
  static T find<T extends LdRegistrable>(String pTag) {
    final instance = _map.find(pTag)?? (Get.isRegistered<T>(tag: pTag) ? Get.find<T>(tag: pTag) : null);
    if (instance == null) {
      var msg = "El registre '$pTag' no existeix!";
      Debug.fatal(msg, Exception(msg));
    }
    return instance as T;
  }

  // 🔹 Elimina un element del registre
  static void delete(String pTag) {
    if (_map.remove(pTag)) {
      Get.delete(tag: pTag, force: true);
      Debug.info("[LdRegistrable]: Eliminat '$pTag'.");
    }
  }

  @override
  void onClose() {
    Debug.info("[LdRegistrable]: '$tag' s'està destruint.");
    delete(tag);
    super.onClose();
  }
}
