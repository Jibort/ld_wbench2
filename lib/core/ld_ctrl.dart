// Classe patró per a tots els controladors de vistes i widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id_mixin.dart';
import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';

abstract class LdCtrl<
  C extends LdCtrl<C, S>,
  S extends LdState<S, C>>
extends  GetxController 
with     LdIdMixin {

  // 📝 ESTÀTICS -----------------------
  static const className = "LdCtrl";

  // 🧩 MEMBRES ------------------------
  final S _state;

  // 🛠️ CONSTRUCTORS -------------------
  LdCtrl({ required String pTag, required S pState })
  : _state = pState {
    tag = pTag;
    typeName = className;
    pState.ctrl = this as C;
    if (this is LdWidgetCtrl) {
      Get.put<LdWidgetCtrl>(this as LdWidgetCtrl, tag: tag,  permanent: true);
    } else if (this is LdViewCtrl) {
      Get.put<LdViewCtrl>(this as LdViewCtrl, tag: tag,  permanent: true);
    } else {
      Get.put<LdCtrl>(this, tag: tag,  permanent: true);
    }
  }

  // 📥 GETTERS/SETTERS ----------------
  S get state => _state;

  // 🔄 'GetLifeCycleMixin' ------------
  @override
  void onClose() {
    // implementació arrel.
    Debug.debug(DebugLevel.debug_9, "Eliminant controlador '$tag' de GetX.");
    Get.delete(tag: tag, force: true);
  }

  // Updates controlats ---------------
  void notify({List<String>? pTgts}) {
    if (pTgts != null) {
      for (var wgId in pTgts) {
        update([wgId], true);
      }
    }
  }

} // abstract class LdCtrl