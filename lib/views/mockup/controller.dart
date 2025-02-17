// Vista mockup per a demostrar el funcionament de LdScaffold i LdAppBar.
// CreatedAt: 2025/02/16 dg. JIQ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/views/mockup/state.dart';
import 'package:ld_wbench2/views/widget_key.dart';

class MockupViewController extends LdViewController<MockupViewController, MockupViewState> {
  MockupViewController({ required super.pState }) {
    addWidgets([ WidgetKey.scaffold.idx, WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx, ]);
  }


  @override
  Widget buildView(BuildContext pCtx) {
    if (vState.isNew || vState.isLoading ||  vState.isLoadingAgain) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Text(
          "Contingut carregat!", 
          style: Get.textTheme.headlineSmall
        )
      ); 
    }
  }
}
