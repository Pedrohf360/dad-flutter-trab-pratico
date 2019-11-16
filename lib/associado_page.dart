import 'package:flutter/material.dart';

class AssociadoPage extends StatefulWidget {
  @override
  _AssociadoPageState createState() => new _AssociadoPageState();
}

class _AssociadoPageState extends State<AssociadoPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About Page'),
      ),
      body: Center(child: Text('Esse APP foi desenvolvido para a ONG x com o objetivo de ajudar no controle de...'),),
    );
  }
}