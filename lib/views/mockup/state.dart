// Dades de la vista MockupView

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/fi_fo.dart';
import 'package:ld_wbench2/translations/tr.dart';
import 'package:ld_wbench2/views/widget_key.dart';


// lib/views/mockup/state.dart
class MockupViewState extends LdViewState {
  // ESTÀTICS -------------------------
  static String className = "MockupViewState";

  // MEMBRES ADDICIONALS -------------
  final items = <String>[].obs;
  
  factory MockupViewState.defInst({
    required String pTitle,
    required String? pSubtitle
  }) => MockupViewState(
          pTitle: Tr.sabinaApp.tr, 
          pSubtitle: Tr.sabinaWelcome.tr
        );

  // 🛠️ CONSTRUCTORS ---------------------
  MockupViewState({ required super.pTitle, super.pSubtitle });

  // MÉTODES ADDICIONALS -------------
  void addItem(String item) {
    items.add(item);
    viewCtrl.notify(pTgts: [WidgetKey.listTile.idx]);
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      viewCtrl.notify(pTgts: [WidgetKey.listTile.idx]);
    }
  }

  @override
  void loadData() async {
    Exception? exc;
    setPreparing();

    stStep01(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Inicialitzem amb algunes dades d'exemple
        items.addAll(['Element 1', 'Element 2', 'Element 3']);
        
        stStep02(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
          try {
            await Future.delayed(const Duration(milliseconds: 500));

            stStep03(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
              try {
                await Future.delayed(const Duration(milliseconds: 500));
                
                stStep04(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
                  try {
                    await Future.delayed(const Duration(milliseconds: 500));
                    
                  } on Exception catch (pExc) {
                    Debug.error("⚠️ Error en stStep04:", pExc);
                    exc = pExc;
                  }
                  return exc; 
                }
                sneakFn(stStep04);

              } on Exception catch (pExc) {
                Debug.error("⚠️ Error en stStep03:", pExc);
                exc = pExc;
              }
              return exc;
            }
            sneakFn(stStep03);

          } on Exception catch (pExc) {
            Debug.error("⚠️ Error en stStep02:", pExc);
            exc = pExc;
          }
          return exc;
        }
        sneakFn(stStep02);

      } on Exception catch (pExc) {
        Debug.error("⚠️ Error en stStep01:", pExc);
        exc = pExc;
      }
      return exc;
    }
    sneakFn(stStep01);
    setLoading();

    await runSteps().timeout(Duration(seconds: 15), onTimeout: () {
      Debug.error("Timeout a runSteps()! S'està bloquejant la càrrega?", null);
      return ([], Exception("Timeout a la càrrega de dades"));
    }).then((pLExc) {
     setLoaded(pLExc.$2);
    });
  }
}

// // class MockupViewState
// extends LdViewState {
//   // ESTÀTICS -------------------------
//   static String className = "MockupViewState";

//   factory MockupViewState.defInst({
//     required String pTitle,
//     required String? pSubtitle
//   }) => MockupViewState(
//           pTitle: Tr.sabinaApp.tr, 
//           pSubtitle: Tr.sabinaWelcome.tr
//         );

//   // 🛠️ CONSTRUCTORS ---------------------
//   MockupViewState({ required super.pTitle, super.pSubtitle });

//   // 'LdViewState' --------------------
//   @override
//   void loadData() async {
//     Exception? exc;
//     setPreparing();

//     stStep01(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
//       try {
//         await Future.delayed(const Duration(milliseconds: 500));
        
//         stStep02(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
//           try {
//             await Future.delayed(const Duration(milliseconds: 500));

//             stStep03(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
//               try {
//                 await Future.delayed(const Duration(milliseconds: 500));
                
//                 stStep04(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
//                   try {
//                     await Future.delayed(const Duration(milliseconds: 500));
                    
//                   } on Exception catch (pExc) {
//                     Debug.error("⚠️ Error en stStep04:", pExc);
//                     exc = pExc;
//                   }
//                   return exc; 
//                 }
//                 sneakFn(stStep04);

//               } on Exception catch (pExc) {
//                 Debug.error("⚠️ Error en stStep03:", pExc);
//                 exc = pExc;
//               }
//               return exc;
//             }
//             sneakFn(stStep03);

//           } on Exception catch (pExc) {
//             Debug.error("⚠️ Error en stStep02:", pExc);
//             exc = pExc;
//           }
//           return exc;
//         }
//         sneakFn(stStep02);

//       } on Exception catch (pExc) {
//         Debug.error("⚠️ Error en stStep01:", pExc);
//         exc = pExc;
//       }
//       return exc;
//     }
//     sneakFn(stStep01);
//     setLoading();

//     await runSteps().timeout(Duration(seconds: 15), onTimeout: () {
//       Debug.error("Timeout a runSteps()! S'està bloquejant la càrrega?", null);
//       return ([], Exception("Timeout a la càrrega de dades"));
//     }).then((pLExc) {
//      setLoaded(pLExc.$2);
//     });
//   }
// }