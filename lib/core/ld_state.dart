// Classe per a la generalització de l'estat d'una vista de l'aplicació.
// CreatedAt: 2025/02/19 dc. JIQ

// Estats de la càrrega de dades per a la pàgina.
import 'package:flutter/foundation.dart';
import 'package:ld_wbench2/core/ld_ctrl.dart';
import 'package:ld_wbench2/core/ld_registrable_id.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/fi_fo.dart';
import 'package:ld_wbench2/tools/load_steps.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

// Declaració de possibles estats d'un LdState.
enum LoadState {
  isNew,
  isPreparing,
  isLoading,
  isLoaded,
  isPreparingAgain,
  isLoadingAgain,
  isError,
}

// DEFINICIONS DE FUNCIONS TIPUS ------
typedef FnExc = Future<(Exception?, bool)> Function(Exception? pExc);
typedef FnStep = Future<Exception?> Function(FiFo pQueue, List<dynamic> pArgs);
typedef FnThen = Exception? Function(FiFo pQueue);

abstract class LdState<
  S extends LdState<S, C>, 
  C extends LdCtrl<C, S>>
with LdRegistrableId {
  // ESTÀTICS -------------------------
  static const className = "LdState";

  // MEMBRES --------------------------
  Function(FiFo pQueue)? _onAltered;
  final _queue = FiFo();
  int _length = 0;
  int _dids = 0;

  // CONSTRUCTORS ---------------------
  LdState({ String? pTag }) {
    register(pTag);
    Debug.debug(DebugLevel.debug_0, "[LdState]: ...estat '$tag' creat.");
  }

  // GETTERS i SETTERS ----------------
  FiFo get queue => _queue;
  int get length => _length;
  int get dids => _dids;
  double? get ratio {
    double? rat;
    rat = (length == 0 || dids == 0) ? null : dids / length;
    if (isNotNull(rat)) {
      if (rat! > 1.0) rat = 1.0;
      if (rat < 0.0) rat = 0;
    }
    return rat;
  }

  (int, int, double?) get stats => (length, dids, ratio);
  set onAltered(Function(FiFo pQueue)? pOnAltered) => _onAltered = pOnAltered;

  // FUNCIONS ABSTRACTES --------------
  void loadData();
  
  // GESTIÓ DE PASOS ------------------
  // Afegeix un pas a la pila de pasos.
  void addFn(FnStep pStep,
      {List<dynamic>? pArgs, FnThen? pThen, FnExc? pOnExc, LoadStep? pLoadStep}) {
    pushArgs(pArgs);
    if (isNotNull(pThen)) {
      _queue.push(pThen);
    }
    if (isNotNull(pOnExc)) {
      _queue.push(pOnExc);
    }
    if (isNotNull(pLoadStep) && kDebugMode) {
      _queue.push(pLoadStep);
    }
    _queue.push(pStep);
    _length += 1;
    if (isNotNull(_onAltered)) _onAltered!(_queue);
  }

  // Afegeix un pas a la pila de pasos que s'executarà immediatament si
  // la pàgina està carregada.
  Future<void> addFnNow(LdViewCtrl pCtrl, FnStep pStep,
      {List<dynamic>? pArgs, FnThen? pThen, FnExc? pOnExc, LoadStep? pLoadStep}) async {
    addFn(pStep, pArgs: pArgs, pThen: pThen, pOnExc: pOnExc, pLoadStep: pLoadStep);
    if (isLoaded) await runSteps();
  }

  // Avantpasa un pas al principi de la pila de pasos.
  void sneakFn(FnStep pStep,
      {List<dynamic>? pArgs, FnThen? pThen, FnExc? pOnExc, LoadStep? pLoadStep}) {
    _queue.sneak(pStep);
    _length += 1;

    if (isNotNull(pOnExc)) {
      _queue.sneak(pOnExc);
    }
    if (isNotNull(pLoadStep) && kDebugMode) {
      _queue.sneak(pLoadStep);
    }
    if (isNotNull(pThen)) {
      _queue.sneak(pThen);
    }
    sneakArgs(pArgs);
    if (isNotNull(_onAltered)) _onAltered!(_queue);
  }

  // GESTIÓ DE LA PILA DE PARÀMETRES --
  void pushArgs(List<dynamic>? pArgs) {
    if (isNotNull(pArgs)) {
      for (var arg in pArgs!.reversed) {
        _queue.push(arg);
      }
    }
  }

  void sneakArgs(List<dynamic>? pArgs) {
    if (isNotNull(pArgs)) {
      for (var arg in pArgs!.reversed) {
        _queue.sneak(arg);
      }
    }
  }

  dynamic popQueue() => _queue.pop();

  // EXECUCIÓ DELS PASSOS -------------
  Future<(List<dynamic>, Exception?)> runSteps() async {
    final args = <dynamic>[];
    FnThen? fthen;
    FnExc? fexc;
    dynamic obj = _queue.pop();
    Exception? exc;

    while (isNotNull(obj)) {
      switch (obj) {
        case LoadStep loadStep:
          (isNotNull(loadStep.description)) ? Debug.debug(DebugLevel.debug_2, '''
Step[${loadStep.index}]: ${loadStep.title}
    ${loadStep.description}
''') : Debug.debug(DebugLevel.debug_2, "Step[${loadStep.index}]: ${loadStep.title}");
          break;
        case FnThen fnThen:
          fthen = fnThen;
          break;
        case FnExc fnExc:
          fexc = fnExc;
          break;
        case FnStep fnStep:
          bool contn = false;
          exc = (isNotNull(fthen))
              ? await fnStep(_queue, args).then((_) => fthen!(_queue))
              : await fnStep(_queue, args);
          if (isNotNull(exc)) {
            if (isNotNull(fexc)) (exc, contn) = await fexc!(exc);
            if (!contn && isNotNull(exc)) {
              Error.safeToString(exc);
              return ([], exc);
            }
          }
          args.clear();
          fthen = null;
          fexc = null;
          _dids += 1;
          if (isNotNull(_onAltered)) _onAltered!(_queue);
          break;
        case Symbol symb:
          if (symb == #empty) args.add(null);
          break;
        case dynamic arg:
          args.add(arg);
          break;
      }
      obj = _queue.pop();
    }

    return (args, exc);
  }

  // FUNCIONS ABSTRACTES ---------------------
  // Només cert quan el control·lador ha de començar a carregar dades.
  bool get isNew;

  // Només cert quan s'està preparant la càrrega.
  bool get isPreparing;

  // Només cert quan s'està carregant dades.
  bool get isLoading;

  // Només cert quan les dades han estat carregades.
  bool get isLoaded;

  // Només cert quan s'està tornant a preparar una càrrega.
  bool get isPreparingAgain;

  // Només cert quan s'està tornant a carregar dades.
  bool get isLoadingAgain;

  // Només cert quan ha succeït una excepció en la càrrega de dades.
  bool get isError;

  // NETEJA ----------------------------------
  void reset() {
    _queue.clear();
    _length = 0;
    _dids = 0;
  }
}