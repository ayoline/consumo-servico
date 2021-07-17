import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = 'Resultado';
  TextEditingController _controllerCep = TextEditingController();

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    var url = Uri.parse("https://viacep.com.br/ws/" + cepDigitado + "/json/");
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = ' $logradouro, $complemento, $localidade';
    });

    print(
        "Resposta logradouro: $logradouro complemento: $complemento bairro: $bairro localidade: $localidade");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Digite o CEP: ex 95043610'),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            ElevatedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
