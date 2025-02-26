// Especialització d'Scaffold per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/widgets/ld_app_bar.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/views/widget_key.dart';

// WIDGET 'LdScaffold' ================
class LdScaffold
extends LdWidget {
  // ESTÀTICS -------------------------
  static const className = "LdScaffold";

  // CONSTRUCTORS ---------------------
  LdScaffold({
    super.key,
    String? pTag,
    required LdViewState pViewState,
    required String pTitle,
    String? pSubtitle,
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
  }) : super(
    pVCtrl: pViewState.vCtrl,
    pState: LdScaffoldState(
      pTag: pTag ?? WidgetKey.scaffold.idx,
      pTitle: pTitle,
      pSubtitle: pSubtitle,
      pVCtrl: pViewState.vCtrl,
      pLabel: className
    )) {
  ctrl = LdScaffoldCtrl(
    pTag: pTag ?? WidgetKey.scaffold.idx,
    pVCtrl: pViewState.vCtrl,
    pTitle: pTitle,
    pSubtitle: pSubtitle,
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
  );}
}

// ESTAT 'LdScaffoldState' ============
class LdScaffoldState
extends LdWidgetState {
  // MEMBRES --------------------------
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

  // CONSTRUCTORS ---------------------
  LdScaffoldState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pTag, 
    required super.pVCtrl, 
    required super.pLabel, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle;

  @override
  void loadData() { }  
}

// CTRL 'LdScaffoldCtrl' ==============
class LdScaffoldCtrl
extends LdWidgetCtrl {
  // MEMBRES --------------------------
  LdAppBar? _appBar;
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

  // CONSTRUCTORS ---------------------
  LdScaffoldCtrl({
    super.pTag, 
    required super.pVCtrl, 
    required String pTitle, 
    String? pSubtitle,
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
  }): super(pState: LdScaffoldState(
      pLabel: "LdScaffoldState",
      pTitle: pTitle, 
      pSubtitle: pSubtitle,
      pVCtrl: pVCtrl, 
      pTag: pTag));
  
  // GETTERS/SETTERS ------------------
  @override
  LdScaffoldState get state => super.state as LdScaffoldState;

  // 'LdWidgetCtrl' -------------------
  @override
  @override
Widget buildWidget(BuildContext pCtx) {
  // Obtenim el PreferredSizeWidget des de _appBar
  final appBarWidget = _appBar != null ? (_appBar?.ctrl as LdAppBarCtrl).buildWidget(pCtx) as PreferredSizeWidget : null;
  
  return Scaffold(
    appBar: appBarWidget,
    body: (state.isNew || state.isLoading || state.isLoadingAgain)
        ? const Center(child: CircularProgressIndicator())
        : (wgtBody != null)
            ? wgtBody
            : viewCtrl.buildView(pCtx),
    floatingActionButton: btnFloatAction,
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

  // 🔄 'GetLifeCycleMixin' ------------
  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  @override
  void onInit() {
    LdScaffoldState state = super.state as LdScaffoldState;
    _appBar ??= LdAppBar(pTitle: state.title, pLabel: state.label, pVCtrl: viewCtrl);    
    super.onInit();
  }

  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  @override
  void onReady() {
    // TODO: Codificar abans de cridar a suoer.onReady().
    super.onReady();
  }

  /// Called before [onDelete] method. [onClose] might be used to
  /// dispose resources used by the controller. Like closing events,
  /// or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  @override
  void onClose() {
    // TODO: Codificar abans de cridar a suoer.onClose().
    super.onClose();
  }  
}