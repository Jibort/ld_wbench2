// Especialització d'AppBar per a l'aplicació Sabina.
// CreatedAt: 2025/02/16 dg. GPT[JIQ]

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_id.dart';
import 'package:ld_wbench2/core/ld_view_controller.dart';
import 'package:ld_wbench2/tools/null_mang.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_action_button.dart';

class LdAppBar extends AppBar with LdId {
  // ESTÀTICS -------------------------
  static String className = "LdAppBar";

  // CONSTRUCTORS ---------------------
  LdAppBar({
    super.key,
    String? pTag,
    required String title,
    bool showDrawerIcon = false,
    bool showBackButton = false,
    super.actions,
    required LdViewController pVCtrl,
  }): super(
          title: GetBuilder<LdViewController>(
            init: pVCtrl,
            id: WidgetKey.appBar.idx,
            builder: (LdViewController pCtrl) {
                return Column(children: [
                  (pCtrl.vState.isLoaded)
                      ? _TitleWidget(pCtrl.vState.title, LdActionButton(icon: Icon(Icons.adb_outlined), onPressed: () {  },),
                          pSubTitle: pCtrl.vState.subtitle,
                          // pFgColor: pFgColor ?? Theme.of(pCxt).primaryColor,
                          // pActions: pActions
                        )
                      : _ProgressTitleWidget(
                          pCxt: Get.context!,
                          pCtrl,
                          pBgColor: Theme.of(Get.context!).scaffoldBackgroundColor,  // pBgColor ?? 
                          pFgColor: Theme.of(Get.context!).primaryColor, // pFgColor ?? 
                        )
                ]);
              },  
            )
      );
}

class _ProgressTitleWidget extends GetWidget {
  // MEMBRES --------------------------
  final LdViewController _viewCtrl;
  final String _title;
  final Color _fgColor;

  // CONSTRUCTORS ---------------------
  _ProgressTitleWidget(this._viewCtrl, {required BuildContext pCxt, String? pTitle, Color? pBgColor, Color? pFgColor})
      : _title = pTitle ?? "Carregant...",
        _fgColor = pFgColor ?? Theme.of(pCxt).appBarTheme.foregroundColor?? Colors.black;

  // WIDGET ---------------------------
  @override
  Widget build(BuildContext pCxt) {
    return GetBuilder<LdViewController>(
        id: WidgetKey.appBarProgress.idx,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (isNotNull(_leading)) ? _leading! : const SizedBox(),
        (isNull(_subTitle))
            ? Text(_title, style: Get.theme.textTheme.headlineLarge) // txsAppBarMainTitleStyle(pCxt: pCxt, pFgColor: _fgColor))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_title, style: Get.theme.textTheme.headlineMedium), // txsAppBarTitleStyle(pCxt: pCxt, pFgColor: _fgColor)),
                  Text(_subTitle!, style: Get.theme.textTheme.headlineSmall), // txsAppBarSubtitleStyle(pCxt: pCxt, pFgColor: _fgColor))
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
