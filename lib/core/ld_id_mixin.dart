// Mixin per a la creació dels identificadors universals dels objectes.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:ld_wbench2/tools/debug.dart';

mixin LdIdMixin {

  // 📝 STATICS ------------------------
  static int _counter = 0;
  static int get counter => _counter;
  static int get _newId => _counter++;

  // 🧩 MEMBRES ------------------------
  final      int    _id = _newId;
  late final String _typeName;
  bool isTypeNameSet = false;
  late final String _tag;
  bool isTagSet = false;

  // 📥 GETTERS/SETTERS ----------------
  int get id => _id;

  String get typeName => _typeName;
  set typeName(String pTypeName) {
    if (!isTypeNameSet) {
      isTypeNameSet = true;
      _typeName = pTypeName;
    } else {
      String msg = "El 'typeName' del tag '$tag' ja ha estat assignat prèviament!";
      Debug.fatal(msg, Exception(msg));
    }
  }

  String get tag => _tag;
  set tag(String pTag)  {
    if (!isTagSet) {
      isTagSet = true;
      _tag = pTag;
    } else {
      String msg = "El 'tag' del typeName '$typeName' ja ha estat assignat prèviament!";
      Debug.fatal(msg, Exception(msg));
    }
  }

} // mixin LdIdMixin

