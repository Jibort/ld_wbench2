// lib/views/basic_test/state.dart
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/fi_fo.dart';
import 'package:ld_wbench2/tools/load_steps.dart';
import 'package:ld_wbench2/views/widget_key.dart';

class BasicTestViewState 
extends LdViewState {
  // ESTÀTICS -------------------------
  static String className = "BasicTestViewState";

  // MEMBRES ADDICIONALS -------------
  final List<String> _packages = [
    'Nucli',
    'Model',
    'Controladors',
    'Vistes',
    'Serveis',
    'Eines',
    'Widgets',
    'Proves',
    'Recursos',
    'Configuració'
    'Nucli 2',
    'Model 2',
    'Controladors 2',
    'Vistes 2',
    'Serveis 2',
    'Eines 2',
    'Widgets 2',
    'Proves 2',
    'Recursos 2',
    'Configuració 2'
  ];

  // 🛠️ CONSTRUCTORS ---------------------
  BasicTestViewState({ required super.pTitle, super.pSubtitle });

  @override
  void loadData() async {
    Exception? exc;
    setPreparing();
    
    List<String> upds = [
      WidgetKey.scaffold.idx, 
      WidgetKey.appBar.idx, 
      WidgetKey.appBarProgress.idx, 
      WidgetKey.pageBody.idx
    ];

    // Notificar que s'ha iniciat la preparació
    viewCtrl.notify(pTgts: upds);

    // Crear 15 passos de càrrega
    for (int i = 0; i < 15; i++) {
      final packId = i;
      stepFunction(FiFo pQueue, List<dynamic> pArgs) async {
        try {
          // Cada pas dura aproximadament 1.33 segons (20s ÷ 15 passos)
          await Future.delayed(Duration(milliseconds: 1330));
        } on Exception catch (pExc) {
          Debug.error("⚠️ Error en package_$packId:", pExc);
          exc = pExc;
        }
        return exc;
      }
      
      sneakFn(stepFunction, pLoadStep: LoadStep(
        pIdx: 'package_${packId + 1}', 
        pTitle: 'Carregant ${_packages[packId]}', 
        pDesc: 'Inicialitzant paquet ${packId + 1} de ${_packages.length}',
        pUpds: upds
      ));
    }
    
    setLoading();

    await runSteps().timeout(Duration(seconds: 30), onTimeout: () {
      Debug.error("Timeout a runSteps()!", null);
      return ([], Exception("Timeout a la càrrega de dades"));
    }).then((pLExc) {
      setLoaded(pLExc.$2);
      
      // Notificar finalització de càrrega a tots els widgets
      viewCtrl.notify(pTgts: [
        WidgetKey.scaffold.idx, 
        WidgetKey.appBar.idx, 
        WidgetKey.pageBody.idx
      ]);
    });
  }

  // @override
  void loadData_() async {
    Exception? exc;
    int packId = 0;
    setPreparing();
    
    List<String> upds = [
      WidgetKey.scaffold.idx, 
      WidgetKey.appBar.idx, 
      WidgetKey.appBarProgress.idx, 
      WidgetKey.pageBody.idx
    ];

    // Notificar que s'ha iniciat la preparació
    viewCtrl.notify(pTgts: upds);

    step01(FiFo pQueue, List<dynamic> pArgs) async {
      try {
        // Simular càrrega de paquet amb 0.5 segons
        await Future.delayed(Duration(milliseconds: 1500));
        
        step02(FiFo pQueue, List<dynamic> pArgs) async {
          try {
            // Simular càrrega de paquet amb 0.5 segons
            await Future.delayed(Duration(milliseconds: 1500));

            step03(FiFo pQueue, List<dynamic> pArgs) async {
              try {
                // Simular càrrega de paquet amb 0.5 segons
                await Future.delayed(Duration(milliseconds: 1500));
                
                step04(FiFo pQueue, List<dynamic> pArgs) async {
                  try {
                    // Simular càrrega de paquet amb 0.5 segons
                    await Future.delayed(Duration(milliseconds: 1500));
                  } on Exception catch (pExc) {
                    Debug.error("⚠️ Error en package_$packId:", pExc);
                    exc = pExc;
                  }
                  return exc;
                }
                sneakFn(step04, pLoadStep: LoadStep(
                  pIdx: 'package_04', 
                  pTitle: 'Carregant ${_packages[packId]}', 
                  pDesc: 'Inicialitzant paquet $packId de ${_packages.length}',
                  pUpds: upds
                ));
              } on Exception catch (pExc) {
                Debug.error("⚠️ Error en package_$packId:", pExc);
                exc = pExc;
              }
              return exc;
            }
            sneakFn(step03, pLoadStep: LoadStep(
                pIdx: 'package_03', 
                pTitle: 'Carregant ${_packages[packId]}', 
                pDesc: 'Inicialitzant paquet $packId de ${_packages.length}',
                pUpds: upds
            ));

          } on Exception catch (pExc) {
            Debug.error("⚠️ Error en package_$packId:", pExc);
            exc = pExc;
          }
          return exc;
        }
        sneakFn(step02, pLoadStep: LoadStep(
          pIdx: 'package_02', 
          pTitle: 'Carregant ${_packages[0]}', 
          pDesc: 'Inicialitzant paquet $packId de ${_packages.length}',
          pUpds: upds
        ));
      } on Exception catch (pExc) {
        Debug.error("⚠️ Error en package_$packId:", pExc);
        exc = pExc;
      }
      return exc;
    }
    sneakFn(step01, pLoadStep: LoadStep(
        pIdx: 'package_01', 
        pTitle: 'Carregant ${_packages[0]}', 
        pDesc: 'Inicialitzant paquet $packId de ${_packages.length}',
        pUpds: upds
    ));
    
    setLoading();

    await runSteps().timeout(Duration(seconds: 30), onTimeout: () {
      Debug.error("Timeout a runSteps()!", null);
      return ([], Exception("Timeout a la càrrega de dades"));
    }).then((pLExc) {
      setLoaded(pLExc.$2);
      
      // Notificar finalització de càrrega a tots els widgets
      viewCtrl.notify(pTgts: [
        WidgetKey.scaffold.idx, 
        WidgetKey.appBar.idx, 
        WidgetKey.pageBody.idx
      ]);
    });
  }
}