// Widget del Botó genèric de l'aplicació.
// CreatedAt: 2025/02/19 dc. JIQ

// Widget del Botó genèric de l'aplicació.
// CreatedAt: 2025/02/19 dc. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/debug.dart';

class   LdButtonWidget
extends LdWidget<LdButtonState, LdButtonCtrl> {
  // ESTÀTICS -------------------------
  static String className = "LdButton";

  // 🛠️ CONSTRUCTORS ---------------------
  LdButtonWidget({
    super.key,
    required String pTag,
    required super.pViewCtrl,
    required LdViewState pViewState,
    required String label,
    required VoidCallback onPressed,
    Widget? icon,
    bool isExpanded = false,
    ButtonStyle? style,
    bool enabled = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    Size? minimumSize,
    BorderRadius? borderRadius,
  }) : super(
          pState: LdButtonState(
            pLabel: label,
            pViewCtrl: pViewCtrl,
            pViewState: pViewState,
          ),
        ) {
    tag = pTag;
    typeName = className;
    
    ctrl = LdButtonCtrl(
      pTag: pTag,
      pViewCtrl: viewCtrl,
      pState: state,
      label: label,
      onPressed: onPressed,
      icon: icon,
      isExpanded: isExpanded,
      style: style,
      enabled: enabled,
      padding: padding,
      minimumSize: minimumSize,
      borderRadius: borderRadius,
    );
  }
  
  // METHODS --------------------------
  bool get isEnabled => state.isEnabled;
  set isEnabled(bool value) => state.isEnabled = value;
  
  String get label => state.label;
  set label(String value) => state.label = value;
  
  void trigger() => ctrl.trigger();
}

class   LdButtonState
extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  bool _isEnabled = true;

  // 🛠️ CONSTRUCTORS ---------------------
  LdButtonState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
  });

  // 📥 GETTERS/SETTERS ------------------
  bool get isEnabled => _isEnabled;
  set isEnabled(bool value) {
    _isEnabled = value;
    ctrl.notify(pTgts: [ctrl.tag]);
  }
  
  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class   LdButtonCtrl
extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String label;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isExpanded;
  final ButtonStyle? style;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final BorderRadius? borderRadius;

  // 🛠️ CONSTRUCTORS ---------------------
  LdButtonCtrl({
    required super.pViewCtrl,
    required super.pState,
    required super.pTag,
    required this.label,
    required this.onPressed,
    this.icon,
    required this.isExpanded,
    this.style,
    required this.enabled,
    this.padding,
    this.minimumSize,
    this.borderRadius,
  });

  // PUBLIC METHODS -------------------
  void trigger() {
    if ((state as LdButtonState).isEnabled) {
      onPressed();
    }
  }

  @override
  void onInit() {
    super.onInit();
    (state as LdButtonState).isEnabled = enabled;
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    final bool isEnabled = (state as LdButtonState).isEnabled;
    final theme = Theme.of(pCtx);
    Debug.info("LdButtonCtrl.buildWidget: $tag");
    // Estil per defecte que s'adapta al tema actual
    ButtonStyle defaultStyle = ElevatedButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      minimumSize: minimumSize,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      disabledBackgroundColor: theme.disabledColor,
      disabledForegroundColor: theme.colorScheme.onSurface.withAlpha(115),
    );
    
    // Utilitzar l'estil proporcionat o el per defecte
    Debug.info("LdButtonCtrl.buildWidget: Establim button style..............");
    final finalStyle = defaultStyle; // style ?? defaultStyle;
    
    // Construir el botó
    Widget button;
    
    if (icon != null) {
      // Botó amb icona
      button = ElevatedButton.icon(
        onPressed: isEnabled ? onPressed : null,
        icon: icon!,
        label: Text((state as LdButtonState).label),
        style: finalStyle,
      );
    } else {
      // Botó només amb text
      button = ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: finalStyle,
        child: Text(state.label),
      );
    }

    if (padding != null) {
      button = Padding(
        padding: padding!,
        child: button,
      );
    }
    
    // Si s'ha d'expandir, afegim Expanded
    return isExpanded ? Expanded(child: button) : button;
  }
}