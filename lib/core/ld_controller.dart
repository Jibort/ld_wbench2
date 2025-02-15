// Classe embolcall per a tots els controladors de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdController extends GetxController with LdId {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdController> _ctrls = LiFoMap<LdController>(pMaxLength: 50);
  static const className = "LdController";

  // CONSTRUCTORS --------------------- 
  LdController({ String? pTag }): super() {
    tag = pTag ?? "${type}_$id";
    Debug.debug(DebugLevel.debug_0, "[LdController]: Creant controlador '$tag'...");
    _ctrls.push(tag, this);
    Get.put(this, tag: tag,permanent: true);
    Debug.debug(DebugLevel.debug_0, "[LdController]: Controlador '$tag' creda.");
  }

  static LdController put(LdController pCtrl, {bool pPerm = true}) {
    LdController? existing = _ctrls.find(pCtrl.tag);
    if (existing != null) return existing;

    _ctrls.push(pCtrl.tag, pCtrl);
    return Get.put(pCtrl, tag: pCtrl.tag, permanent: pPerm);
  }

  static Future<LdController> putAsync(Future<LdController> Function() pBuilder, {required String pTag}) async {
    LdController inst = await pBuilder();
    
    _ctrls.push(inst.tag, inst);
    Get.put(inst, tag: pTag, permanent: true);
    return inst;
  }

  static LdController? findOrNull(String pTag) => 
  _ctrls.find(pTag)
    ?? (Get.isRegistered(tag: pTag) 
      ? Get.find(tag: pTag) 
      : null);

  static LdController find(String pTag) {
    LdController? ctrl = _ctrls.find(pTag);
    if (ctrl == null) {
      var msg = "El controlador '$pTag' no està enregistrat!";
      Debug.fatal(msg, Exception(msg));
    }
    return ctrl!;
  }

  static void delete(String pTag) {
    if (_ctrls.remove(pTag)) {
      Debug.info("[LdController]: Eliminat controlador '$pTag'.");
      Get.delete(tag: pTag, force: true);
    }
  }

  // CICLE DE VIDA --------------------
  // Quan el controlador ha estat inicialitzat
  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit]: El controlador '$type(tag: $tag)' ha estat inicialitzat.");
  }

  // Quan el controlador s'està destruint
  @override
  void onClose() {
    Debug.debug(DebugLevel.debug_1, "[onClose]: El controlador '$type(tag: $tag)' s'està destruint.");
    delete(tag);

    super.onClose();
  }

  // Quan la interfície gràfica del controlador està completament carregada
  @override
  void onReady() {
    super.onReady();
    Debug.debug(DebugLevel.debug_1, "[onReady]: La interfície gràfica del controlador ${runtimeType.toString()} està completament carregada.");
  }
}