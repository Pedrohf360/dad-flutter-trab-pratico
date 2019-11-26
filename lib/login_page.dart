import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dad_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var userData;
  bool _isLoading = false;
  String _currentUserType = "Associado";
  var _userTypes = ['Associado', 'Gerencial'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            Center(child: _hintDown()),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  signIn(String login, pass, userType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'usuario': login,
      'senha': pass,
      'tipoUsuario': userType
    };
    var jsonResponse = null;
    var response = await http.post("http://10.206.75.133:8080/login.php", body: data);
    if(response.statusCode == 200) {
      // jsonResponse = json.decode(response.body);
      //if(jsonResponse != null) {
        //setState(() {
          //_isLoading = false;
        //});
        sharedPreferences.setString("name", login);
        sharedPreferences.setString("tipo_usuario", _currentUserType.toLowerCase());

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context ) => MainPage()), (Route<dynamic> route) => false);
      //}
    }
    else {
      setState(() {
        _isLoading = false;
      });
      Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: SnackBar(content: Text('Yay! A SnackBar!')) // Complete this code in the next step.
      );
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text, _currentUserType);
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Center(child: Text("Entrar", style: TextStyle(color: Colors.white70))),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  DropdownButton _hintDown() => DropdownButton<String>(
    items: _userTypes.map((String dropDownStringItem) {
      return DropdownMenuItem<String>(
        value: dropDownStringItem,
        child: Text(dropDownStringItem),
      );
    }).toList(),

    onChanged: (String newValueSelected){
      _onDropDownItemSelected(newValueSelected);
    },

    value: this._currentUserType,

    ),
  );

    void _onDropDownItemSelected(String newValueSelected) {
      setState(() {
        this._currentUserType = newValueSelected;
      });
    }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "CPF",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Senha",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("ONG ASPEC Solidária",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
