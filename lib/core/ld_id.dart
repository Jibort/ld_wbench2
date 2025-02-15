// Mixin per a la creació dels identificadors universals dels objectes.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:flutter/foundation.dart';

mixin LdId {
  // STATICS --------------------------
  static int counter = 0;
  static get newId => counter++;

  // MEMBRES --------------------------
  final int _id = newId;
  final String _type = objectRuntimeType.toString();
  String? _tag;

  // GETTERS/SETTERS ------------------
  int get id => _id;
  String get type => _type;
  String get tag => _tag ?? "${_type}_undef";
  set tag(String pTag) => _tag = pTag;
}

