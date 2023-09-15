import 'package:aula_4f/pages/home_page.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  Map request;

  SecondPage({Key? key, required this.request}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segunda página')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome: ${widget.request['nome']}'),
            Text('Idade: ${widget.request['idade']}'),
            Text('Profissão: ${widget.request['profissao']}'),
            Text('Salário: ${widget.request['salario']}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
