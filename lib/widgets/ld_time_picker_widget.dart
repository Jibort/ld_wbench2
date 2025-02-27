// Widget per a la selecció d'una hora/minut dins un rang obert o tancat.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench2/core/ld_widget.dart';
import 'package:ld_wbench2/core/ld_widget_ctrl.dart';
import 'package:ld_wbench2/core/ld_widget_state.dart';
import 'package:ld_wbench2/tools/null_mang.dart';

class LdTimePickerWidget extends LdWidget {
  // ESTÀTICS -------------------------
  static String className = "LdTimePickerWidget";

  // CONSTRUCTORS ---------------------
  LdTimePickerWidget({
    super.key,
    String? pTag,
    required String label,
    TimeOfDay? initialValue,
    String? hintText,
    bool enabled = true,
    TimeOfDay? minTime,
    TimeOfDay? maxTime,
    ValueChanged<TimeOfDay?>? onChanged,
    FormFieldValidator<TimeOfDay>? validator,
    required super.pVCtrl,
  }) : super(
          pState: LdTimePickerWidgetState(
            pTag: pTag ?? 'time_${DateTime.now().millisecondsSinceEpoch}',
            pLabel: label,
            pVCtrl: pVCtrl,
            pInitialValue: initialValue,
          ),
        ) {
    ctrl = LdTimePickerWidgetCtrl(
      pVCtrl: vCtrl,
      pState: state,
      pTag: pTag,
      label: label,
      hintText: hintText,
      enabled: enabled,
      minTime: minTime,
      maxTime: maxTime,
      onChanged: onChanged,
      validator: validator,
    );
  }
  
  // METHODS --------------------------
  TimeOfDay? get selectedTime => (state as LdTimePickerWidgetState).selectedTime;
  set selectedTime(TimeOfDay? value) => (state as LdTimePickerWidgetState).selectedTime = value;
  
  bool validate() => (ctrl as LdTimePickerWidgetCtrl).validate();
  void reset() => (ctrl as LdTimePickerWidgetCtrl).reset();
}

class LdTimePickerWidgetState extends LdWidgetState {
  // MEMBRES --------------------------
  TimeOfDay? _selectedTime;
  bool _isValid = true;
  String? _errorText;

  // CONSTRUCTORS ---------------------
  LdTimePickerWidgetState({
    required super.pTag,
    required super.pVCtrl,
    required super.pLabel,
    TimeOfDay? pInitialValue,
  }) : _selectedTime = pInitialValue;

  // GETTERS/SETTERS ------------------
  TimeOfDay? get selectedTime => _selectedTime;
  set selectedTime(TimeOfDay? value) {
    _selectedTime = value;
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

class LdTimePickerWidgetCtrl extends LdWidgetCtrl {
  // MEMBRES --------------------------
  final String label;
  final String? hintText;
  final bool enabled;
  final TimeOfDay? minTime;
  final TimeOfDay? maxTime;
  final ValueChanged<TimeOfDay?>? onChanged;
  final FormFieldValidator<TimeOfDay>? validator;
  
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormFieldState<TimeOfDay>> _fieldKey = GlobalKey<FormFieldState<TimeOfDay>>();

  // CONSTRUCTORS ---------------------
  LdTimePickerWidgetCtrl({
    required super.pVCtrl,
    required super.pState,
    super.pTag,
    required this.label,
    this.hintText,
    required this.enabled,
    this.minTime,
    this.maxTime,
    this.onChanged,
    this.validator,
  });
  
  // Private methods ------------------
  void _updateDisplayText() {
    final time = (state as LdTimePickerWidgetState).selectedTime;
    if (time != null) {
      // Format time as HH:MM
      _controller.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      _controller.text = '';
    }
  }
  
  bool _isTimeWithinRange(TimeOfDay time) {
    if (minTime == null && maxTime == null) return true;
    
    final timeInMinutes = time.hour * 60 + time.minute;
    
    bool isAfterMin = true;
    if (minTime != null) {
      final minInMinutes = minTime!.hour * 60 + minTime!.minute;
      isAfterMin = timeInMinutes >= minInMinutes;
    }
    
    bool isBeforeMax = true;
    if (maxTime != null) {
      final maxInMinutes = maxTime!.hour * 60 + maxTime!.minute;
      isBeforeMax = timeInMinutes <= maxInMinutes;
    }
    
    return isAfterMin && isBeforeMax;
  }
  
  // Future method to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    if (!enabled) return;
    
    final currentTime = (state as LdTimePickerWidgetState).selectedTime ?? TimeOfDay.now();
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _isTimeWithinRange(currentTime) ? currentTime : 
                  (minTime != null ? minTime! : 
                  (maxTime != null ? maxTime! : TimeOfDay.now())),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      // Important: Netegem l'error abans de comprovar el rang
      (state as LdTimePickerWidgetState).errorText = null;
      
      if (_isTimeWithinRange(picked)) {
        (state as LdTimePickerWidgetState).selectedTime = picked;
        _updateDisplayText();
        if (isNotNull(onChanged)) {
          onChanged!(picked);
        }
        if (_fieldKey.currentState != null) {
          _fieldKey.currentState!.didChange(picked);
          // Forcem la validació per actualitzar l'estat
          if (isNotNull(validator)) {
            _fieldKey.currentState!.validate();
          }
        }
      } else {
        // Show error message about time range
        String errorMsg = '';
        if (minTime != null && maxTime != null) {
          errorMsg = 'Si us plau, seleccioneu una hora entre ${minTime!.format(context)} i ${maxTime!.format(context)}';
        } else if (minTime != null) {
          errorMsg = 'Si us plau, seleccioneu una hora posterior a ${minTime!.format(context)}';
        } else if (maxTime != null) {
          errorMsg = 'Si us plau, seleccioneu una hora anterior a ${maxTime!.format(context)}';
        }
        (state as LdTimePickerWidgetState).errorText = errorMsg;
        // Notificar l'error perquè es mostri immediatament
        super.notify(pTgts: [tag]);
      }
    }
  }
  // PUBLIC METHODS -------------------
  bool validate() {
    if (_fieldKey.currentState != null && isNotNull(validator)) {
      final isValid = _fieldKey.currentState!.validate();
      (state as LdTimePickerWidgetState).isValid = isValid;
      return isValid;
    }
    return true;
  }
  
  void reset() {
    // Primer, netegem l'estat intern
    (state as LdTimePickerWidgetState).selectedTime = null;
    (state as LdTimePickerWidgetState).errorText = null;
    (state as LdTimePickerWidgetState).isValid = true;
    
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
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  @override
  Widget buildWidget(BuildContext pCtx) {
    return FormField<TimeOfDay>(
      key: _fieldKey,
      initialValue: (state as LdTimePickerWidgetState).selectedTime,
      validator: validator,
      builder: (FormFieldState<TimeOfDay> field) {
        // Important: utilitzem només un lloc per mostrar l'error
        final errorText = (state as LdTimePickerWidgetState).errorText ?? 
                        (field.hasError ? field.errorText : null);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: label,
                hintText: hintText ?? 'Seleccionar hora',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // Mostrem l'error només AQUÍ i no sota
                errorText: errorText,
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              enabled: enabled,
              onTap: () => _selectTime(pCtx),
            ),
            // Eliminem la secció que mostrava l'error addicional sota el camp
          ],
        );
      },
    );
  }
}