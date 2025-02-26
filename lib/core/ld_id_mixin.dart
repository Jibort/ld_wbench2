// Mixin per a la creació dels identificadors universals dels objectes.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:ld_wbench2/tools/debug.dart';

mixin LdIdMixin {
  // 📝 STATICS ------------------------
  static int counter = 0;
  static get newId => counter++;

  // 🧩 MEMBRES ------------------------
  final      int     _id = newId;
  late final String? _typeName;
  String? _tag;

  // 📥 GETTERS/SETTERS ----------------
  int get id => _id;

  set typeName(String pTypeName) => _typeName = pTypeName;
  String get typeName {
    if (_typeName == null) {
      var msg = "[LdId.typeName]: 'typeName' encara no ha estat informat!";
      Debug.fatal(msg, Exception(msg));
    }
    return _typeName!;
  }

  set tag(String pTag) => _tag = pTag;
  String get tag {
    _tag ??= '${typeName}_$id';
    return _tag!;
  }
}

