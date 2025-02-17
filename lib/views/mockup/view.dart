
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable.dart';
import 'package:ld_wbench2/core/ld_scaffold.dart';
import 'package:ld_wbench2/core/ld_view.dart';
import 'package:ld_wbench2/views/mockup/state.dart';

import 'controller.dart';

class MockupView extends LdView<MockupViewState, MockupViewController> {
  MockupView({super.key}) : super(pState: LdRegistrable.find(Get.parameters[MockupViewState.className]!)) {
    Get.parameters.remove(MockupViewState.className);
  }

  @override
  Widget build(BuildContext pCtx) {
    return LdScaffold(
      pVCtrl: ctrl,
      // appBar: LdAppBar(title: "Vista Mockup", pVCtrl: ctrl),
      pBody: ctrl.buildView(pCtx),

    );
  }
}

class MockupViewBindings extends Bindings {
  @override
  void dependencies() {
    MockupViewState state = MockupViewState(pTag: MockupViewState.className, pTitle: "Mockup View", pSubtitle: "Vista de proves");
    MockupViewController ctrl = MockupViewController(pState: state);
    state.vCtrl = ctrl;
    Get.parameters[MockupViewState.className] = state.tag;
  }
}