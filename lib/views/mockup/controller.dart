// Vista mockup per a demostrar el funcionament de LdScaffold i LdAppBar.
// CreatedAt: 2025/02/16 dg. JIQ

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/views/mockup/state.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_container.dart';
import 'package:ld_wbench2/widgets/ld_floating_action_button.dart';
import 'package:ld_wbench2/widgets/ld_scaffold.dart';

// lib/views/mockup/controller.dart
class MockupViewCtrl extends LdViewCtrl {
  // MEMBRES ADDICIONALS -------------
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // 🛠️ CONSTRUCTORS -------------------
  MockupViewCtrl({ required String pTag, required super.pState }): super(pTag: pTag) {
    addWidgets([
      WidgetKey.scaffold.idx,
      WidgetKey.appBar.idx,
      WidgetKey.appBarProgress.idx,
      WidgetKey.pageBody.idx,
      WidgetKey.listTile.idx,
      WidgetKey.floatingActionButton.idx,
      WidgetKey.dialog.idx
    ]);
  }

  // GETTERS/SETTERS ------------------
  MockupViewState get mockupState => state as MockupViewState;

  // MÉTODES ADDICIONALS --------------
  void showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Afegir element'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Nou element',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Si us plau, introdueix un text';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel·lar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  mockupState.addItem(textController.text);
                  textController.clear();
                  Navigator.pop(dialogContext);
                }
              },
              child: Text('Afegir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildView(BuildContext pCtx) {
    final bodyWidget = _buildBody(pCtx);
    
    return LdScaffold(
      pViewState: state as LdViewState,
      pTitle: mockupState.title,
      pSubtitle: mockupState.subtitle,
      btnFloatAction: LdFloatingActionButton(
        pVCtrl: this,
        onPressed: () => showAddItemDialog(pCtx),
        icon: Icon(Icons.add),
        tooltip: 'Afegir element',
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
      ),
      wgtBody: LdContainer(
        pVCtrl: this,
        child: bodyWidget,
      ),
    );
  }
  Widget _buildBody(BuildContext pCtx) {
    return GetBuilder<MockupViewCtrl>(
      id: WidgetKey.pageBody.idx,
      tag: WidgetKey.pageBody.idx,
      init: this,
      builder: (MockupViewCtrl vCtrl) {
        if (state.isNew || state.isLoading || state.isLoadingAgain) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benvingut a la vista de demostració',
                          style: Get.textTheme.titleLarge,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Aquesta vista mostra diferents components del sistema ld_wbench2.',
                          style: Get.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildListView(),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildListView() {
    return GetBuilder<MockupViewCtrl>(
      id: WidgetKey.listTile.idx,
      tag: WidgetKey.listTile.idx,
      init: this,
      builder: (MockupViewCtrl vCtrl) {
        return mockupState.items.isEmpty
            ? Center(
                child: Text(
                  'No hi ha elements. Prem el botó + per afegir-ne.',
                  style: Get.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: mockupState.items.length,
                itemBuilder: (context, index) {
                  final item = mockupState.items[index];
                  return Dismissible(
                    key: Key(item + index.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      mockupState.removeItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Element eliminat'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(item),
                        subtitle: Text('Llisca per eliminar'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Get.snackbar(
                            'Element seleccionat',
                            'Has seleccionat: $item',
                            snackPosition: SnackPosition.bottom,
                            backgroundColor: Get.theme.cardColor,
                            borderRadius: 10,
                            margin: EdgeInsets.all(10),
                            duration: Duration(seconds: 3),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  @override
  void onClose() {
    // Alliberem recursos
    textController.dispose();
    super.onClose();
  }
}

// class MockupViewCtrl
// extends LdViewCtrl {
//   // 🛠️ CONSTRUCTORS -------------------
//   MockupViewCtrl({ required String pTag, required super.pState }): super(pTag: pTag) {
//     addWidgets([ WidgetKey.scaffold.idx, WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx, WidgetKey.pageBody.idx ]);
//   }

//   @override
//   Widget buildView(BuildContext pCtx) {
//     return GetBuilder<MockupViewCtrl>(
//       id: WidgetKey.pageBody.idx,
//       tag: WidgetKey.pageBody.idx,
//       init: this,
//       builder: (MockupViewCtrl vCtrl) => 
//       (state.isNew || state.isLoading ||  state.isLoadingAgain)
//         ? Center(child: CircularProgressIndicator(),)
//         : Center(child:Text(
//         "Contingut carregat!", 
//         style: Get.textTheme.headlineSmall
//       )),
//     );
//   }
// }

