// Especialització d'AppBar per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench2/theme/text_styles.dart';
import 'package:ld_wbench2/tools/null_mang.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_action_button.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_ctrl.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_state.dart';

final  barHeight = kToolbarHeight + MediaQuery.of(Get.context!).padding.top;
class LdAppBar<
  S extends LdAppBarState<S, C, SV, CV>, 
  C extends LdAppBarCtrl<C, S, CV, SV>,
  SV extends LdViewState<SV, CV>,
  CV extends LdViewCtrl<CV, SV>>
extends LdWidget<S, C> {
  // ESTÀTICS -------------------------
  static String className = "LdAppBar";

  // MEMBRES --------------------------

  // CONSTRUCTORS ---------------------
  LdAppBar({
    super.key, String? pTag,
    bool showDrawerIcon = false,
    bool showBackButton = false,
    List<LdActionButton>? pActions,
    required super.pState, required super.pVCtrl, required vCtrl,
  }): super(pTag: pTag?? WidgetKey.appBar.idx);
  
  
  @override
  // TODO: implement initialized
  bool get initialized => throw UnimplementedError();
  
  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();
  
  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => throw UnimplementedError();
  
  @override
  void onInit() {
    // TODO: implement onInit
  }
  
  @override
  void onReady() {
    // TODO: implement onReady
  }
  
  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => throw UnimplementedError();
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
          (length, dids, ratio) = _viewCtrl.vState.stats;
          if (_viewCtrl.vState.isPreparing) {
            return SizedBox(
              width: null,
              height: 2.h,
              child: LinearProgressIndicator(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                minHeight: 2.h,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(_fgColor),
                value: ratio,
              ),
            );
          } else if (_viewCtrl.vState.isLoading) {
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
