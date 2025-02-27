// Especialització d'AppBar per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

// lib/widgets/ld_app_bar_widget.dart
// Especialització d'AppBar per a l'aplicació Sabina.
// Revisió i simplificació per a corregir problemes.

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/views/widget_key.dart';

// WIDGET 'LdAppBarWidget' ============
class LdAppBarWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdAppBar";

  // CONSTRUCTORS ---------------------
  LdAppBarWidget({
    super.key, 
    String? pTag,
    required LdViewState pViewState,
    required String pTitle, 
    String? pSubtitle, 
    String? pLabel, 
    bool showDrawerIcon = false,
    bool showBackButton = false,
    List<Widget>? pActions,
  }): super( 
        pVCtrl: pViewState.vCtrl,
        pState: LdAppBarState(
          pTitle: pTitle, 
          pSubtitle: pSubtitle, 
          pLabel: pLabel ?? "AppBar",
          pTag: pTag ?? WidgetKey.appBar.idx,
          pVCtrl: pViewState.vCtrl,
        )) {
    // Inicialitzar el controlador directament
    ctrl = LdAppBarCtrl(
      pVCtrl: vCtrl, 
      pState: state,
      pActions: pActions,
      showDrawerIcon: showDrawerIcon,
      showBackButton: showBackButton,
    );
    
    // Explícitament assignar el controlador a l'estat
    state.wCtrl = ctrl;
    
    Debug.debug(DebugLevel.debug_0, "[LdAppBarWidget.constructor]: AppBar creat amb títol: $pTitle");
  }
}

class LdAppBarState extends LdWidgetState {
  // MEMBRES --------------------------
  String _title;
  String? _subtitle;

  // CONSTRUCTORS ---------------------
  LdAppBarState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pTag, 
    required super.pVCtrl, 
    required super.pLabel, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle;
    
  @override
  void loadData() {
    // No cal carregar dades específiques
  }

  // GETTERS/SETTERS ------------------
  String get title => _title;
  set title(String value) {
    _title = value;
    ctrl.notify(pTgts: [ctrl.tag]);
  }

  String? get subtitle => _subtitle;
  set subtitle(String? value) {
    _subtitle = value;
    ctrl.notify(pTgts: [ctrl.tag]);
  }
}

class LdAppBarCtrl extends LdWidgetCtrl {
  // MEMBRES --------------------------
  final List<Widget>? pActions;
  final bool showDrawerIcon;
  final bool showBackButton;
  
  // CONSTRUCTORS ---------------------
  LdAppBarCtrl({ 
    required super.pVCtrl, 
    required super.pState, 
    super.pTag,
    this.pActions,
    this.showDrawerIcon = false,
    this.showBackButton = false,
  });

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    Debug.debug(DebugLevel.debug_0, "[LdAppBarCtrl.buildWidget]: Construint AppBar");
    
    // Obtenir l'estat
    final appBarState = state as LdAppBarState;
    
    // Configuració del leading icon
    Widget? leadingIcon;
    if (showBackButton) {
      leadingIcon = IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(pCtx).pop(),
      );
    } else if (showDrawerIcon) {
      leadingIcon = IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(pCtx).openDrawer();
        },
      );
    }
    
    // Construir el títol amb subtítol si existeix
    Widget titleWidget;
    if (appBarState.subtitle != null) {
      titleWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appBarState.title, style: TextStyle(fontSize: 16)),
          Text(
            appBarState.subtitle!,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          ),
        ],
      );
    } else {
      titleWidget = Text(appBarState.title);
    }
    
    // Retornar l'AppBar
    return AppBar(
      title: titleWidget,
      leading: leadingIcon,
      actions: pActions,
      elevation: 4.0,
      centerTitle: false,
      backgroundColor: Theme.of(pCtx).colorScheme.primary,
      foregroundColor: Theme.of(pCtx).colorScheme.onPrimary,
    );
  }
}