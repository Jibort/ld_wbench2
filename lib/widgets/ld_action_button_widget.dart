import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

class   LdActionButtonWidget
extends LdWidget<LdActionButtonWidgetState, LdActionButtonWidgetCtrl> {
  // ESTÀTICS -------------------------
  static String className = "LdActionButtonWidget";

  // 🛠️ CONSTRUCTORS ---------------------
  LdActionButtonWidget({
    super.key,
    required String pTag,
    required String label,
    required VoidCallback onPressed,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    bool enabled = true,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    required super.pViewCtrl,
    required LdViewState pViewState,
  }) : super(
          pState: LdActionButtonWidgetState(
            pLabel: label,
            pViewCtrl: pViewCtrl,
            pViewState: pViewState,
          ),
        ) {
    ctrl = LdActionButtonWidgetCtrl(
      pViewCtrl: viewCtrl,
      pState: state,
      pTag: pTag,
      label: label,
      onPressed: onPressed,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      enabled: enabled,
      iconSize: iconSize,
      padding: padding,
    );
  }
  
  // METHODS --------------------------
  bool get isEnabled        => state.isEnabled;
  set isEnabled(bool value) => state.isEnabled = value;
  
  void trigger() => ctrl.trigger();
}

class LdActionButtonWidgetState
extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  bool _isEnabled = true;

  // 🛠️ CONSTRUCTORS ---------------------
  LdActionButtonWidgetState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
  });

  // GETTERS/SETTERS ------------------
  bool get isEnabled => _isEnabled;
  set isEnabled(bool value) {
    _isEnabled = value;
    ctrl.notify(pTgts: [ ctrl.tag ]);
  }

  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdActionButtonWidgetCtrl
extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool enabled;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  // 🛠️ CONSTRUCTORS ---------------------
  LdActionButtonWidgetCtrl({
    required super.pViewCtrl,
    required super.pState,
    required super.pTag,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.enabled = true,
    this.iconSize,
    this.padding,
  });

  // PUBLIC METHODS -------------------
  void trigger() {
    if ((state as LdActionButtonWidgetState).isEnabled) {
      onPressed();
    }
  }

  @override
  void onInit() {
    super.onInit();
    (state as LdActionButtonWidgetState).isEnabled = enabled;
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    final bool isEnabled = (state as LdActionButtonWidgetState).isEnabled;
    
    // Si tenim una icona, utilitzem un IconButton
    if (icon != null) {
      // Com que IconButton no té backgroundColor directe, 
      // utilitzem un Container amb IconButton o un Material per aplicar-lo
      return Material(
        color: isEnabled ? backgroundColor : Colors.grey.withAlpha(77),
        borderRadius: BorderRadius.circular(backgroundColor != null ? 25.0 : 0),
        child: IconButton(
          onPressed: isEnabled ? onPressed : null,
          icon: Icon(
            icon,
            color: isEnabled ? iconColor : Colors.grey,
            size: iconSize,
          ),
          tooltip: label,
          padding: padding ?? const EdgeInsets.all(8.0),
        ),
      );
    } 
    // Si no, farem servir un ElevatedButton normal
    else {
      return ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? backgroundColor : Colors.grey.withAlpha(77),
          padding: padding,
        ),
        child: Text(label),
      );
    }
  }
}