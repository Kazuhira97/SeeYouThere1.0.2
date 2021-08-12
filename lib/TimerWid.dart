import 'dart:async';
import 'package:flutter/material.dart';

class TimerWid extends StatefulWidget {
  @override
  _TimerWidState createState() => _TimerWidState();
}

class _TimerWidState extends State<TimerWid> {
  Duration? duration;
  Timer? timer;
  int yearFinal = 0;
  int monthFinal = 0;
  bool isDone = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    buildCounter();
    super.initState();
    startCountDown();
  }

  int calculeDaysLeft(int month) {
    DateTime? iniDate;
    DateTime? endDate;
    int daysLeft = 0;

    if (month != 4) {
      //Arregla el bug del dia faltante en abril
      iniDate = DateTime(2021, month, 1);
      endDate = DateTime(2021, month + 1, 1);
      daysLeft = endDate.difference(iniDate).inDays;
    } else {
      daysLeft = 30;
    }

    return daysLeft;
  }

  int discountMounth() {
    int daysDiff = 0;
    int actualMonth = 0;

    var monthIn = DateTime.september - monthFinal;
    actualMonth = (monthIn < 0) ? 12 + monthIn : monthIn;
    daysDiff = calculeDaysLeft(actualMonth);
    monthFinal -= 1;

    return daysDiff - 1;
  }

  void countDown() {
    final subsSeconds = 1;
    var newDays = 0;
    setState(() {
      //Hacer que tambien se muevan los meses y años
      //Reiniciar el Duration cuando se terminen los dias
      final seconds = duration!.inSeconds - subsSeconds;
      if (seconds < 0) {
        if (yearFinal == 0 && monthFinal == 0) {
          //Termino el tiempo
          //Its time honey, meet me on the sunny road
          isDone = true;
          timer?.cancel();
        } else if (monthFinal <= 0) {
          //Termino el ciclo de un año
          yearFinal -= 1;
          monthFinal = 11;
          duration = Duration(days: 29, hours: 23, minutes: 59, seconds: 59);
        } else {
          //Se ejecuta este código si ha terminado un mes
          //Obtenemos los dias restantes del siguiente mes
          newDays = discountMounth();
          duration =
              Duration(days: newDays, hours: 23, minutes: 59, seconds: 59);
        }
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  //Esta función inicia la cuenta regresiva con la clase Timer
  void startCountDown() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => countDown());
  }

  //Esta función construye la cuenta regresiva
  void buildCounter() {
    //Fecha y hora actuales
    final ahora = DateTime.now();

    //Fecha y hora de la fecha (valga la redundancia)
    final expectedDate = DateTime(
      2022, //Año
      DateTime.september, //Mes
      2, //Dia
      14, //Hora
      22, //Minuto
    );
    //Variables enteras que contendran la información de diferencia de fecha
    yearFinal = expectedDate.year - ahora.year;
    monthFinal = expectedDate.month - ahora.month;
    int dayFinal = expectedDate.day - ahora.day;

    //Variables enteras que contendran las informacion de diferencia de hora
    int hoursFinal = expectedDate.hour - ahora.hour;
    int minsFinal = expectedDate.minute - ahora.minute;
    int segFinal = expectedDate.second - ahora.second;

    //Variable lógica que se ejecuta si ya se modificó el mes en curso
    bool monthIncremented = false;

    //Las tres condicionales obtienen el tiempo restante en Horas/Min/Seg
    if (segFinal < 0) {
      segFinal += 60;
      minsFinal--;
    }
    if (minsFinal < 0) {
      hoursFinal--;
      minsFinal += 60;
    }
    if (hoursFinal < 0) {
      hoursFinal += 24;
      dayFinal--;
    }

    //Las siguientes condicionales obtienen el tiempo restante en Años/Meses/Dias
    if ((monthFinal < 0) || (monthFinal == 0 && dayFinal < 0)) {
      yearFinal--;
      monthFinal += (dayFinal < 0) ? 11 : 12;
      monthIncremented = true;
    }

    if (dayFinal < 0) {
      dayFinal += calculeDaysLeft(ahora.month);
      if (monthFinal > 0 && !monthIncremented) {
        monthFinal -= 1;
      }
    }

    //Si a pesar del proceso los años son negativos, quiere decir que el tiempo
    //terminó
    if (yearFinal < 0) {
      yearFinal = 0;
      monthFinal = 0;
      duration = Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
      isDone = true;
    } else {
      //Asignamos el tiempo restante a un Duration
      duration = Duration(
        days: dayFinal,
        hours: hoursFinal,
        minutes: minsFinal,
        seconds: segFinal,
      );
    }
  }

  //Construye el UI del contador regresivo
  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final yearsLbl = twoDigits(yearFinal);
    final monthsLbl = twoDigits(monthFinal);
    final daysLbl = twoDigits(duration!.inDays);
    final hoursLbl = twoDigits(duration!.inHours.remainder(24));
    final minutesLbl = twoDigits(duration!.inMinutes.remainder(60));
    final secondsLbl = twoDigits(duration!.inSeconds.remainder(60));

    var timerParts = [
      TimerElement(yearsLbl, false),
      TimerElement(monthsLbl, false),
      TimerElement(daysLbl, false),
      TimerElement(hoursLbl, false),
      TimerElement(minutesLbl, false),
      TimerElement(secondsLbl, true),
    ];
    var timerLabels = [
      TimerLabel("Años"),
      TimerLabel("Meses"),
      TimerLabel("Días"),
      TimerLabel("Horas"),
      TimerLabel("Min"),
      TimerLabel("Seg"),
    ];

    return Column(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: (isDone) ? Alignment.bottomCenter : Alignment.center,
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(
                  children: [
                    timerParts[0],
                    timerParts[1],
                    timerParts[2],
                    timerParts[3],
                    timerParts[4],
                    timerParts[5],
                  ],
                ),
                TableRow(
                  children: [
                    timerLabels[0],
                    timerLabels[1],
                    timerLabels[2],
                    timerLabels[3],
                    timerLabels[4],
                    timerLabels[5],
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isDone) ...[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "El tiempo llegó... Esta vez como uno solo decidiremos que camino tomar...",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satisfy',
                    height: 1.1,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}

//Se trata de cada uno de los labels para conformar 00:00:00:00:00:00
// ignore: must_be_immutable
class TimerElement extends StatelessWidget {
  String timerEl;
  bool last;

  TimerElement(this.timerEl, this.last);

  @override
  Widget build(BuildContext context) {
    timerEl = last == true ? timerEl : timerEl + ":";
    return Text(
      timerEl,
      style: TextStyle(
        fontSize: 37.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

//Se trata de cada uno de los Labels indicadores de Años/Meses/etc
// ignore: must_be_immutable
class TimerLabel extends StatelessWidget {
  String label;

  TimerLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'BebasNeue',
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
