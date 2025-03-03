// Tasca atòmica dins de seqüències de tasques 'DeepDo'.
// createdAt: 25/02/15 ds. JIQ

class LoadSteps {
  // 🧩 MEMBRES --------------------------
  final _steps = <LoadStep>[];

  // 🛠️ CONSTRUCTORS ---------------------
  LoadSteps();

  // GETTERS i SETTERS ----------------
  LoadStep? get next => (_steps.isNotEmpty) ? _steps.removeAt(0) : null;
  LoadStep? byIndex(String pIndex) =>
      (_steps.where((LoadStep pStep) => pStep._index == pIndex).firstOrNull);
  void append(LoadStep pLoadStep) => _steps.add(pLoadStep);
}

// Definició d'un LoadStep.
class LoadStep {
  // 🧩 MEMBRES -------------------------
  final String _index;
  final String? _title;
  final String? _description;
  final List<String>? _upds;

  // 🛠️ CONSTRUCTORS --------------------
  LoadStep({ required String pIdx, String? pTitle, String? pDesc, List<String>? pUpds })
      : _index = pIdx,
        _title = pTitle,
        _description = pDesc,
        _upds = pUpds;

  // GETTERS i SETTERS ---------------
  String  get index       => _index;
  String? get title       => _title;
  String? get description => _description;
  List<String>? get upds  => _upds;
}
