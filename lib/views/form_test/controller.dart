// Controlador de la vista de prova de formulari.
// CreatedAt: 2025/02/27 dj. JIQ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ld_wbench2/core/ld_view_ctrl.dart';
import 'package:ld_wbench2/tools/debug.dart';
import 'package:ld_wbench2/views/form_test/state.dart';
import 'package:ld_wbench2/views/widget_key.dart';
import 'package:ld_wbench2/widgets/ld_container.dart';
import 'package:ld_wbench2/widgets/ld_check_widget.dart';
import 'package:ld_wbench2/widgets/ld_date_picker_widget.dart';
import 'package:ld_wbench2/widgets/ld_edit_widget.dart';
import 'package:ld_wbench2/widgets/ld_floating_action_button.dart';
import 'package:ld_wbench2/widgets/ld_scaffold_widget.dart';
import 'package:ld_wbench2/widgets/ld_time_picker_widget.dart';

class FormTestViewCtrl 
extends LdViewCtrl {
  // MEMBRES ADDICIONALS -------------
  final formKey = GlobalKey<FormState>();
  
  // WIDGETS =========================
  LdEditWidget? _nameField;
  LdEditWidget? _emailField;
  LdCheckWidget? _termsCheck;
  LdDatePickerWidget? _birthDatePicker;
  LdTimePickerWidget? _appointmentPicker;

  // GETTERS DE WIDGETS ===============
  LdEditWidget get nameField {
    _nameField ??= LdEditWidget(
      pVCtrl: this,
      label: 'Nom complet',
      hintText: 'Introduïu el vostre nom',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Si us plau, introduïu el vostre nom';
        } else if (value.length < 3) {
          return 'El nom ha de tenir almenys 3 caràcters';
        }
        return null;
      },
    );
    return _nameField!;
  }
  
  LdEditWidget get emailField {
    _emailField ??= LdEditWidget(
      pVCtrl: this,
      label: 'Correu electrònic',
      hintText: 'exemple@correu.com',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Si us plau, introduïu el vostre correu';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Si us plau, introduïu un correu vàlid';
        }
        return null;
      },
    );
    return _emailField!;
  }
  
  LdCheckWidget get termsCheck {
    _termsCheck ??= LdCheckWidget(
      pVCtrl: this,
      label: 'Accepto els termes i condicions',
      validator: (value) {
        if (value != true) {
          return 'Cal acceptar els termes per continuar';
        }
        return null;
      },
    );
    return _termsCheck!;
  }
  
  LdDatePickerWidget get birthDatePicker {
    _birthDatePicker ??= LdDatePickerWidget(
      pVCtrl: this,
      label: 'Data de naixement',
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      validator: (value) {
        if (value == null) {
          return 'Si us plau, seleccioneu la data de naixement';
        }
        return null;
      },
    );
    return _birthDatePicker!;
  }
  
  LdTimePickerWidget get appointmentPicker {
    _appointmentPicker ??= LdTimePickerWidget(
      pVCtrl: this,
      label: 'Hora de cita',
      minTime: TimeOfDay(hour: 9, minute: 0),
      maxTime: TimeOfDay(hour: 18, minute: 0),
      validator: (value) {
        if (value == null) {
          return 'Si us plau, seleccioneu una hora per la cita';
        }
        return null;
      },
    );
    return _appointmentPicker!;
  }
  
  // 🛠️ CONSTRUCTORS -------------------
  FormTestViewCtrl({ required String pTag, required super.pState }): super(pTag: pTag) {
    addWidgets([
      WidgetKey.scaffold.idx,
      WidgetKey.appBar.idx,
      WidgetKey.appBarProgress.idx,
      WidgetKey.pageBody.idx,
      WidgetKey.floatingActionButton.idx,
    ]);
  }

  // GETTERS/SETTERS ------------------
  FormTestViewState get testState => state as FormTestViewState;

// MÈTODES ADDICIONALS --------------
  void validateForm() {
    bool isValid = true;

    // Forçar la validació de cada camp i capturar el resultat
    bool nameValid = nameField.validate();
    bool emailValid = emailField.validate();
    bool termsValid = termsCheck.validate();
    bool birthDateValid = birthDatePicker.validate();
    bool appointmentValid = appointmentPicker.validate();

    // Combinar els resultats
    isValid = nameValid && emailValid && termsValid && birthDateValid && appointmentValid;

    // Debug - comprovar el resultat de cada validació
    Debug.debug(DebugLevel.debug_1, "Validació del formulari: " +
      "Nom: $nameValid, Email: $emailValid, " +
      "Termes: $termsValid, Data: $birthDateValid, " + 
      "Hora: $appointmentValid, Global: $isValid");

    // Actualitzar estat global del formulari
    testState.setFormValidity(isValid);

    if (isValid) {
      // Recollir dades del formulari
      final formData = {
        'name': nameField.text,
        'email': emailField.text,
        'terms_accepted': termsCheck.value,
        'birth_date': birthDatePicker.selectedDate != null ? 
                      '${birthDatePicker.selectedDate!.day}/${birthDatePicker.selectedDate!.month}/${birthDatePicker.selectedDate!.year}' : 'No seleccionat',
        'appointment_time': appointmentPicker.selectedTime != null ? 
                          '${appointmentPicker.selectedTime!.hour}:${appointmentPicker.selectedTime!.minute}' : 'No seleccionat'
      };
      
      // Actualitzar l'estat amb les dades del formulari
      testState.updateFormData(formData.entries.map((e) => '${e.key}: ${e.value}').join('\n'));
      
      // Mostrar resultat
      Get.snackbar(
        'Formulari vàlid',
        'Totes les dades són correctes',
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade800,
        snackPosition: SnackPosition.bottom,
        duration: Duration(seconds: 3),
      );
    } else {
      // Netejar les dades del formulari si no és vàlid
      testState.updateFormData('');
      
      Get.snackbar(
        'Formulari invàlid',
        'Si us plau, corregiu els errors del formulari',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.bottom,
        duration: Duration(seconds: 3),
      );
    }

    // Forçar actualització de la UI
    update([WidgetKey.pageBody.idx]);
  }

 void resetForm() {
    _nameField = null;
    _emailField = null;
    _termsCheck = null;
    _birthDatePicker = null;
    _appointmentPicker = null;
    
    // Actualitzem l'estat global
    testState.updateFormData('');
    testState.setFormValidity(false);
    
    // Important: Forçar la reconstrucció de la vista
    update([WidgetKey.pageBody.idx]);
    
    Get.snackbar(
      'Formulari reiniciat',
      'Tots els camps han estat buidats',
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade800,
      snackPosition: SnackPosition.bottom,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget buildView(BuildContext pCtx) {
    // Ja no necessitem inicialitzar els widgets aquí,
    // perquè es faran a través dels getters
    
    final bodyWidget = _buildBody(pCtx);
    
    return LdScaffoldWidget(
      pViewState: state as FormTestViewState,
      pTitle: testState.title,
      pSubtitle: testState.subtitle,
      btnFloatAction: LdFloatingActionButton(
        pVCtrl: this,
        onPressed: validateForm,
        icon: Icon(Icons.check),
        tooltip: 'Validar formulari',
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
      ),
      wgtBody: LdContainer(
        pVCtrl: this,
        child: bodyWidget,
      ),
    );
  }

  Widget _buildBody(BuildContext pCtx) {
    return GetBuilder<FormTestViewCtrl>(
      id: WidgetKey.pageBody.idx,
      tag: WidgetKey.pageBody.idx,
      init: this,
      builder: (FormTestViewCtrl vCtrl) {
        if (state.isNew || state.isLoading || state.isLoadingAgain) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildFormContent(pCtx);
        }
      },
    );
  }

  Widget _buildFormContent(BuildContext pCtx) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Card(
              elevation: 4.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Formulari de prova',
                      style: Get.textTheme.headlineSmall,
                    ),
                    Divider(),
                    Text(
                      'Aquest formulari mostra els diferents widgets d\'entrada que hem creat',
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            
            // Secció d'informació personal
            Card(
              elevation: 4.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informació personal',
                      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    nameField.build(pCtx),
                    SizedBox(height: 16.0),
                    emailField.build(pCtx),
                    SizedBox(height: 16.0),
                    birthDatePicker.build(pCtx),
                  ],
                ),
              ),
            ),
            
            // Secció de cita
            Card(
              elevation: 4.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalls de la cita',
                      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    appointmentPicker.build(pCtx),
                    SizedBox(height: 16.0),
                    termsCheck.build(pCtx),
                  ],
                ),
              ),
            ),
            
            // Botons del formulari
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: resetForm,
                  icon: Icon(Icons.refresh),
                  label: Text('Reiniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton.icon(
                  onPressed: validateForm,
                  icon: Icon(Icons.check),
                  label: Text('Validar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.colorScheme.primary,
                    foregroundColor: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            
            // Mostrar dades enviades
            if (testState.formData.isNotEmpty) 
              Card(
                elevation: 4.0,
                margin: EdgeInsets.only(top: 16.0),
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dades enviades:',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        testState.formData,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.green.shade800
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}