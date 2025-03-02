// Estat de la pàgina de proves de formulari.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/fi_fo.dart';

class FormTestViewState 
extends LdViewState {
  // ESTÀTICS -------------------------
  static String className = "FormTestViewState";

  // MEMBRES ADDICIONALS -------------
  String formData = '';
  bool isFormValid = false;
  
  factory FormTestViewState.defInst({
    required String pTitle,
    required String? pSubtitle
  }) => FormTestViewState(
          pTitle: pTitle, 
          pSubtitle: pSubtitle
        );

  // 🛠️ CONSTRUCTORS ---------------------
  FormTestViewState({ required super.pTitle, super.pSubtitle });

  // MÈTODES ADDICIONALS -------------
  void updateFormData(String data) {
    formData = data;
    viewCtrl.notify();
  }
  
  void setFormValidity(bool valid) {
    isFormValid = valid;
    viewCtrl.notify();
  }

  @override
  void loadData() async {
    Exception? exc;
    setPreparing();

    stStep01(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
      try {
        await Future.delayed(const Duration(milliseconds: 500));
        // Inicialització de dades si fos necessari
        
        stStep02(FiFo<dynamic> pQueue, List<dynamic> pArgs) async {
          try {
            await Future.delayed(const Duration(milliseconds: 500));
            // Més inicialitzacions si fos necessari
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