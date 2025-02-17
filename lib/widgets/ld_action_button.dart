


import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';

class LdActionButton extends LdWidget {
  // 🔹 Propietats ---------------------------
  final VoidCallback onPressed;
  final Widget icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final ShapeBorder? shape;

  // 🔹 Constructor ---------------------------
  LdActionButton({
    super.key, 
    super.pTag,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: elevation ?? 6.0,
      shape: shape ?? const CircleBorder(),
      child: icon,
    );
  }
}
