// Especialització d'Scaffold per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_widget.dart';

// WIDGET 'LdScaffoldWidget' ==========
class LdScaffoldWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static const className = "LdScaffold";

  // 🛠️ CONSTRUCTORS ---------------------
  LdScaffoldWidget({
    super.key,
    String? pTag,
    required LdViewState pViewState,
    required String pTitle,
    String? pSubtitle,
    List<Widget>? pActions,
    LdWidget? btnFloatAction,
    LdWidget? wgtBody,
    FloatingActionButtonLocation? locBtnFloatAction,
    FloatingActionButtonAnimator? aniBtnFloatAction,
    List<Widget>? btnsPersFooter,
    Widget? panDrawer,
    ValueChanged<bool>? onChangedDrawer,
    Widget? panEndDrawer,
    ValueChanged<bool>? onChangedEndDrawer,
    Widget? barBottomNav,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool primary = true,
    DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start,
    bool extendBody = true,
    bool extendBodyBehindAppBar = false,
    Color? drawerScrimColor = Colors.black54,
    double? drawerEdgeDragWidth = 20.0,
    bool drawerEnableOpenDragGesture = true,
    bool endDrawerEnableOpenDragGesture = true,
    String? restorationId,
  }): super(
    pViewCtrl: pViewState.viewCtrl,
    pState: LdScaffoldState(
      pTitle: pTitle,
      pSubtitle: pSubtitle,
      pViewCtrl: pViewState.viewCtrl,
      pViewState: pViewState,
      pLabel: className
    )) {
    tag = pTag ?? WidgetKey.scaffold.idx;
    typeName = className;
    
    // Crear explícitament el controlador amb tots els paràmetres
    ctrl = LdScaffoldCtrl(
      pTag: tag,
      pViewCtrl: pViewState.viewCtrl,
      pState: state,
      pTitle: pTitle,
      pSubtitle: pSubtitle,
      actions: pActions,
      showDrawerIcon: true,
      showBackButton: false,
      btnFloatAction: btnFloatAction,
      wgtBody: wgtBody,
      locBtnFloatAction: locBtnFloatAction,
      aniBtnFloatAction: aniBtnFloatAction,
      btnsPersFooter: btnsPersFooter,
      panDrawer: panDrawer,
      onChangedDrawer: onChangedDrawer,
      panEndDrawer: panEndDrawer,
      onChangedEndDrawer: onChangedEndDrawer,
      barBottomNav: barBottomNav,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }
}

// ESTAT 'LdScaffoldState' ============
class LdScaffoldState extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  String _title;
  String? _subtitle;

  // GETTERS/SETTERS ------------------
  String get title => _title;
  String? get subtitle => _subtitle;
  void setTitles({required String pTitle, String? pSubtitle}) {
    _title = pTitle;
    _subtitle = pSubtitle;
    ctrl.notify(pTgts: [ ctrl.tag ]);    
  }

  // 🛠️ CONSTRUCTORS ---------------------
  LdScaffoldState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pViewCtrl, 
    required super.pViewState,
    required super.pLabel, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle;

  @override
  void loadData() {
    // No cal carregar dades específiques
  }  
}

// CTRL 'LdScaffoldCtrl' ==============
class LdScaffoldCtrl extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String _title;
  final String? _subtitle;
  bool showDrawerIcon;
  bool showBackButton;
  final List<Widget>? actions;
  final LdWidget? btnFloatAction;
  final LdWidget? wgtBody;
  final FloatingActionButtonLocation? locBtnFloatAction;
  final FloatingActionButtonAnimator? aniBtnFloatAction;
  final List<Widget>? btnsPersFooter;
  final Widget? panDrawer;
  final ValueChanged<bool>? onChangedDrawer;
  final Widget? panEndDrawer;
  final ValueChanged<bool>? onChangedEndDrawer;
  final Widget? barBottomNav;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  
  // AppBar dedicat
  late final LdAppBarWidget? _appBar;

  // 🛠️ CONSTRUCTORS ---------------------
  LdScaffoldCtrl({
    required super.pTag, 
    required super.pViewCtrl, 
    required super.pState,
    required String pTitle, 
    String? pSubtitle,
    this.actions,
    this.showDrawerIcon = false,
    this.showBackButton = false,
    this.btnFloatAction,
    this.wgtBody,
    this.locBtnFloatAction,
    this.aniBtnFloatAction,
    this.btnsPersFooter,
    this.panDrawer,
    this.onChangedDrawer,
    this.panEndDrawer,
    this.onChangedEndDrawer,
    this.barBottomNav,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = true,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor = Colors.black54,
    this.drawerEdgeDragWidth = 20.0,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }): 
    _title = pTitle,
    _subtitle = pSubtitle {
      // Inicialitzem explícitament l'AppBar
      _appBar = LdAppBarWidget(
        pTag: WidgetKey.appBar.idx,
        pTitle: _title, 
        pSubtitle: _subtitle,
        pViewState: viewCtrl.state,
        showDrawerIcon: showDrawerIcon,
        showBackButton: showBackButton,
        pActions: actions,
      );
    }
  
  // GETTERS/SETTERS ------------------
  @override
  LdScaffoldState get state => super.state as LdScaffoldState;

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    // Construïm l'AppBar de forma adequada
    final appBarWidget = PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: _appBar!.build(pCtx),
    );
    
    // Obtenim els widgets reals des de LdWidget
    final bodyWidget = wgtBody != null 
        ? wgtBody!.build(pCtx) 
        : (state.isNew || state.isLoading || state.isLoadingAgain)
            ? const Center(child: CircularProgressIndicator())
            : viewCtrl.buildView(pCtx);
    
    final fabWidget = btnFloatAction?.build(pCtx);
    
    return Scaffold(
      appBar: appBarWidget,
      body: bodyWidget,
      floatingActionButton: fabWidget,
      floatingActionButtonLocation: locBtnFloatAction,
      floatingActionButtonAnimator: aniBtnFloatAction,
      persistentFooterButtons: btnsPersFooter,
      drawer: panDrawer,
      onDrawerChanged: onChangedDrawer,
      endDrawer: panEndDrawer,
      onEndDrawerChanged: onChangedEndDrawer,
      bottomNavigationBar: barBottomNav,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor ?? Theme.of(pCtx).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }  
}