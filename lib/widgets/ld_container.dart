// Widget contenidor de Widgets i LdWidgets.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdContainer
extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdContainer";

  // 🛠️ CONSTRUCTORS ---------------------
  LdContainer({
    super.key,
    required String pTag,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    BoxDecoration? decoration,
    String? label,
    double? borderRadius = 8.0,
    double? borderWidth = 1.0,
    Color? borderColor,
    bool showBorder = false,
    required super.pViewCtrl,
    required LdViewState pViewState,
  }) : super(
    pState: LdContainerState(
      pLabel: label ?? 'Container',
      pViewCtrl: pViewCtrl,
      pViewState: pViewState,  
  )) {
    tag = pTag;
    typeName = className;
    
    ctrl = LdContainerCtrl(
      pViewCtrl: viewCtrl,
      pState: state,
      pTag: pTag,
      child: child,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      label: label,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      showBorder: showBorder,
    );
  }
}

class LdContainerState extends LdWidgetState {
  // 🛠️ CONSTRUCTORS ---------------------
  LdContainerState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
  });

  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdContainerCtrl extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxDecoration? decoration;
  final String? label;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final bool showBorder;

  // 🛠️ CONSTRUCTORS ---------------------
  LdContainerCtrl({
    required super.pViewCtrl,
    required super.pState,
    required super.pTag,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.label,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    required this.showBorder,
  });

  @override
  Widget buildWidget(BuildContext pCtx) {
    // Container base sense etiqueta
    if (!showBorder || isNull(label)) {
      return Container(
        padding: padding,
        margin: margin,
        color: decoration == null ? color : null,
        decoration: decoration,
        child: child,
      );
    }
    
    // Container amb vora i etiqueta
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: padding ?? EdgeInsets.all(16.0),
          margin: margin ?? EdgeInsets.all(8.0),
          decoration: decoration ?? BoxDecoration(
            color: color ?? Theme.of(pCtx).colorScheme.surface,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            border: Border.all(
              color: borderColor ?? Theme.of(pCtx).colorScheme.primary,
              width: borderWidth ?? 1.0,
            ),
          ),
          child: child,
        ),
        // Etiqueta
        Positioned(
          top: -10,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            color: decoration?.color ?? color ?? Theme.of(pCtx).colorScheme.surface,
            child: Text(
              label!,
              style: TextStyle(
                color: borderColor ?? Theme.of(pCtx).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🔄 'GetLifeCycleMixin' ------------
  @override
  void onInit() {
    super.onInit();
  }

}