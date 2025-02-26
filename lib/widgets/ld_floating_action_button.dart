// lib/widgets/ld_floating_action_button.dart

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

class LdFloatingActionButton
extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdFloatingActionButton";

  // CONSTRUCTORS ---------------------
  LdFloatingActionButton({
    super.key,
    String? pTag,
    required VoidCallback onPressed,
    required Widget icon,
    String? tooltip,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    String? label,
    required super.pVCtrl,
  }) : super(
      pState: LdFloatingActionButtonState(
        pTag: pTag ?? 'fab_${DateTime.now().millisecondsSinceEpoch}',
        pLabel: label ?? 'Botó d\'acció flotant',
        pVCtrl: pVCtrl,
      )) {
    ctrl = LdFloatingActionButtonCtrl(
      pVCtrl: vCtrl,
      pState: state,
      pTag: pTag,
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
    );
    state.wCtrl = ctrl;
  }
}

class LdFloatingActionButtonState extends LdWidgetState {
  // CONSTRUCTORS ---------------------
  LdFloatingActionButtonState({
    required super.pTag,
    required super.pVCtrl,
    required super.pLabel,
  });

  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdFloatingActionButtonCtrl extends LdWidgetCtrl {
  // MEMBRES --------------------------
  final VoidCallback onPressed;
  final Widget icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  // CONSTRUCTORS ---------------------
  LdFloatingActionButtonCtrl({
    required super.pVCtrl,
    required super.pState,
    super.pTag,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  @override
  Widget buildWidget(BuildContext pCtx) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor ?? Theme.of(pCtx).colorScheme.primary,
      foregroundColor: foregroundColor ?? Theme.of(pCtx).colorScheme.onPrimary,
      elevation: elevation ?? 6.0,
      child: icon,
    );
  }
}