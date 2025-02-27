// lib/views/basic_test/state.dart
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/fi_fo.dart';

class BasicTestViewState extends LdViewState {
  // ESTÀTICS -------------------------
  static String className = "BasicTestViewState";

  // CONSTRUCTORS ---------------------
  BasicTestViewState({ required super.pTitle, super.pSubtitle });

  @override
  void loadData() async {
    Exception? exc;
    setPreparing();

    stStep01(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        // Simulem una càrrega simple
        Debug.debug(DebugLevel.debug_1, "BasicTestViewState: Carregant dades bàsiques...");
      } on Exception catch (pExc) {
        Debug.error("⚠️ Error en stStep01:", pExc);
        exc = pExc;
      }
      return exc;
    }
    
    sneakFn(stStep01);
    setLoading();

    await runSteps().timeout(Duration(seconds: 5), onTimeout: () {
      Debug.error("Timeout a runSteps()!", null);
      return ([], Exception("Timeout a la càrrega de dades"));
    }).then((pLExc) {
      setLoaded(pLExc.$2);
    });
  }
}