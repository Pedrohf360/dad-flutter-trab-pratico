import 'package:dad_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dad_app/gerencial/gerencial_page.dart';
import 'package:dad_app/main.dart';

class GerencialCadPage extends StatefulWidget {
  @override
  _GerencialCadPageState createState() => new _GerencialCadPageState();
}

class _GerencialCadPageState extends State<GerencialCadPage> {

  final formKey = GlobalKey<FormState>();
  String _usuario, _senha, _cpf, _tipo = "gerencial";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cadastro de Gerencial'),
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
                    validator: (input) => input.length < 8 ? 'A senha deve ter pelo menos 8 caracteres' : null,
                    onSaved: (input) => _senha = input,
                    obscureText: true,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'CPF:'
                    ),
                    validator: (input) => input.length != 11 ? 'CPF inválido!' : null,
                    onSaved: (input) => _cpf = input,
                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: 'Tipo Usuário:'
//                    ),
//                    onSaved: (input) => _tipo = input,
//                    obscureText: true,
//                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: _submit,
                          child: Text('Cadastrar'),
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
    var response = await http.post("http://10.206.75.133:8080/cadastro.php", body: data);
    if(response.statusCode == 200) {
      // jsonResponse = json.decode(response.body);
      //if(jsonResponse != null) {
      //setState(() {
      //_isLoading = false;
      //});

      //}
    }
  }
}