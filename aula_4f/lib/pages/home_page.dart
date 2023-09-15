import 'package:flutter/material.dart';

import 'SecondPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController nomeController = TextEditingController();
TextEditingController sobrenomeController = TextEditingController();
List<String> nomes = [];
// var nomeUsuario = 'Thiago';
var request = {
  'nome': 'Thiago',
  'idade': '36',
  'profissao': 'Programador',
  'salario': '12000'
};

class _HomePageState extends State<HomePage> {
  // Função para navegar para a próxima página
  void navigateToNextPage(BuildContext context) {
    // Aqui você pode adicionar a lógica de navegação para a próxima página
    // Por exemplo, você pode usar Navigator.push para ir para a próxima página.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            // Campo de Sobrenome
            TextField(
              controller: sobrenomeController,
              decoration: InputDecoration(labelText: 'Sobrenome'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nomes.add(nomeController.text.toUpperCase() +
                      ' ' +
                      sobrenomeController.text.toUpperCase());
                  nomeController.clear();
                  sobrenomeController.clear();
                });
              },
              child: Text('Adicionar'),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: ListView.builder(
                itemCount: nomes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(nomes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // showDialog(
                        // context: context,
                        // builder: (BuildContext context) {
                        //   return Confirmacao();
                        // });
                      },
                    ),
                  );
                },
              ),
            ),
            // Botão "Próxima Página"
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SecondPage(request: request),
                  ),
                ); // Chame a função de navegação aqui
              },
              child: Text('Próxima Página'),
            ),
          ],
        ),
      ),
    );
  }
}
