
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view.dart';
import 'package:ld_wbench2/translations/tr.dart';
import 'package:ld_wbench2/views/mockup/state.dart';

import 'controller.dart';
export 'controller.dart';
export 'state.dart';

class MockupView
extends LdView<MockupViewCtrl> {
  // ESTÀTICS --------------------------
  static const className = 'MockupView';

  // 🛠️ CONSTRUCTORS -------------------
  MockupView({ super.key })
  : super(pCtrl: Get.find(tag: className)) {
    Get.delete(tag: className, force: true);
    Get.put(ctrl, tag: ctrl.tag, permanent: true);
  }
}

class MockupViewBinding extends Binding {
  @override
  List<Bind> dependencies() {
    final state = MockupViewState(pTitle: Tr.sabinaApp.tr, pSubtitle: Tr.sabinaWelcome.tr);
    final ctrl = MockupViewCtrl(pTag: MockupView.className, pState: state);
    return [ Bind.put(ctrl, tag: MockupView.className) ];
  }
}