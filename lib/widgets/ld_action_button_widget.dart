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
    // Es important inicialitzar el tag abans de crear el controlador
    this.tag = pTag;
    this.typeName = className;
    
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

class LdActionButtonWidgetState extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  bool _isEnabled = true;

  // 🛠️ CONSTRUCTORS ---------------------
  LdActionButtonWidgetState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
  });

  // 📥 GETTERS/SETTERS ------------------
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

class LdActionButtonWidgetCtrl extends LdWidgetCtrl {
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
    
    // Accés segur al tema
    ThemeData? theme;
    Color defaultIconColor;
    
    try {
      // Utilitzem una solució més compatible per accedir al tema de forma segura
      bool isContextValid = false;
      
      try {
        // Comprovem si el context és vàlid
        final _ = pCtx.findRenderObject();
        isContextValid = true;
      } catch (e) {
        isContextValid = false;
      }
      
      if (isContextValid) {
        // Si el context és vàlid, utilitzem Theme.of de forma segura
        try {
          theme = Theme.of(pCtx);
          defaultIconColor = iconColor ?? theme.colorScheme.onPrimary;
        } catch (e) {
          // Si falla l'accés al tema, utilitzem un valor per defecte
          defaultIconColor = iconColor ?? Colors.white;
        }
      } else {
        // Si el context no és vàlid, utilitzem un valor per defecte
        defaultIconColor = iconColor ?? Colors.white;
      }
    } catch (e) {
      // Si hi ha qualsevol altre error, utilitzem valors per defecte
      defaultIconColor = iconColor ?? Colors.white;
    }
    
    // Colors per defecte que coincideixen amb l'AppBar
    final Color defaultBgColor = backgroundColor ?? Colors.transparent;
    
    // Si tenim una icona, utilitzem un IconButton estilitzat
    if (icon != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
        clipBehavior: Clip.antiAlias, // Això farà que l'efecte splash respecti la forma
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? defaultBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: isEnabled 
                ? defaultIconColor.withAlpha(80) // Més visible
                : Colors.grey.withAlpha(60),
              width: 1.5, // Una mica més gruixuda
            ),
          ),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            splashColor: defaultIconColor.withAlpha(30),
            highlightColor: defaultIconColor.withAlpha(20),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(4.0), // Menys marge
              child: Icon(
                icon,
                color: isEnabled ? defaultIconColor : Colors.grey,
                size: iconSize ?? 24.0,
              ),
            ),
          ),
        ),
      );
    } 
    // Si no, farem servir un TextButton estilitzat per a AppBar
    else {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
        clipBehavior: Clip.antiAlias, // Assegura que l'efecte splash respecta la forma
        child: Container(
          decoration: BoxDecoration(
            color: isEnabled ? defaultBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: isEnabled 
                ? defaultIconColor.withAlpha(80) // Més visible
                : Colors.grey.withAlpha(60),
              width: 1.5, // Una mica més gruixuda
            ),
          ),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            splashColor: defaultIconColor.withAlpha(30),
            highlightColor: defaultIconColor.withAlpha(20),
            child: Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), // Menys marge
              child: Text(label, style: TextStyle(
                color: isEnabled ? defaultIconColor : Colors.grey,
              )),
            ),
          ),
        ),
      );
    }
  }
}
