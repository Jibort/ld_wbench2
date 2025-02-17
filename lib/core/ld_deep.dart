// Classe embolcall per a totes les vistes de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/core/ld_registrable.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/core/deep_do.dart';

abstract class LdDeep
extends DisposableInterface
with DeepDo, LdId, LdRegistrable {
  // ESTÀTICS -------------------------
  static const className = "LdDeep";

  // CONSTRUCTORS ---------------------
  LdDeep({ String? pTag }) {
    rtType = className;
    register(pTag);
    Debug.debug(DebugLevel.debug_0, "[LdDeep]: DeepDo '$tag' creat.");
  }

  // Quan el DeepDo s'està destruint
  @override
  void onClose() {
    Debug.debug(DebugLevel.debug_1, "[onClose]: El DeepDo '$tag' s'està destruint.");
    super.onClose();
  }
}