// Classe embolcall per a tots els widgets de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/core/ld_widget_controller.dart';

abstract class LdWidget extends StatelessWidget
with LdId {
  // MEMBRES ---------------------
  LdWidgetController _ctrl;
  LdWidget({ String? pTag, super.key }): _ctrl = LdWidgetController() {
    tag = pTag?? tag;
  }
}
