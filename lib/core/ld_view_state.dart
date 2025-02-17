// Classe base dels estats de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

import 'package:ld_wbench2/core/deep_do.dart';
import 'package:ld_wbench2/core/ld_deep.dart';
import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/views/widget_key.dart';


abstract class LdViewState<S extends LdViewState<S, C>, C extends LdViewController<C, S>>
extends LdDeep {
  // MEMBRES --------------------------
  LoadState _loadState = LoadState.isNew;
  bool virgin = true;
  C? _vCtrl;

  String _title;
  String? _subtitle;
  String? _message;
  String? _errorCode;
  String? _errorMessage;
  Exception? _exception;

  // CONSTRUCTORS ---------------------
  LdViewState({ 
    required super.pTag,
    required String pTitle, 
    String? pSubtitle, 
    String? pMessage,
    String? pErrCode,
    String? pErrMsg,
    Exception? pException, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle,
    _message = pMessage, 
    _errorCode = pErrCode, 
    _errorMessage = pErrMsg,
    _exception = pException;

  // GETTERS/SETTERS ------------------
  String  get title => _title;
  String? get subtitle => _subtitle;
  void setTitles(String pTitle, String? pSubtitle) { 
    _title = pTitle;
    _subtitle = pSubtitle;
    vCtrl.update([id]);
  }
  
  String? get message => _message;
  set message(String? pMessage) { 
    _message = pMessage;
    vCtrl.update([id]);
  }
  
  String? get errorCode => _errorCode;
  String? get errorMessage => _errorMessage;
  setError(String? pErrCode, String? pErrMsg) { 
    _errorCode = pErrCode;
    _errorMessage = pErrMsg;
    vCtrl.update([id]);
  }

  Exception? get exception => _exception;

  // Controlador de la vista ----------  
  C get vCtrl {
    if (_vCtrl == null) {
      String msg = "El controlador encara no ha estat assignat a l'estat '$tag'.";
      Debug.fatal(msg, Exception(msg));
    }
    return _vCtrl!;
  }
  set vCtrl(C pVCtrl) => _vCtrl = pVCtrl;
  
  // 'LdDeep' -------------------------
  @override bool get isNew            => (_loadState == LoadState.isNew);
  @override bool get isPreparing      => (_loadState == LoadState.isPreparing);
  @override bool get isLoading        => (_loadState == LoadState.isLoading);
  @override bool get isLoaded         => (_loadState == LoadState.isLoaded);
  @override bool get isPreparingAgain => (_loadState == LoadState.isPreparingAgain);
  @override bool get isLoadingAgain   => (_loadState == LoadState.isLoadingAgain);
  @override bool get isError          => (_errorCode != null);

  // Estableix que la càrrega s'està preparant.
  void setPreparing() {
    _loadState = (virgin) ? LoadState.isPreparing : LoadState.isPreparingAgain;
    vCtrl.notify(pTgts: [ WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx]);
  }

  // Estableix que la càrrega s'està executant.
  void setLoading() {
    _loadState = (virgin) ? LoadState.isLoading : LoadState.isLoadingAgain;
    vCtrl.notify(pTgts: [ WidgetKey.appBar.idx, WidgetKey.appBarProgress.idx ]);
  }

// Estableix que la càrrega s'ha completat.
  void setLoaded(Exception? pExc) {
    _exception = pExc;

    _loadState = LoadState.isLoaded;
    virgin = false;
    vCtrl.notify(); 
  }

  // Estableix que la càrrega s'ha completat amb error.
  void setException(
   String? pError, String? pErrorMessage,
   Exception pExc) {
    _exception = pExc;
    _loadState = LoadState.isError;
    _errorCode = pError;
    _errorMessage = pErrorMessage;
    vCtrl.update();
  }

  // Reinicia l'estat original de càrrega.
  void dataReset() {
    super.reset();
    _loadState = LoadState.isNew;
    virgin = true;
    loadData();
    vCtrl.update();
  }

  // Càrrega asíncrona de les dades de la vista.
  void loadData();
}
