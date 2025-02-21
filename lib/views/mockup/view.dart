
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_registrable_id.dart';
import 'package:ld_wbench2/core/ld_view.dart';
import 'package:ld_wbench2/translations/Tr.dart';
import 'package:ld_wbench2/views/mockup/state.dart';

import 'controller.dart';
export 'controller.dart';
export 'state.dart';

class MockupView<
  S extends MockupViewState<S, C>, 
  C extends MockupViewCtrl<C, S>>
extends LdView<S, C> {
  MockupView({super.key})
  : super(pState: LdRegistrableId.find(Get.parameters[MockupViewState.className]!)) {
    Get.parameters.remove(MockupViewState.className);
  }
}

class MockupViewBindings<
  S extends MockupViewState<S, C>, 
  C extends MockupViewCtrl<C, S>>
extends Bindings {
  @override
  void dependencies() {
    MockupViewState<S, C> state = MockupViewState<S, C>(
      pTag: MockupViewState.className, 
      pTitle: Tr.sabinaApp.tr, 
      pSubtitle: Tr.sabinaWelcome.tr,
    );
    MockupViewCtrl<C, S> ctrl = MockupViewCtrl<C, S>(pState: state as S);
    state.vCtrl = ctrl as C;
    Get.parameters[MockupViewState.className] = state.tag;
  }
}