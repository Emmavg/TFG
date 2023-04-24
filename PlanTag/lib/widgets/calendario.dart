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
      color: const Color.fromARGB(255, 203, 255, 202),

      // ---------------------------------------- CALENDARIO -----------------------------------------------
      child: SfDateRangePicker(
        monthViewSettings:
          const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
          // Seleccion por rango
          startRangeSelectionColor: Colors.purple,
          endRangeSelectionColor: Colors.purple,
          rangeSelectionColor: Colors.yellow,
          selectionColor: Colors.black,
          selectionMode: DateRangePickerSelectionMode.range,

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