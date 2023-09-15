import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(JokenpoApp());
}

class JokenpoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jokenpo'),
        ),
        body: JokenpoGame(),
      ),
    );
  }
}

class JokenpoGame extends StatefulWidget {
  @override
  _JokenpoGameState createState() => _JokenpoGameState();
}

class _JokenpoGameState extends State<JokenpoGame> {
  String playerChoice = ''; // Escolha do jogador
  String computerChoice = ''; // Escolha do computador
  String computerChoiceImageUrl = ''; // URL da imagem da escolha do computador
  int highlightedChoiceIndex = -1; // Índice da escolha do jogador destacada

  // Função para atualizar a escolha do jogador
  void updatePlayerChoice(String choice, int index) {
    setState(() {
      playerChoice = choice;
      highlightedChoiceIndex = index;
      computerChoice = getComputerChoice();
      computerChoiceImageUrl = getChoiceImageUrl(computerChoice);
    });
  }

  // Função para escolher aleatoriamente a jogada do computador
  String getComputerChoice() {
    final Random random = Random();
    final List<String> choices = ['Pedra', 'Papel', 'Tesoura'];
    return choices[random.nextInt(choices.length)];
  }

  // Função para mapear a escolha do computador para a URL da imagem correspondente
  String getChoiceImageUrl(String choice) {
    switch (choice) {
      case 'Pedra':
        return 'https://jokenpo-lime.vercel.app/pedra.png';
      case 'Papel':
        return 'https://jokenpo-lime.vercel.app/papel.png';
      case 'Tesoura':
        return 'https://jokenpo-lime.vercel.app/tesoura.png';
      default:
        return '';
    }
  }

  // Função para determinar o resultado do jogo
  String determineWinner(String player, String computer) {
    if (player == computer) {
      return 'Empate!';
    } else if (
        (player == 'Pedra' && computer == 'Tesoura') ||
        (player == 'Papel' && computer == 'Pedra') ||
        (player == 'Tesoura' && computer == 'Papel')) {
      return 'Você venceu!';
    } else {
      return 'Computador venceu!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Círculos do jogador
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildChoiceCircle('https://jokenpo-lime.vercel.app/pedra.png', 0),
              buildChoiceCircle('https://jokenpo-lime.vercel.app/papel.png', 1),
              buildChoiceCircle('https://jokenpo-lime.vercel.app/tesoura.png', 2),
            ],
          ),
          SizedBox(height: 20.0),
          // Círculo do computador
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            backgroundImage: NetworkImage(computerChoiceImageUrl),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              final result = determineWinner(playerChoice, computerChoice);
              setState(() {
                // Exibe o resultado do jogo em um diálogo
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Resultado'),
                      content: Text('Jogador escolheu: $playerChoice\nComputador escolheu: $computerChoice\n$result'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            },
            child: Text('Jogar'),
          ),
        ],
      ),
    );
  }

  Widget buildChoiceCircle(String imageUrl, int index) {
    return InkWell(
      onTap: () {
        updatePlayerChoice(imageUrl, index);
      },
      highlightColor: Colors.transparent, // Define a cor de destaque como transparente
      splashColor: Colors.transparent, // Define a cor do efeito de toque como transparente
      hoverColor: Colors.transparent, // Define a cor do hover como transparente
      child: CircleAvatar(
        radius: 50,
        backgroundColor: highlightedChoiceIndex == index
            ? Colors.blue // Cor de destaque quando o usuário passa o mouse por cima
            : Colors.transparent, // Define o fundo como transparente
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
