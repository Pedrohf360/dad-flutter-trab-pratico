import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dad_app/login_page.dart';

class UsuarioCadPage extends StatefulWidget {
  @override
  _UsuarioCadPageState createState() => new _UsuarioCadPageState();
}

class _UsuarioCadPageState extends State<UsuarioCadPage> {

  final formKey = GlobalKey<FormState>();
  String _usuario, _senha, _cpf, _tipo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Usuário Cad'),
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Usuário:'
                    ),
                    onSaved: (input) => _usuario = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Senha:'
                    ),
                    validator: (input) => input.length < 8 ? 'You need at least 8 characters' : null,
                    onSaved: (input) => _senha = input,
                    obscureText: true,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'CPF:'
                    ),
                    validator: (input) => input.length != 11 ? 'Invalid CPF!' : null,
                    onSaved: (input) => _cpf = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Tipo Usuário:'
                    ),
                    onSaved: (input) => _tipo = input,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: _submit,
                          child: Text('Sign in'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _submit(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      print(_usuario);
      print(_senha);
      print(_cpf);
      print(_tipo);
    }

    cadastrar(_usuario, _senha, _cpf, _tipo);
  }

  cadastrar(String login, pass, cpf, userType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'usuario': login,
      'senha': pass,
      'cpf': cpf,
      'tipoUsuario': userType
    };
    var response = await http.post("http://192.168.0.17:8080/cadastrar.php", body: data);
    if(response.statusCode == 200) {
      // jsonResponse = json.decode(response.body);
      //if(jsonResponse != null) {
      //setState(() {
      //_isLoading = false;
      //});

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context ) => LoginPage()), (Route<dynamic> route) => false);
      //}
    }
  }
}