// lib/views/basic_test/controller.dart
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/views/basic_test/state.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_container.dart';
import 'package:ld_wbench2/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench2/tools/debug.dart';

class BasicTestViewCtrl extends LdViewCtrl {
  // 🛠️ CONSTRUCTORS -------------------
  BasicTestViewCtrl({ required String pTag, required super.pState }): super(pTag: pTag) {
    addWidgets([
      WidgetKey.scaffold.idx,
      WidgetKey.appBar.idx,
      WidgetKey.pageBody.idx,
    ]);
  }

  // GETTERS/SETTERS ------------------
  BasicTestViewState get testState => state as BasicTestViewState;

  // 'LdViewCtrl' ---------------------
  @override
  Widget buildView(BuildContext pCtx) {
    Debug.debug(DebugLevel.debug_0, "[BasicTestViewCtrl.buildView]: Construint vista bàsica");
    
    // Usem el nou LdScaffoldWidget i LdAppBarWidget
    return LdScaffoldWidget(
      pViewState: testState,
      pTitle: testState.title,
      pSubtitle: testState.subtitle,
      wgtBody: LdContainer(
        pVCtrl: this,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Això és una prova bàsica de LdScaffold amb LdAppBar',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Canviar el títol per comprovar l'actualització
                  testState.setTitles(
                    pTitle: 'Títol Actualitzat', 
                    pSubtitle: 'Prova d\'actualització'
                  );
                },
                child: Text('Canviar títol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}