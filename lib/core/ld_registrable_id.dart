// Mixin que unifica LdId i LdRegistrable per a simplificar la gestió d'identificadors i registre.
// CreatedAt: 2025/02/18 dt. GPT[JIQ]

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

// Mixin per a la identificació universal d'instàncies i el seu registre.
mixin      LdRegistrableId 
implements DisposableInterface {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdRegistrableId> _map = LiFoMap<LdRegistrableId>();
  static int _counter = 0;

  // MEMBRES --------------------------
  final int _id = _counter++;
  late final Type _type;
  late String _tag;

  // GETTERS/SETTERS ------------------
  int get id => _id;
  Type get type => _type;
  String get tag => _tag;
  set tag(String pTag) => _tag = pTag;

  // GESTIÓ DEL REGISTRE D'INSTÀNCIA --
  void register(String? pTag) {
    _type = runtimeType;
    _tag = pTag?? "${_type.toString()}_$_id";
    Debug.debug(DebugLevel.debug_3, "[LdRegId(${_type.toString()})]: Registrant '$tag'...");
    _map.push(tag, this);
    Get.put(this, tag: tag, permanent: true);
    Debug.debug(DebugLevel.debug_3, "[LdRegId(${_type.toString()})]: ...Registrat '$tag'");
  }

  // GESTIÓ DEL REGISTRE ESTÀTIC ------
  static T put<T extends LdRegistrableId>(T pInst, {String? pTag, bool pPerm = true}) {
    var tag = pTag ?? "${pInst.runtimeType.toString()}_${pInst.id}";
    Debug.debug(DebugLevel.debug_3, "[LdRegId(${pInst._type.toString()})]: Registrant '$tag'...");
    _map.push(tag, pInst);
    T ret = Get.put(pInst, tag: tag, permanent: pPerm);
    Debug.debug(DebugLevel.debug_3, "[LdRegId(${pInst._type.toString()})]: ...Registrat '$tag'");
    return ret;
  }

  static T? findOrNull<T extends LdRegistrableId>(String pTag) =>
    (_map.find(pTag) as T?) ?? (Get.isRegistered<T>(tag: pTag) ? Get.find<T>(tag: pTag) : null);

  static T find<T extends LdRegistrableId>(String pTag) {
    final T? inst = findOrNull<T>(pTag);
    if (inst == null) {
      var msg = "[LdRegId]: '$pTag' no està enregistrat!";
      Debug.fatal(msg, Exception(msg));
    }
    return inst as T;
  }

  static void delete<T extends LdRegistrableId>(String pTag) {
    if (_map.remove(pTag)) {
      Get.delete(tag: pTag, force: true);
      Debug.info("[LdRegId]: Eliminat '$pTag'.");
    }
  }

  @override
  @mustCallSuper
  void onClose() {
    delete<LdRegistrableId>(tag);
    Debug.info("[LdRegId]: '$tag' s'està destruint.");
  }
}