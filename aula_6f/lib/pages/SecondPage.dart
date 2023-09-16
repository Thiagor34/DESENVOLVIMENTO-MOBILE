import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  // String nome;

  Map request;

  SecondPage({super.key, required this.request});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request['name']),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: widget.request['gender'] == 'male' ? Color.fromARGB(255, 218, 238, 255) : Color.fromARGB(255, 255, 213, 228),
        ),
        child: Center(
          child: Column(
            children: [
              ClipOval(
                child: Hero(
                  tag: widget.request['name'],
                  child: Image(
                    image: NetworkImage(widget.request['photo']),
                    width: 200, // Defina a largura da imagem conforme necessário
                    height: 200, // Defina a altura da imagem conforme necessário
                    fit: BoxFit.cover, // Ajuste para cobrir o círculo
                  ),
                ),
              ),
              Text('Nome: ${widget.request['name']}'),
              Text('Idade: ${widget.request['age']}'),
              Text('Sexo: ${widget.request['gender']}'),
              Text('Email: ${widget.request['email']}'),
              Text('Empresa: ${widget.request['company']}'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Voltar para a primeira página'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
