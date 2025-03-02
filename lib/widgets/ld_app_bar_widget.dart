// Especialització d'AppBar per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/translations/tr.dart';
import 'package:ld_wbench2/views/widget_key.dart';

// WIDGET 'LdAppBarWidget' ============
class LdAppBarWidget 
extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdAppBar";

  // 🛠️ CONSTRUCTORS ---------------------
  LdAppBarWidget({
    super.key, 
    required String pTag,
    required LdViewState pViewState,
    required String pTitle, 
    String? pSubtitle, 
    bool showDrawerIcon = false,
    bool showBackButton = false,
    List<Widget>? pActions,
  }): super( 
        pViewCtrl: pViewState.viewCtrl,
        pState: LdAppBarState(
          pViewCtrl: pViewState.viewCtrl,
          pViewState: pViewState,
          pTitle: pTitle, 
          pSubtitle: pSubtitle, 
        )) {
    ctrl = LdAppBarCtrl(
      pViewCtrl: viewCtrl, 
      pState: state as LdAppBarState,
      pActions: pActions,
      showDrawerIcon: showDrawerIcon,
      showBackButton: showBackButton,
    );
  }
} // LdAppBarWidget

class LdAppBarState
 extends LdWidgetState {

  // 🧩 MEMBRES --------------------------
  String _title;
  String? _subtitle;

  // 🛠️ CONSTRUCTORS ---------------------
  LdAppBarState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pViewState,
    required super.pViewCtrl, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle,
    super(pLabel: "LdAppBarWidget");
    
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
} // class LdAppBarState

class LdAppBarCtrl
 extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  GetBuilder<LdViewCtrl>? getBuilder;
  final List<Widget>? pActions;
  final bool showDrawerIcon;
  final bool showBackButton;
  
  // 🛠️ CONSTRUCTORS ---------------------
  LdAppBarCtrl({ 
    required super.pViewCtrl, 
    required LdAppBarState pState, 
    this.pActions,
    this.showDrawerIcon = false,
    this.showBackButton = false,
  }): super(pTag: WidgetKey.appBar.idx, pState: pState);

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    return state.isLoading
      ? buildLoadingWidget(pCtx)
      : buildLoadedWidget(pCtx);
  }

  Widget? buildLeadingIcon(BuildContext pCtx) {
    return (showBackButton)
      ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(pCtx).pop())
      : (showDrawerIcon)
        ? IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(pCtx).openDrawer();
          })
        : null;
  }
   
  Widget buildLoadingWidget(BuildContext pBCtx) {
    final barState = state as LdAppBarState;

    // Cos de la barra.
    getBuilder ??= GetBuilder<LdViewCtrl>( // GetBuilder<LdViewCtrl>(
      id: WidgetKey.appBarProgress.idx,
      tag: WidgetKey.appBarProgress.idx,
      init: viewCtrl,
      builder: (pCtx) {
        var (int iLen, int iDids, double? dRatio) = viewCtrl.state.stats;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${Tr.loading.tr}...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text((dRatio != null) 
                ? "$iDids ${Tr.of.tr} $iLen (${(dRatio * 100).toStringAsPrecision(3)}%)"
                : "$iDids ${Tr.of.tr} $iLen",
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.normal,
                color: barState.viewState.isError ? Colors.red : null
              ),
            ),
            LinearProgressIndicator(
              minHeight: 5.0.h,
              value: dRatio,
              // color: Colors.blue,
              backgroundColor: Theme.of(pBCtx).colorScheme.primary,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(pBCtx).colorScheme.onPrimary),
            ),
          ],
        );
      }
    ); 
    
    return AppBar(
      title: getBuilder!,
      elevation: 4.0,
      centerTitle: false,
      backgroundColor: Theme.of(pBCtx).colorScheme.primary,
      foregroundColor: Theme.of(pBCtx).colorScheme.onPrimary,
    );
  }

  Widget buildLoadedWidget(BuildContext pCtx) {
    final barState = state as LdAppBarState;

    // Configuració del leading icon
    Widget? leadingIcon = buildLeadingIcon(pCtx);

    // Cos de la barra.
    Widget body;

    // Construir el títol amb subtítol si existeix
    if (barState.subtitle == null) {
      // Només apareix el títol.
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(barState.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      );

    } else {
      // Apareixen tant el títol com el subtítol.
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(barState.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(barState.subtitle!,
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.normal,
              color: barState.viewState.isError ? Colors.red : null
            ),
          ),
        ],
      );
    }

    return AppBar(
      title: body,
      leading: leadingIcon,
      titleSpacing: 0.0.h,
      actions: pActions,
      elevation: 4.0,
      centerTitle: false,
      backgroundColor: Theme.of(pCtx).colorScheme.primary,
      foregroundColor: Theme.of(pCtx).colorScheme.onPrimary,
    );
  }

} // class LdAppBarWidget