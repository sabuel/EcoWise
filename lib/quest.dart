import 'package:flutter/material.dart';

const Color verdeClaro = Color(0xFF469D9D);
const Color cinzaEscuro = Color(0xFFE4B200);
const Color cinzaClaro = Color(0xFFE4B200); //F5F5F5
const Color branco = Colors.white;

class Quest extends StatefulWidget {
  @override
  _QuestState createState() => _QuestState();
}

class _QuestState extends State<Quest> {
  int perguntaAtual = 0;
  late List<String> respostas;

  List<String> perguntas = [
    'Quantos cômodos sua casa tem',
    'Você possui quantas lâmpadas na casa?',
    'As lâmpadas são led ou fluorescentes?',
    'Você possui ar-condicionado em casa? Se sim, quantos?',
  ];

  List<List<String>> opcoes = [
    ['3', '4', '5', '6'],
    ['8', '10', '12', '14'],
    ['Led', 'Fluorescentes'],
    ['0', '1', '2', '3'],
  ];

  @override
  void initState() {
    super.initState();
    respostas = List.filled(perguntas.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionário'),
        centerTitle: true,
        backgroundColor: cinzaClaro,
      ),
      body: Column(
        children: [
          Text(perguntas[perguntaAtual]),
          Column(
            children: opcoes[perguntaAtual]
                .map(
                  (opcao) => ListTile(
                    title: Text(opcao),
                    leading: Radio<String>(
                      value: opcao,
                      groupValue: respostas[perguntaAtual],
                      onChanged: (String? value) {
                        setState(() {
                          respostas[perguntaAtual] = value ?? '';
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              if (perguntaAtual < perguntas.length - 1) {
                setState(() {
                  perguntaAtual++;
                });
              } else {
                print(respostas);
              }
            },
            child: Text('Próxima Pergunta'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Quest(),
  ));
}
