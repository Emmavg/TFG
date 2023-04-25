import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendario extends StatelessWidget {
  const Calendario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Verde menta
      //color: const Color.fromARGB(255, 203, 255, 202),
      color: const Color.fromARGB(255, 223, 255, 222),

      // ---------------------------------------- CALENDARIO -----------------------------------------------
      child: SfDateRangePicker(
        toggleDaySelection: true,
        monthViewSettings:
          const DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            showWeekNumber: true,
            dayFormat: 'EEE',
          ),

        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: Color.fromARGB(131, 210, 217, 255), 
        ),
        yearCellStyle: const DateRangePickerYearCellStyle(
          todayTextStyle: TextStyle(color:Color.fromARGB(252, 177, 188, 252) )
        ),
        // Seleccion por rango
        startRangeSelectionColor: const Color.fromARGB(252, 177, 188, 252), 
        endRangeSelectionColor: const Color.fromARGB(252, 177, 188, 252),  
        rangeSelectionColor:  const Color.fromARGB(131, 210, 217, 255), 
        selectionColor: const Color.fromARGB(252, 177, 188, 252), 
        selectionMode: DateRangePickerSelectionMode.range,
        todayHighlightColor: const Color.fromARGB(251, 139, 156, 252),  
        headerHeight: 60,
        showTodayButton: true,
        navigationMode: DateRangePickerNavigationMode.snap,

        // Ponemos un rango por defecto
        initialSelectedRange: PickerDateRange(
          // Desde hace 3 días hasta después de 7 días
          DateTime.now().subtract(const Duration(days: 3)),
          DateTime.now().add(const Duration(days: 7)),
        ),
        
        // Mostramos los botones de acción
        showActionButtons: true,
        confirmText: "Plantar",
        
        cancelText: "Cancelar",

        // Cuando aceptas el rango seleccionado
        onSubmit: (DateRange) {
          print(DateRange);
        },

        // Cuando cambiamos la fecha seleccionada
        onSelectionChanged: (DateRange) {
          print(DateRange.value);
        },
      ),
    );
  }
}