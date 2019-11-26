import 'dart:convert';

import 'package:dad_app/associado/associado_page.dart';
import 'package:dad_app/associado/cadastro_associado.dart';
import 'package:dad_app/gerencial/cadastro_gerencial.dart';
import 'package:dad_app/gerencial/gerencial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dad_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './about_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ONG ASPEC Solidária",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
          accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;
  String _userName = '';
  String _userType = '';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _userName = sharedPreferences.getString('name') ?? '';
      _userType = sharedPreferences.getString('tipo_usuario') ?? '';
    });

    sharedPreferences.clear();
    if(_userName == '') {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("ONG", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Text("Página Principal")),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(_userName),
                accountEmail: new Text(_userType.toUpperCase()),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://uybor.uz/borless/avtobor/img/user-images/user_no_photo_300x300.png'),
                ),),
            new ListTile(
              title: new Text(_userType == 'gerencial'? 'Ver Associados' : 'Área do Associado'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext contect) => new AssociadoPage())
                );
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            new ListTile(
              title: new Text('Cadastro de Associado'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext contect) => new AssociadoCadPage())
                );
              },
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            Visibility(
              visible: _userType == 'gerencial',
              child: new ListTile(
              title: new Text('Área Gerencial'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext contect) => new GerencialPage())
                );
              },
            ),
            ),
            new Divider(
              color: Colors.black,
              height: 5.0,
            ),
            Visibility(
             visible: _userType == 'gerencial',
             child:  new ListTile(
               title: new Text('Cadastro de Gerencial'),
               onTap: () {
                 Navigator.of(context).pop();
                 Navigator.push(context, new MaterialPageRoute(
                     builder: (BuildContext contect) => new GerencialCadPage())
                 );
               },
             ),
            ),
            new ListTile(
              title: new Text('Sobre'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext contect) => new AboutPage())
                );
              },
            )
          ],
        )
      ),
    );
  }
}