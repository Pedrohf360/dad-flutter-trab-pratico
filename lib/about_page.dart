import 'package:flutter/material.dart';

    class AboutPage extends StatefulWidget {
      @override
      _AboutPageState createState() => new _AboutPageState();
    }

    class _AboutPageState extends State<AboutPage> {

      @override
      Widget build(BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('About Page'),
          ),
          body: Center(child: Text('Esse APP foi desenvolvido para a ONG ASPEC Solidária com o objetivo de ajudar no controle de Associados e Gerentes.'),),
        );
      }
    }