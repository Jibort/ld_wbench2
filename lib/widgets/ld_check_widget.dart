// Widget per a la selecció d'una bandera.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdCheckWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdCheckWidget";

  // 🛠️ CONSTRUCTORS ---------------------
  LdCheckWidget({
    super.key,
    required String pTag,
    required String label,
    bool initialValue = false,
    bool tristate = false,
    bool enabled = true,
    ValueChanged<bool?>? onChanged,
    FormFieldValidator<bool>? validator,
    required super.pViewCtrl,
    required LdViewState pViewState,
  }) : super(
          pState: LdCheckWidgetState(
            pLabel: label,
            pViewCtrl: pViewCtrl,
            pViewState: pViewState,
            pInitialValue: initialValue,
          ),
        ) {
    ctrl = LdCheckWidgetCtrl(
      pViewCtrl: viewCtrl,
      pState: state,
      pTag: pTag,
      label: label,
      tristate: tristate,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
    );
  }
  
  // METHODS --------------------------
  bool get value => (state as LdCheckWidgetState).value;
  set value(bool val) => (state as LdCheckWidgetState).value = val;
  
  bool validate() => (ctrl as LdCheckWidgetCtrl).validate();
  void reset() => (ctrl as LdCheckWidgetCtrl).reset();
}

class LdCheckWidgetState extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  bool _value;
  bool _isValid = true;
  String? _errorText;

  // 🛠️ CONSTRUCTORS ---------------------
  LdCheckWidgetState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
    required bool pInitialValue,
  }) : _value = pInitialValue;

  // GETTERS/SETTERS ------------------
  bool get value => _value;
  set value(bool val) {
    _value = val;
    ctrl.notify(pTgts: [ctrl.tag]);
  }
  
  bool get isValid => _isValid;
  set isValid(bool val) {
    _isValid = val;
    ctrl.notify(pTgts: [ctrl.tag]);
  }
  
  String? get errorText => _errorText;
  set errorText(String? val) {
    _errorText = val;
    ctrl.notify(pTgts: [ctrl.tag]);
  }
  
  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdCheckWidgetCtrl extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String label;
  final bool tristate;
  final bool enabled;
  final ValueChanged<bool?>? onChanged;
  final FormFieldValidator<bool>? validator;
  
  final GlobalKey<FormFieldState<bool>> _fieldKey = GlobalKey<FormFieldState<bool>>();

  // 🛠️ CONSTRUCTORS ---------------------
  LdCheckWidgetCtrl({
    required super.pViewCtrl,
    required super.pState,
    required super.pTag,
    required this.label,
    required this.tristate,
    required this.enabled,
    this.onChanged,
    this.validator,
  });

  // PUBLIC METHODS -------------------
  bool validate() {
    if (_fieldKey.currentState != null && isNotNull(validator)) {
      final isValid = _fieldKey.currentState!.validate();
      (state as LdCheckWidgetState).isValid = isValid;
      return isValid;
    }
    return true;
  }
  
  void reset() {
    (state as LdCheckWidgetState).value = false;
    (state as LdCheckWidgetState).errorText = null;
    (state as LdCheckWidgetState).isValid = true;
    
    // Reiniciar l'estat del FormField
    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.reset();
      // Important: Forçar la reconstrucció amb un valor nou
      _fieldKey.currentState!.didChange(false);
    }
    
    // Notificar el canvi explícitament
    notify();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    return FormField<bool>(
      key: _fieldKey,
      initialValue: (state as LdCheckWidgetState).value,
      validator: validator,
      builder: (FormFieldState<bool> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: enabled ? () {
                bool newValue = !(state as LdCheckWidgetState).value;
                
                // Actualitzem el valor
                (state as LdCheckWidgetState).value = newValue;
                field.didChange(newValue);
                
                // Notifiquem el canvi
                if (isNotNull(onChanged)) {
                  onChanged!(newValue);
                }
                
                // IMPORTANT: Validem immediatament
                if (validator != null) {
                  final error = validator!(newValue);
                  (state as LdCheckWidgetState).errorText = error;
                  (state as LdCheckWidgetState).isValid = error == null;
                }
                
                // Actualitzem la UI
                notify(pTgts: [tag]);
              } : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: (state as LdCheckWidgetState).value,
                        tristate: tristate,
                        onChanged: enabled 
                          ? (bool? newValue) {
                              if (newValue != null) {
                                // Actualitzem el valor directament
                                (state as LdCheckWidgetState).value = newValue;
                                field.didChange(newValue);
                                
                                // Validem immediatament
                                if (validator != null) {
                                  final error = validator!(newValue);
                                  (state as LdCheckWidgetState).errorText = error;
                                  (state as LdCheckWidgetState).isValid = error == null;
                                }
                                
                                if (isNotNull(onChanged)) {
                                  onChanged!(newValue);
                                }
                                
                                // Actualitzem la UI
                                notify(pTgts: [tag]);
                              }
                            }
                          : null,
                      ),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: enabled ? null : Theme.of(pCtx).disabledColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text d'error directament sota el text del checkbox, sense separació
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        field.errorText!,
                        style: TextStyle(
                          color: Theme.of(pCtx).colorScheme.error, 
                          fontSize: 12.0
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}