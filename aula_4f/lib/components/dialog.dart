import 'package:flutter/material.dart';

class Confirmacao extends StatefulWidget {
  final VoidCallback onConfirmRemove; // Função de callback para remoção

  const Confirmacao({Key? key, required this.onConfirmRemove})
      : super(key: key);

  @override 
  State<Confirmacao> createState() => _ConfirmacaoState();
}

class _ConfirmacaoState extends State<Confirmacao> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Excluir'),
      content: Text('Deseja excluir o item?'),
      actions: [
        TextButton(
          onPressed: () {
            widget.onConfirmRemove();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item removido'),
                duration: Duration(seconds: 3),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text('Sim'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Não'),
        ),
      ],
    );
  }
}
