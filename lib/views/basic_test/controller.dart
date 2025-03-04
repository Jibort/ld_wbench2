import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/ld_sabina_controller.dart';
import 'package:ld_wbench2/theme/ld_theme_controller.dart';
import 'package:ld_wbench2/translations/tr.dart';
import 'package:ld_wbench2/views/basic_test/state.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_action_button_widget.dart';
import 'package:ld_wbench2/widgets/ld_button_widget.dart';
import 'package:ld_wbench2/widgets/ld_container.dart';
import 'package:ld_wbench2/widgets/ld_scaffold_widget.dart';

class   BasicTestViewCtrl 
extends LdViewCtrl {
  // 🧩 MEMBRES ------------------------
  GetBuilder<LdViewCtrl>? getBuilder;

  // 🛠️ CONSTRUCTORS -------------------
  BasicTestViewCtrl({ 
    required super.pTag, 
    required super.pState 
  }) {
    addWidgets([
      WidgetKey.scaffold.idx,
      WidgetKey.appBar.idx,
      WidgetKey.appBarProgress.idx,
      WidgetKey.pageBody.idx,
    ]);
  }

  // 📥 GETTERS/SETTERS ------------------
  BasicTestViewState get testState => state as BasicTestViewState;

  // 'LdViewCtrl' ---------------------
  @override
  Widget buildView(BuildContext pCtx) {
    getBuilder ??= GetBuilder<LdViewCtrl>( // GetBuilder<BasicTestViewCtrl>(
      id: WidgetKey.pageBody.idx,
      tag: WidgetKey.pageBody.idx,
      init: this as LdViewCtrl,
      builder: (ctrl) => _buildContent(pCtx),
    );

    return LdScaffoldWidget(
      pViewState: testState,
      pTitle: testState.title,
      pSubtitle: testState.subtitle,
      pActions: [
        LdActionButtonWidget(
          pTag: "btnToogleTheme",
          pViewCtrl: this,
          icon: Icons.mode_night_outlined,
          onPressed: () => LdThemeController.inst.toggleTheme(),
          label: "btnToogleTheme",
          pViewState: state,
        ), 
        LdActionButtonWidget(
          pTag: "btnAux_01",
          pViewCtrl: this,
          icon: Icons.more_vert,
          onPressed: () {}, 
          label: "btnAux_01", 
          pViewState: state, 
        ),
      ],
      btnFloatAction: LdActionButtonWidget(
        pTag: "btnToogleTheme_2",
        pViewCtrl: this,
        icon: Icons.mode_night_outlined,
        onPressed: () => LdSabinaController.inst.toggleTheme(),
        label: "btnToogleTheme_2", 
        pViewState: state, 
      ),
      wgtBody: LdContainer(
        pTag: "${tag}_LdScaffoldWidget",
        pViewCtrl: this,
        pViewState: state,
        child: getBuilder!,
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    final bool isLoading = testState.isLoading || testState.isPreparing;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLoadableSection(
              context, 
              isLoading: isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informació bàsica', 
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildLoadableTextField(
                    context, 
                    isLoading: isLoading, 
                    label: 'Nom',
                  ),
                  const SizedBox(height: 16),
                  _buildLoadableTextField(
                    context, 
                    isLoading: isLoading, 
                    label: 'Correu electrònic',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            _buildLoadableSection(
              context, 
              isLoading: isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalls addicionals', 
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  _buildLoadableTextField(
                    context, 
                    isLoading: isLoading, 
                    label: 'Telèfon',
                  ),
                  const SizedBox(height: 16),
                  _buildLoadableTextField(
                    context, 
                    isLoading: isLoading, 
                    label: 'Adreça',
                  ),
                ],
              ),
            ),
            
            if (!isLoading)
              LdButtonWidget(
                pTag: "btnSave",
                pViewCtrl: this,
                pViewState: state,
                enabled: true,
                onPressed: () => testState.reset(),
                label: Tr.reload.tr,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadableSection(
    BuildContext context, {
    required bool isLoading,
    required Widget child,
  }) {
    return Card(
      child: Stack(
        children: [
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(100),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade200.withAlpha(100),
                        Colors.grey.shade300.withAlpha(100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadableTextField(
    BuildContext context, {
    required bool isLoading,
    required String label,
  }) {
    return TextField(
      enabled: !isLoading,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: isLoading,
        fillColor: isLoading ? Colors.grey[200] : null,
      ),
    );
  }
}