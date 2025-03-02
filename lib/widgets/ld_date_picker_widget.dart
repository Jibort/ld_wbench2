// Widget per a la selecció d'una data dins un rang obert o tancat.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ld_wbench2/core/ld_view_state.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdDatePickerWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdDatePickerWidget";

  // 🛠️ CONSTRUCTORS ---------------------
  LdDatePickerWidget({
    super.key,
    required String pTag,
    required String label,
    DateTime? initialValue,
    String? hintText,
    bool enabled = true,
    DateTime? firstDate,
    DateTime? lastDate,
    String? dateFormat = 'dd/MM/yyyy',
    ValueChanged<DateTime?>? onChanged,
    FormFieldValidator<DateTime>? validator,
    required super.pViewCtrl,
    required LdViewState pViewState,
  }) : super(
          pState: LdDatePickerWidgetState(
            pLabel: label,
            pViewCtrl: pViewCtrl,
            pViewState: pViewState,
            pInitialValue: initialValue,
          ),
        ) {
    ctrl = LdDatePickerWidgetCtrl(
      pViewCtrl: viewCtrl,
      pState: state,
      pTag: pTag,
      label: label,
      hintText: hintText,
      enabled: enabled,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      dateFormat: dateFormat,
      onChanged: onChanged,
      validator: validator,
    );
  }
  
  // METHODS --------------------------
  DateTime? get selectedDate => (state as LdDatePickerWidgetState).selectedDate;
  set selectedDate(DateTime? value) => (state as LdDatePickerWidgetState).selectedDate = value;
  
  bool validate() => (ctrl as LdDatePickerWidgetCtrl).validate();
  void reset() => (ctrl as LdDatePickerWidgetCtrl).reset();
}

class LdDatePickerWidgetState extends LdWidgetState {
  // 🧩 MEMBRES --------------------------
  DateTime? _selectedDate;
  bool _isValid = true;
  String? _errorText;

  // 🛠️ CONSTRUCTORS ---------------------
  LdDatePickerWidgetState({
    required super.pViewCtrl,
    required super.pViewState,
    required super.pLabel,
    DateTime? pInitialValue,
  }) : _selectedDate = pInitialValue;

  // GETTERS/SETTERS ------------------
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
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

class LdDatePickerWidgetCtrl extends LdWidgetCtrl {
  // 🧩 MEMBRES --------------------------
  final String label;
  final String? hintText;
  final bool enabled;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? dateFormat;
  final ValueChanged<DateTime?>? onChanged;
  final FormFieldValidator<DateTime>? validator;
  
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormFieldState<DateTime>> _fieldKey = GlobalKey<FormFieldState<DateTime>>();

  // 🛠️ CONSTRUCTORS ---------------------
  LdDatePickerWidgetCtrl({
    required super.pViewCtrl,
    required super.pState,
    required super.pTag,
    required this.label,
    this.hintText,
    required this.enabled,
    required this.firstDate,
    required this.lastDate,
    this.dateFormat,
    this.onChanged,
    this.validator,
  });
  
  // Private methods ------------------
  void _updateDisplayText() {
    final date = (state as LdDatePickerWidgetState).selectedDate;
    if (date != null) {
      final formatter = DateFormat(dateFormat ?? 'dd/MM/yyyy');
      _controller.text = formatter.format(date);
    } else {
      _controller.text = '';
    }
  }
  
  // Future method to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    if (!enabled) return;
    
    final currentDate = (state as LdDatePickerWidgetState).selectedDate ?? DateTime.now();
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate.isAfter(firstDate) && currentDate.isBefore(lastDate) 
          ? currentDate 
          : DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (picked != null && picked != (state as LdDatePickerWidgetState).selectedDate) {
      (state as LdDatePickerWidgetState).selectedDate = picked;
      _updateDisplayText();
      if (isNotNull(onChanged)) {
        onChanged!(picked);
      }
      if (_fieldKey.currentState != null) {
        _fieldKey.currentState!.didChange(picked);
      }
    }
  }

  // PUBLIC METHODS -------------------
  bool validate() {
    if (_fieldKey.currentState != null && isNotNull(validator)) {
      final isValid = _fieldKey.currentState!.validate();
      (state as LdDatePickerWidgetState).isValid = isValid;
      return isValid;
    }
    return true;
  }
  
  void reset() {
    // Primer, netegem l'estat intern
    (state as LdDatePickerWidgetState).selectedDate = null;  // o TimePickerWidgetState
    (state as LdDatePickerWidgetState).errorText = null;
    (state as LdDatePickerWidgetState).isValid = true;
    
    // Actualitzem el text del controlador
    _controller.text = '';
    
    // Reiniciem l'estat del camp del formulari
    if (_fieldKey.currentState != null) {
      _fieldKey.currentState!.reset();
      // Important: Forçar la reconstrucció amb un valor nul
      _fieldKey.currentState!.didChange(null);
    }
    
    // Notificar explícitament tots els targets
    notify();
  }

  @override
  void onInit() {
    super.onInit();
    _updateDisplayText();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    return FormField<DateTime>(
      key: _fieldKey,
      initialValue: (state as LdDatePickerWidgetState).selectedDate,
      validator: validator,
      builder: (FormFieldState<DateTime> field) {
        // Important: utilitzem només un lloc per mostrar l'error
        final errorText = (state as LdDatePickerWidgetState).errorText ?? 
                        (field.hasError ? field.errorText : null);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: label,
                hintText: hintText ?? 'Seleccionar data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // Mostrem l'error només AQUÍ i no sota
                errorText: errorText,
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              enabled: enabled,
              onTap: () => _selectDate(pCtx),
            ),
            // Eliminem la secció que mostrava l'error addicional sota el camp
          ],
        );
      },
    );
  }
}