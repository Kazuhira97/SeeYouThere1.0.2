import 'package:flutter/material.dart';

class WelcomeWid extends StatelessWidget {
  //Variable de tipo String que da la bienvenida
  final welcome = "Hace 9 años nos hicimos una promesa mutua, donde establecimos " +
      "que: si un día nuestros caminos se separaban, nos reuniríamos en una " +
      "fecha específica en el futuro y juntos pensaríamos en cómo reunir nuestros " +
      "caminos… Como regalo hice esta pequeña App para ti, donde ambos podamos " +
      "recordar de vez en cuando la fecha… Así que Querida, nos veremos en:";

  //Construye la UI del mensaje de bienvenida
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          welcome,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
            height: 1.1,
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
