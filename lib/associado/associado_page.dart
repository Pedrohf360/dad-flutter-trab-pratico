import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssociadoPage extends StatefulWidget {
  @override
  _AssociadoPageState createState() => new _AssociadoPageState();
}

class _AssociadoPageState extends State<AssociadoPage> {
  Future<List<dynamic>> getAssociados() async {
    http.Response response =
        await http.get("http://10.206.75.133:8080/cadastro.php?tipoUsuario=associado");
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  var _associados;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Associado'),
      ),
      body: FutureBuilder(
          future: this.getAssociados(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 5,
                  ),
                );

              default:
                if (snapshot.hasError)
                  return Container();
                else
                  return this.getListView(context, snapshot);
            }
          }),
    );
  }

  Widget getListView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < snapshot.data.length) {
        return ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(snapshot.data[index]["usuario"]),
          subtitle: Text(snapshot.data[index]["cpf"]),
          trailing: Icon(Icons.restore_from_trash),
          onTap: () {
            debugPrint("Landscape tapped");
            Map data = {
              'usuarioId': snapshot.data[index]["usuario_id"]
            };
            var jsonResponse = null;
            var response = http.post("http://10.206.75.133:8080/cadastro.php", body: data);
          },
        );
      }
    });
  }
}
