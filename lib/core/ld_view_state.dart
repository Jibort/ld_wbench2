// Classe base dels estats de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:ld_wbench2/core/ld_state.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/views/widget_key.dart';


abstract class LdViewState
extends LdState<LdViewState, LdViewCtrl> {
  // 🧩 MEMBRES --------------------------
  LoadState _loadState = LoadState.isNew;
  bool virgin = true;

  String _title;
  String? _subtitle;
  String? _message;
  
  // 🛠️ CONSTRUCTORS ---------------------
  LdViewState({ 
    required String pTitle, 
    String? pSubtitle, 
    String? pMessage,
    super.pErrorCode,
    super.pErrorMessage,
    super.pException, 
   }): 
    _title = pTitle,
    _subtitle = pSubtitle,
    _message = pMessage;

  // GETTERS/SETTERS ------------------
  String  get title    => _title;
  String? get subtitle => _subtitle;
  void setTitles({required String pTitle, String? pSubtitle}) { 
    _title = pTitle;
    _subtitle = pSubtitle;
    viewCtrl.notify(pTgts: [ viewCtrl.tag ]);
  }
  
  String? get message => _message;
  set message(String? pMessage) { 
    _message = pMessage;
    viewCtrl.notify(pTgts: [ viewCtrl.tag ]);
  }
  
  // Controlador de la vista ----------  
  LdViewCtrl get viewCtrl => super.ctrl;
  set viewCtrl(LdViewCtrl pVCtrl) => super.ctrl = pVCtrl;

  // 'LdState' ------------------------
  @override bool get isNew            => (_loadState == LoadState.isNew);
  @override bool get isPreparing      => (_loadState == LoadState.isPreparing);
  @override bool get isLoading        => (_loadState == LoadState.isLoading);
  @override bool get isLoaded         => (_loadState == LoadState.isLoaded);
  @override bool get isPreparingAgain => (_loadState == LoadState.isPreparingAgain);
  @override bool get isLoadingAgain   => (_loadState == LoadState.isLoadingAgain);

  // Estableix que la càrrega s'està preparant.
  void setPreparing() {
    _loadState = (virgin) ? LoadState.isPreparing : LoadState.isPreparingAgain;
    viewCtrl.notify(pTgts: [ WidgetKey.scaffold.idx, WidgetKey.pageBody.idx, WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx]);
  }

  // Estableix que la càrrega s'està executant.
  void setLoading() {
    _loadState = (virgin) ? LoadState.isLoading : LoadState.isLoadingAgain;
    viewCtrl.notify(pTgts: [ WidgetKey.pageBody.idx, WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx ]);
  }

// Estableix que la càrrega s'ha completat.
  void setLoaded(Exception? pExc) {
    exception = pExc;

    _loadState = LoadState.isLoaded;
    virgin = false;
    viewCtrl.notify(); 
  }

  // Estableix que la càrrega s'ha completat amb error.
  void setException(
   String? pError, String? pErrorMessage,
   Exception pExc) {
    exception = pExc;
    _loadState = LoadState.isError;
    setError(pError, pErrorMessage);
    viewCtrl.notify();
  }

  // Reinicia l'estat original de càrrega.
    @override
    void reset() {
      super.reset();
      _loadState = LoadState.isNew;
      virgin = true;
      loadData();
      viewCtrl.notify(pTgts: [ ctrl.tag ]);
    }
}
