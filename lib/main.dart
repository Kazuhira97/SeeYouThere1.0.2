import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_appv1_0_1/WelcomeWid.dart';
import 'package:timer_appv1_0_1/TimerWid.dart';
import 'package:timer_appv1_0_1/LastMsgWid.dart';

void main() {
  runApp(TimerApp()); //Se corre la aplicacion TimerApp
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "See You There!",
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.black),
          title: Text(
            "See you soon on the sunny road",
            style: TextStyle(
                fontFamily: 'Satisfy',
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          backgroundColor: Colors.black,
        ),
        body: TimerPage(),
      ),
    );
  }
}

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //Aquí se muestra el mensaje de bienvenida
        Expanded(
          child: WelcomeWid(),
        ),
        //Aquí se muestra el contador regresivo
        Expanded(
          child: TimerWid(),
        ),
        //Aqui se muestra un mensaje extra aleatorio
        Expanded(
          child: LastMsgWid(),
        ),
      ],
    );
  }
}
