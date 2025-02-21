// Estat del widget LdScaffold.
// CreatedAt: 2025/02/19 dc. JIQ

import 'package:get/get_instance/src/lifecycle.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/widgets/ld_app_bar.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_ctrl.dart';
import 'package:ld_wbench2/widgets/ld_app_bar_state.dart';

class LdScaffoldState<
  S extends LdWidgetState<S, C>, 
  C extends LdWidgetCtrl<C, S>,
  SA extends LdAppBarState<SA, CA, SV, CV>,
  CA extends LdAppBarCtrl<CA, SA, CV, SV>,
  SV extends LdViewState<SV, CV>,
  CV extends LdViewCtrl<CV, SV>>
extends LdWidgetState<S, C> {
  // MEMBRES --------------------------
  String _title;
  String? _subtitle;

  // CONSTRUCTORS ---------------------
  LdScaffoldState({
    required String pTitle, 
    String? pSubtitle, 
    required super.pTag, 
    required super.pVCtrl, 
    required super.pLabel, 
  }): 
    _title = pTitle,
    _subtitle = pSubtitle {
      _appBar = LdAppBar(pTag: super.tag, pVCtrl: super.vCtrl, vCtrl: null, pState: null,);

    }

  bool get initialized => throw UnimplementedError();
  bool get isClosed => throw UnimplementedError();
  bool get isError => throw UnimplementedError();
  bool get isLoaded => throw UnimplementedError();
  bool get isLoading => throw UnimplementedError();
  bool get isLoadingAgain => throw UnimplementedError();
  bool get isNew => throw UnimplementedError();
  bool get isPreparing => throw UnimplementedError();
  bool get isPreparingAgain => throw UnimplementedError();

  @override
  void loadData() {
    // TODO: implement loadData
  }

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