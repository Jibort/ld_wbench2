// Vista de prova per a formularis.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view.dart';
import 'package:ld_wbench2/views/form_test/controller.dart';
import 'package:ld_wbench2/views/form_test/state.dart';

export 'controller.dart';
export 'state.dart';

class FormTestView extends LdView<FormTestViewCtrl> {
  // ESTÀTICS --------------------------
  static const className = 'FormTestView';

  // 🛠️ CONSTRUCTORS -------------------
  FormTestView({ super.key })
  : super(pCtrl: Get.find(tag: className));
}

class FormTestViewBinding extends Bindings {
  @override
  void dependencies() {
    final state = FormTestViewState(
      pTitle: 'Test de Formulari',
      pSubtitle: 'Prova dels nous LdWidgets'
    );
    final ctrl = FormTestViewCtrl(pTag: FormTestView.className, pState: state);
    Get.put(ctrl, tag: FormTestView.className);
  }
}