// Especialització d'AppBar per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/theme/text_styles.dart';
import 'package:ld_wbench2/tools/null_mang.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_action_button.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';

final  barHeight = kToolbarHeight + MediaQuery.of(Get.context!).padding.top;
class LdAppBar
extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdAppBar";

  // MEMBRES --------------------------

  // CONSTRUCTORS ---------------------
  LdAppBar({
    super.key, String? pTag,
    required String pTitle, 
    String? pSubtitle, 
    required String pLabel, 
    bool showDrawerIcon = false,
    bool showBackButton = false,
    List<LdActionButton>? pActions,
    required super.pVCtrl,
  }): super( 
        pState: LdAppBarState(
          pTitle: pTitle, pSubtitle: pSubtitle, 
          pLabel: pLabel, pTag: pTag?? WidgetKey.appBar.idx,
          pVCtrl: pVCtrl,
        )) {
    ctrl = LdAppBarCtrl(pVCtrl: vCtrl, pState: state, pTag: pTag);
  }
}

class LdAppBarState
extends LdWidgetState {
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
    
  }

  // GETTERS/SETTERS ------------------
  String get title => _title;
  set title(String value) => _title = value;

  String? get subtitle => _subtitle;
  set subtitle(String? value) => _subtitle = value;
}

class LdAppBarCtrl
extends LdWidgetCtrl {
  // MEMBRES --------------------------
  Widget? _appBar;
  
  // CONSTRUCTORS ---------------------
  LdAppBarCtrl({ required super.pVCtrl, required super.pState, super.pTag });

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    _appBar ??= PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(pCtx).padding.top*2), // Size.fromHeight(barHeight),
      child: AppBar(
        title: GetBuilder<LdAppBarCtrl>(
            init: this,
            id: WidgetKey.appBar.idx,
            tag: WidgetKey.appBar.idx,
            builder: (pCtrl) {
                return Column(children: [
                  (pCtrl.state.isLoaded)
                      ? _TitleWidget(
                          (pCtrl.state as LdAppBarState).title, 
                          LdActionButton(
                            icon: Icon(Icons.adb_outlined), 
                            onPressed: () {  }, 
                            pState: state as LdAppBarState, 
                            pVCtrl: viewCtrl,
                          ),
                          pSubTitle: (pCtrl.state as LdAppBarState).subtitle,
                          pActions: [],
                        )
                      : _ProgressTitleWidget(
                          viewCtrl,
                          pCtx: pCtx,
                          pBgColor: Theme.of(Get.context!).scaffoldBackgroundColor,  // pBgColor ?? 
                          pFgColor: Theme.of(Get.context!).primaryColor, // pFgColor ?? 
                        )
                ]);
              },  
            ),
      )
    );
    return _appBar!;
  }
}

class _ProgressTitleWidget extends GetWidget {
  // MEMBRES --------------------------
  final LdViewCtrl _viewCtrl;
  final String _title;
  final Color _fgColor;

  // CONSTRUCTORS ---------------------
  _ProgressTitleWidget(this._viewCtrl, {required BuildContext pCtx, String? pTitle, Color? pBgColor, Color? pFgColor})
      : _title = pTitle ?? "Carregant...",
        _fgColor = pFgColor ?? Theme.of(pCtx).appBarTheme.foregroundColor?? Colors.black;

  // WIDGET ---------------------------
  @override
  Widget build(BuildContext pCxt) {
    return GetBuilder<LdViewCtrl>(
        id: WidgetKey.appBarProgress.idx,
        tag: WidgetKey.appBarProgress.idx,
        init: _viewCtrl,
        builder: (context) {
          int length, dids;
          double? ratio;
          (length, dids, ratio) = _viewCtrl.state.stats;
          if (_viewCtrl.state.isPreparing) {
            return SizedBox(
              width: null,
              height: 2.0.h,
              child: LinearProgressIndicator(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                minHeight: 2.0.h,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(_fgColor),
                value: ratio,
              ),
            );
          } else if (_viewCtrl.state.isLoading) {
            return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                  "$_title: ${(isNotNull(ratio)) ? "${(ratio! * 100.0).toStringAsFixed(2)}%" : "..."}",
                  style: TextStyle(
                    fontSize: 10.0.h,
                    color: _fgColor,
                  ),
              ),
              Text(
                "$dids de $length",
                style: TextStyle(
                  fontSize: 6.0.h,
                  color: _fgColor,
                ),
              ),
              SizedBox(
                width: null,
                height: 2.h,
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  minHeight: 2.h,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(_fgColor),
                  value: ratio,
                ),
              ),
            ]);
          } else {
            return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text("Unknown State!"), // , style: txsAppBarProgressionTitleStyle(pCxt: pCxt, pFgColor: _fgColor)),
              SizedBox(
                width: null,
                height: 2.0.h,
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  minHeight: 2.0.h,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(_fgColor),
                  value: null,
                ),
              ),
            ]);
          }
        });
  }
}

class _TitleWidget extends GetWidget {
  // MEMBRES --------------------------
  final String _title;
  final String? _subTitle;
  final LdActionButton? _leading;
  final List<LdActionButton>? _actions;
  final Color _fgColor;
  // CONSTRUCTORS ---------------------
  const _TitleWidget(String pTitle, LdActionButton? pLeading,
      {String? pSubTitle, List<LdActionButton>? pActions, Color? pFgColor})
      : _title = pTitle,
        _subTitle = pSubTitle,
        _leading = pLeading,
        _actions = pActions,
        _fgColor = pFgColor ?? Colors.black;

  // WIDGET ---------------------------
  @override
  Widget build(BuildContext pCxt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isNotNull(_leading)) ...[ _leading!],
        (isNull(_subTitle))
            ? Text(_title, style: Get.theme.textTheme.headlineMedium) // txsAppBarMainTitleStyle(pCxt: pCxt, pFgColor: _fgColor))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_title, style: txsAppBarTitleStyle(pFgColor: _fgColor)),
                  Text(_subTitle!, style: txsAppBarSubtitleStyle(pFgColor: _fgColor))
                ],
              ),
        (_actions != null)
          ? Row(
            children: [
              for (var action in _actions) action,
            ])
          : Container()
      ],
    );
  }
}
