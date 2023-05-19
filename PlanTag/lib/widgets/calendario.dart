import 'package:flutter/material.dart';
import 'package:plantag/main.dart';
import 'package:plantag/widgets/dialogo_tareas.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../database_helper.dart';
import '../models/tarea.dart';

// ignore: must_be_immutable
class Calendario extends StatefulWidget {
  bool? botones;
  DateTime? fechaSel;

  Calendario({
    super.key,
    this.botones,
    this.fechaSel,
  });

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  bool botones = true;

  @override
  Widget build(BuildContext context) {
    Future<List<Tarea>> lista = SQLHelper.tareas();

    return FutureBuilder<List<Tarea>>(
      future: lista,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<Appointment> appointments = [];
          for (Tarea tarea in snapshot.data!) {
            Appointment appointment = Appointment(
              startTime: tarea.fechaInicio,
              endTime: tarea.fechaFin,
              subject: tarea.titulo,
              notes: tarea.descripcion,
              color: Colors.blue,
            );
            appointments.add(appointment);
          }
          return SfCalendar(
            view: CalendarView.month,
            dataSource: _DataSource(appointments),
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.calendarCell) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => DialogoTareas(
                    fechaSeleccionada: details.date!,
                  ),
                );
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                 builder: (context) => const MyApp(),
              ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

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