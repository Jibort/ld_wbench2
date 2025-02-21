// Controlador del Widget LdScaffold.
// CreatedAt: 2025/02/20 dj. JIQ

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/theme/text_styles.dart';
import 'package:ld_wbench2/tools/null_mang.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_action_button.dart';
import 'package:ld_wbench2/widgets/ld_app_bar.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_state.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';

class LdAppBarCtrl<
  C extends LdAppBarCtrl<C, S, CV, SV>, 
  S extends LdAppBarState<S, C, SV, CV>,
  CV extends LdViewCtrl<CV, SV>, 
  SV extends LdViewState<SV, CV>>
extends LdWidgetCtrl<C, S> {
  // MEMBRES --------------------------
  Widget? _appBar;
  
  // CONSTRUCTORS ---------------------
  LdAppBarCtrl({ required LdViewCtrl<CV, SV> pVCtrl, required super.pState, super.pTag })
  : super();

  // 'LdWidgetCtrl' -------------------
  @override
  Widget buildWidget(BuildContext pCtx) {
    _appBar ??= PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(pCtx).padding.top*2), // Size.fromHeight(barHeight),
      child: AppBar(
        title: GetBuilder<C>(
            init: ,
            id: WidgetKey.appBar.idx,
            tag: WidgetKey.appBar.idx,
            builder: (C pCtrl) {
                return Column(children: [
                  (pCtrl.state.isLoaded)
                      ? _TitleWidget(pCtrl.state.title, LdActionButton(icon: Icon(Icons.adb_outlined), onPressed: () {  }, pState: null, pVCtrl: null,),
                          pSubTitle: pCtrl.state.subtitle,
                          // pFgColor: pFgColor ?? Theme.of(pCxt).primaryColor,
                          pActions: [],
                        )
                      : _ProgressTitleWidget(
                          vCtrl,
                          pCtrl: pCtrl,
                          pSubTitle: pCtrl.state.subtitle,
                          pBgColor: Theme.of(Get.context!).scaffoldBackgroundColor,  // pBgColor ?? 
                          pFgColor: Theme.of(Get.context!).primaryColor, // pFgColor ?? 
                        )
                ]);
              },  
            ),
      )
    );
    return _appBar;
  }

   @override
  Widget build(BuildContext pCtx) {
    return 
  }
 
}

class _ProgressTitleWidget extends GetWidget {
  // MEMBRES --------------------------
  final LdViewCtrl _viewCtrl;
  final String _title;
  final Color _fgColor;

  // CONSTRUCTORS ---------------------
  _ProgressTitleWidget(this._viewCtrl, {required BuildContext pCxt, String? pTitle, Color? pBgColor, Color? pFgColor})
      : _title = pTitle ?? "Carregant...",
        _fgColor = pFgColor ?? Theme.of(pCxt).appBarTheme.foregroundColor?? Colors.black;

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
