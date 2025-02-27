// Camp d'edició de text (obert o ofuscat).
// CreatedAt: 2025/02/27 dj. JIQ

// lib/widgets/ld_edit_widget.dart
import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdEditWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdEditWidget";

  // CONSTRUCTORS ---------------------
  LdEditWidget({
    super.key,
    String? pTag,
    required String label,
    String? initialValue,
    String? hintText,
    bool obscureText = false,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    FormFieldValidator<String>? validator,
    int? maxLength,
    required super.pVCtrl,
  }) : super(
          pState: LdEditWidgetState(
            pTag: pTag ?? 'edit_${DateTime.now().millisecondsSinceEpoch}',
            pLabel: label,
            pVCtrl: pVCtrl,
            pInitialValue: initialValue ?? '',
          ),
        ) {
    ctrl = LdEditWidgetCtrl(
      pVCtrl: vCtrl,
      pState: state,
      pTag: pTag,
      label: label,
      hintText: hintText,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      maxLength: maxLength,
    );
  }
  
  // METHODS --------------------------
  String get text => (state as LdEditWidgetState).text;
  set text(String value) => (state as LdEditWidgetState).text = value;
  
  bool validate() => (ctrl as LdEditWidgetCtrl).validate();
  void reset() => (ctrl as LdEditWidgetCtrl).reset();
}

class LdEditWidgetState extends LdWidgetState {
  // MEMBRES --------------------------
  String _text;
  bool _isValid = true;
  String? _errorText;

  // CONSTRUCTORS ---------------------
  LdEditWidgetState({
    required super.pTag,
    required super.pVCtrl,
    required super.pLabel,
    required String pInitialValue,
  }) : _text = pInitialValue;

  // GETTERS/SETTERS ------------------
  String get text => _text;
  set text(String value) {
    _text = value;
    // Utilitzar ctrl en lloc de wCtrl, ja que això s'utilitza abans que wCtrl estigui assignat
    ctrl.notify(pTgts: [ctrl.tag]);
  }
  
  bool get isValid => _isValid;
  set isValid(bool value) {
    _isValid = value;
    ctrl.notify(pTgts: [ctrl.tag]);

  }
  
  String? get errorText => _errorText;
  set errorText(String? value) {
    _errorText = value;
    ctrl.notify(pTgts: [ctrl.tag]);
  }

  @override
  void loadData() {
    // No cal carregar dades específiques
  }
}

class LdEditWidgetCtrl extends LdWidgetCtrl {
  // MEMBRES --------------------------
  final String label;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey<FormFieldState<String>>();

  // CONSTRUCTORS ---------------------
  LdEditWidgetCtrl({
    required super.pVCtrl,
    required super.pState,
    super.pTag,
    required this.label,
    this.hintText,
    required this.obscureText,
    required this.enabled,
    required this.keyboardType,
    required this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.maxLength,
  });

  // PUBLIC METHODS -------------------
  bool validate() {
    if (_fieldKey.currentState != null) {
      // Important: Assegurar-se que el validator s'executa
      if (validator == null) {
        Debug.debug(DebugLevel.debug_2, "[${runtimeType.toString()}]: No s'ha proporcionat validator per aquest camp.");
        return true; // Si no hi ha validator, considerem el camp vàlid
      }
      
      // Obtenir el resultat de la validació directament del validador
      final error = validator!(_controller.text);
      final isValid = error == null;
      
      // Actualitzar ambdós estats: el FormField i el nostre estat intern
      (state as LdEditWidgetState).errorText = error;
      (state as LdEditWidgetState).isValid = isValid;
      
      // Forçar l'actualització de l'estat del FormField
      _fieldKey.currentState!.validate();
      
      // Notificar el canvi
      notify(pTgts: [tag]);
      
      Debug.debug(DebugLevel.debug_2, "[${runtimeType.toString()}]: Resultat de validació: $isValid");
      return isValid;
    } else {
      Debug.debug(DebugLevel.debug_2, "[${runtimeType.toString()}]: L'estat del camp no està inicialitzat!");
      return false; // Si no tenim l'estat del camp, considerem que no és vàlid
    }
  }
  
  void reset() {
    _controller.text = '';
    (state as LdEditWidgetState).text = '';
    (state as LdEditWidgetState).errorText = null;
    (state as LdEditWidgetState).isValid = true;
    
    // Reiniciar l'estat del FormField
    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.reset();
      // Important: Forçar la reconstrucció amb un valor nou i sense errors
      _fieldKey.currentState!.didChange('');
    }
    
    // Notificar el canvi explícitament a tots els targets
    notify();
  }

  @override
  void onInit() {
    super.onInit();
    _controller.text = (state as LdEditWidgetState).text;
    
    // Important: Valida en temps real quan canvia el text
    _controller.addListener(() {
      // Actualitza l'estat
      (state as LdEditWidgetState).text = _controller.text;
      
      // Si l'estat té un error i l'usuari està escrivint, validem de nou
      if ((state as LdEditWidgetState).errorText != null && _controller.text.isNotEmpty) {
        // Netegem l'error explícitament si hi ha text
        (state as LdEditWidgetState).errorText = null;
        
        // Si el camp ja ha estat validat anteriorment, revalidem en temps real
        if (_fieldKey.currentState != null && validator != null) {
          final isValid = validator!(_controller.text) == null;
          (state as LdEditWidgetState).isValid = isValid;
        }
        
        notify(pTgts: [tag]);
      }
    });
    
    Debug.debug(DebugLevel.debug_1, "[onInit.${runtimeType.toString()}]: El controlador del widget d'edició ha estat inicialitzat.");
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          child: TextFormField(
            key: _fieldKey,
            controller: _controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorText: (state as LdEditWidgetState).errorText,
            ),
            obscureText: obscureText,
            enabled: enabled,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLength: maxLength,
            onChanged: (value) {
              // CORRECCIÓ: Validem el nou valor immediatament si hi ha un validador
              if (isNotNull(validator)) {
                final error = validator!(value);
                (state as LdEditWidgetState).errorText = error;
                (state as LdEditWidgetState).isValid = error == null;
                // Actualitzem l'estat del FormField si existeix
                if (_fieldKey.currentState != null) {
                  _fieldKey.currentState!.didChange(value);
                  if (error == null) {
                    // Forcem que es netegi l'error en el FormField
                    _fieldKey.currentState!.validate();
                  }
                }
              }
              
              // Actualitzem l'estat intern
              (state as LdEditWidgetState).text = value;
              
              // Notifiquem el canvi al pare
              if (isNotNull(onChanged)) {
                onChanged!(value);
              }
              
              // IMPORTANT: Notifiquem explícitament a tothom
              notify(pTgts: [tag]);
            },
            onFieldSubmitted: (value) {
              if (isNotNull(onSubmitted)) {
                onSubmitted!(value);
              }
            },
            // Canviem per validar en canviar, per així mantenir sincronitzat l'estat
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
          ),
          onFocusChange: (hasFocus) {
            // Si perd el focus, validem sempre
            if (!hasFocus && validator != null) {
              String? error = validator!(_controller.text);
              (state as LdEditWidgetState).errorText = error;
              (state as LdEditWidgetState).isValid = error == null;
              // Notifiquem explícitament per forçar una actualització visual
              notify(pTgts: [tag]);
            }
          },
        ),
      ],
    );
  }

}