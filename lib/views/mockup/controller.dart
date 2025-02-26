// Vista mockup per a demostrar el funcionament de LdScaffold i LdAppBar.
// CreatedAt: 2025/02/16 dg. JIQ

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/views/widget_key.dart';

class MockupViewCtrl
extends LdViewCtrl {
  // 🛠️ CONSTRUCTORS -------------------
  MockupViewCtrl({ required String pTag, required super.pState }): super(pTag: pTag) {
    addWidgets([ WidgetKey.scaffold.idx, WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx, WidgetKey.pageBody.idx ]);
  }

  @override
  Widget buildView(BuildContext pCtx) {
    return GetBuilder<MockupViewCtrl>(
      id: WidgetKey.pageBody.idx,
      tag: WidgetKey.pageBody.idx,
      init: this,
      builder: (MockupViewCtrl vCtrl) => 
      (state.isNew || state.isLoading ||  state.isLoadingAgain)
        ? Center(child: CircularProgressIndicator(),)
        : Center(child:Text(
        "Contingut carregat!", 
        style: Get.textTheme.headlineSmall
      )),
    );
  }
}

