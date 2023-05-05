
// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantag/pags/index.dart';
import 'package:plantag/widgets/dialogo_tareas.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


import '../database_helper.dart';
import '../models/tarea.dart';
import '../pags/index.dart';


class Calendario extends StatefulWidget {

  // Creamos variables para los parámetros que queremos utilizar en la clase
  bool? botones;
  PickerDateRange? fechaSel;

  // En el momento en el que hacemos esto, cada parametro que le pasamos se le asigna automaticax a la variablke de arriba referenciada con el this
  // Si no le ponemos el this no le hace referencia
  // Para utilizarlos abajo en la app principal debemos usar: widget.botones! por ej la ! para indicar que se lo vas a pasar si o si
  Calendario({
    super.key,
    this.botones,
    this.fechaSel,
  });

 
  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {

  // Le pasamos el rango seleccionado a la ventana principal 
  // PickerDateRange? fechaSeleccionada;
  bool botones = true;


  // Creamos la funcion para establecer la fecha y se la pasamos como parametro al content del dialogo
  // fechaSeleccionadaDialogo(PickerDateRange fechaSelec){
  //     fechaSeleccionada = fechaSelec;
  // }

  @override
  Widget build(BuildContext context) {
    Future<List<Tarea>> lista = SQLHelper.tareas();
    lista.then((miLista) {
    // paso los elementos de tareas a appointments que se pueden meter en el calendario
    List<Appointment> appointments = [];

    for (Tarea tarea in miLista) {
      print("Tarea "+tarea.titulo+" FechaIni "+tarea.fechaInicio.toString());
      Appointment appointment = Appointment(
        startTime: tarea.fechaInicio,
        endTime: tarea.fechaFin,
        subject: tarea.titulo,
        notes: tarea.descripcion,
        color: Colors.blue,
      );

    appointments.add(appointment);
}
    
    // aqui hay que cargar el calendario :)
    SfCalendar(
      view: CalendarView.week,
      dataSource: _DataSource(appointments),
    );
});

    
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
            //showWeekNumber: true,
            dayFormat: 'EEE',
          ),

        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: Color.fromARGB(131, 210, 217, 255), 
        ),
        yearCellStyle: const DateRangePickerYearCellStyle(
          todayTextStyle: TextStyle(color:Color.fromARGB(252, 177, 188, 252),
          ),
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

        // Ponemos un rango por defecto en este caso es el parametro que se pasa si no es null y sino el que establecemos debajo
        
        initialSelectedRange: widget.fechaSel != null  
        ? PickerDateRange(widget.fechaSel!.startDate, widget.fechaSel!.endDate)
        : PickerDateRange(
          // Desde hace 3 días hasta después de 7 días
          DateTime.now().add(const Duration(days: 0)),
          DateTime.now().add(const Duration(days: 0)),

          // DateTime.now().subtract(const Duration(days: 3)),
          // DateTime.now().add(const Duration(days: 7)),
        ),

       
        // Mostramos los botones de acción
        showActionButtons: widget.botones!,
        
        confirmText: "Plantar",
        
        cancelText: "Cancelar",

        // Cuando aceptas el rango seleccionado
        onSubmit: (DateRange) {
          print(DateRange);
                // Cuando pulsamos el botón muestra el dialogo creando una función para ello
          
          widget.fechaSel = DateRange as PickerDateRange?;
          showCupertinoDialog(
            // El barrier es para especificar que cuando toque otra zona de la pantalla se cierra
            barrierDismissible: false,
            context: context,
            
            builder: (context) {
              return DialogoTareas(fechaSeleccionada: widget.fechaSel,);
          });
        },

        onCancel: () {
          PickerDateRange(
          // Desde hace 3 días hasta después de 7 días
          DateTime.now().add(const Duration(days: 0)),
          DateTime.now().add(const Duration(days: 0)),);

          // DateTime.now().subtract(const Duration(days: 3)),
          // DateTime.now().add(const Duration(days: 7)),
        },

        // Cuando cambiamos la fecha seleccionada
        onSelectionChanged: (DateRange) {
          print(DateRange.value);
          print("Botones: ");
          print(widget.botones);
          setFecha(DateRange.value);
          print("Calendario");
          print(getFecha());
          
        },
      ),
    );
  }
}
// Declaramnos una variable global a nivel de fichero no de clase para que se pyeda acceder desde las otras clases con las funciones
// De esta forma cada vez que el usuario cambie el rango de la fecha y le de click al botón de lista de tareas se filtrará por aquellas que estén dentro del rango

PickerDateRange? _fechaSelIndex;

void setFecha(PickerDateRange fechaSele) {
    _fechaSelIndex = fechaSele;
}

PickerDateRange? getFecha() {
    return _fechaSelIndex;
}
class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}