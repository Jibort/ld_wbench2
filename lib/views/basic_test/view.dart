// lib/views/basic_test/view.dart
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view.dart';
import 'package:ld_wbench2/translations/tr.dart';
import 'package:ld_wbench2/views/basic_test/state.dart';
import 'controller.dart';
export 'controller.dart';
export 'state.dart';

class BasicTestView extends LdView<BasicTestViewState, BasicTestViewCtrl> {
  // ESTÀTICS --------------------------
  static const className = 'BasicTestView';

  // 🛠️ CONSTRUCTORS -------------------
  BasicTestView({ super.key })
  : super(pCtrl: Get.find(tag: className));
}

class BasicTestViewBinding extends Bindings {
  @override
  void dependencies() {
    final state = BasicTestViewState(
      pTitle: Tr.sabinaApp.tr,
      pSubtitle: Tr.sabinaWelcome.tr,
    );
    final ctrl = BasicTestViewCtrl(pTag: BasicTestView.className, pState: state);
    Get.put(ctrl, tag: BasicTestView.className);
  }
}