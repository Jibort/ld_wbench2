// Widget per a la selecció d'una bandera.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdCheckWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdCheckWidget";

  // CONSTRUCTORS ---------------------
  LdCheckWidget({
    super.key,
    String? pTag,
    required String label,
    bool initialValue = false,
    bool tristate = false,
    bool enabled = true,
    ValueChanged<bool?>? onChanged,
    FormFieldValidator<bool>? validator,
    required super.pVCtrl,
  }) : super(
          pState: LdCheckWidgetState(
            pTag: pTag ?? 'check_${DateTime.now().millisecondsSinceEpoch}',
            pLabel: label,
            pVCtrl: pVCtrl,
            pInitialValue: initialValue,
          ),
        ) {
    ctrl = LdCheckWidgetCtrl(
      pVCtrl: vCtrl,
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
  // MEMBRES --------------------------
  bool _value;
  bool _isValid = true;
  String? _errorText;

  // CONSTRUCTORS ---------------------
  LdCheckWidgetState({
    required super.pTag,
    required super.pVCtrl,
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
  // MEMBRES --------------------------
  final String label;
  final bool tristate;
  final bool enabled;
  final ValueChanged<bool?>? onChanged;
  final FormFieldValidator<bool>? validator;
  
  final GlobalKey<FormFieldState<bool>> _fieldKey = GlobalKey<FormFieldState<bool>>();

  // CONSTRUCTORS ---------------------
  LdCheckWidgetCtrl({
    required super.pVCtrl,
    required super.pState,
    super.pTag,
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
    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.reset();
    }
  }

  @override
  void onInit() {
    super.onInit();
    Debug.debug(DebugLevel.debug_1, "[onInit.${runtimeType.toString()}]: El controlador del widget checkbox ha estat inicialitzat.");
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
                
                // Netegem l'error si canvia a true
                if (newValue && (state as LdCheckWidgetState).errorText != null) {
                  (state as LdCheckWidgetState).errorText = null;
                }
                
                // Si canvia a true i hi havia un error, validem de nou
                if (newValue && field.hasError && validator != null) {
                  final error = validator!(newValue);
                  field.validate();
                  
                  // Actualitzem l'estat
                  (state as LdCheckWidgetState).errorText = error;
                  (state as LdCheckWidgetState).isValid = error == null;
                }
                
                // Notifiquem el canvi
                if (isNotNull(onChanged)) {
                  onChanged!(newValue);
                }
                
                // Actualitzem la UI
                notify(pTgts: [tag]);
              } : null,
              child: Row(
                children: [
                  Checkbox(
                    value: (state as LdCheckWidgetState).value,
                    tristate: tristate,
                    onChanged: enabled 
                      ? (bool? newValue) {
                          if (newValue != null) {
                            // Utilitzem el mateix codi que a onTap de InkWell
                            (state as LdCheckWidgetState).value = newValue;
                            field.didChange(newValue);
                            
                            // Netegem l'error si canvia a true
                            if (newValue && (state as LdCheckWidgetState).errorText != null) {
                              (state as LdCheckWidgetState).errorText = null;
                            }
                            
                            // Actualitzem l'estat
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
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: Theme.of(pCtx).colorScheme.error, fontSize: 12.0),
                ),
              ),
          ],
        );
      },
    );
  }
}