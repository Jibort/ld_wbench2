// Classe embolcall per a totes les vistes de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/core/deep_do.dart';
import 'package:ld_wbench2/tools/li_fo_map.dart';

abstract class LdDeep extends GetView with LdId, DeepDo {
  // ESTÀTICS -------------------------
  static final LiFoMap<LdDeep> _views = LiFoMap<LdDeep>();

  // CONSTRUCTORS ---------------------
  LdDeep({ String? pTag, super.key }) {
    tag = pTag ?? "${type}_$id";
    Debug.debug(DebugLevel.debug_0, "[LdDeep]: Creant vista '$tag'...");
    _views.push(tag, this);
    Debug.debug(DebugLevel.debug_0, "[LdDeep]: Vista '$tag' creda.");
  }

}