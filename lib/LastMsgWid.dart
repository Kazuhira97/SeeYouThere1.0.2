import 'package:flutter/material.dart';
import 'dart:math';

class LastMsgWid extends StatelessWidget {
  //Lista con todos los mensajes posibles a mostrar
  final messages = [
    "¿Recuerdas por qué pusimos como fecha el 02 de Septiembre?" +
        " Porque era nuestro aniversario… ",
    "Pasaron tantos años donde la distancia y la ausencia se hicieron enormes… " +
        "Pero eso no bastó para quebrar los lazos.",
    "Después de todo lo que pasó, me alegra que estés aquí…",
    "“Y me pongo a pensar ¿Cómo es el gran lugar? ¿Tu ahí vas a estar?”",
    "Creciste tanto en todos los aspectos posibles… No sabes lo feliz que me " +
        "hace saberlo, pese a no haber sido parte del proceso.",
    "¿Recuerdas que queríamos mandar a hacer pulseras con la fecha para no " +
        "olvidarla? Bueno, esto se acerca mucho jajajaja.",
    "Allí estaré, Querida…",
    "¿Algún día terminaremos de ver The Walking Dead o jugaremos Alice: " +
        "Asylum? Ok, esta frase estuvo de relleno jaja. "
  ];

  //Construye la UI del mensaje de despedida
  @override
  Widget build(BuildContext context) {
    var randNum = new Random();
    var selectedMsg = messages[randNum.nextInt(8)];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          selectedMsg,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
            color: Colors.white,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
