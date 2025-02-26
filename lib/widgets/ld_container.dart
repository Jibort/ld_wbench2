// lib/widgets/ld_container.dart
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

class LdContainer extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdContainer";

  // CONSTRUCTORS ---------------------
  LdContainer({
    super.key,
    String? pTag,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    BoxDecoration? decoration,
    required super.pVCtrl,
  }) : super(
    pState: LdContainerState(
      pTag: pTag ?? 'container_${DateTime.now().millisecondsSinceEpoch}',
      pLabel: 'Container',
      pVCtrl: pVCtrl,
    )) {
    ctrl = LdContainerCtrl(
      pVCtrl: vCtrl,
      pState: state,
      pTag: pTag,
      child: child,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
    );
  }
}

class LdContainerState extends LdWidgetState {
  // CONSTRUCTORS ---------------------
  LdContainerState({
    required super.pTag,
    required super.pVCtrl,
    required super.pLabel,
  });

  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdContainerCtrl extends LdWidgetCtrl {
  // MEMBRES --------------------------
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxDecoration? decoration;

  // CONSTRUCTORS ---------------------
  LdContainerCtrl({
    required super.pVCtrl,
    required super.pState,
    super.pTag,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
  });

  @override
  Widget buildWidget(BuildContext pCtx) {
    return Container(
      padding: padding,
      margin: margin,
      color: decoration == null ? color : null,
      decoration: decoration,
      child: child,
    );
  }
}