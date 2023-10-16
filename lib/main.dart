import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ecowise/quest.dart';

const Color verdeClaro = Color(0xFF469D9D);
const Color cinzaEscuro = Color(0xFFE4B200);
const Color cinzaClaro = Color(0xFFE4B200); //F5F5F5
const Color branco = Colors.white;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/quest': (context) => Quest(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<BarData> data = [
    BarData('Mar', Random().nextDouble() * 100, Colors.white),
    BarData('Abr', Random().nextDouble() * 100, Colors.white),
    BarData('Maio', Random().nextDouble() * 100, Colors.white),
    BarData('Jun', Random().nextDouble() * 100, Colors.white),
    BarData('Jul', Random().nextDouble() * 100, Colors.white),
    BarData('Ago', Random().nextDouble() * 100, Colors.white),
    BarData('Set', Random().nextDouble() * 100, Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verdeClaro,
      appBar: AppBar(
        title: Text('HOME'),
        centerTitle: true,
        backgroundColor: cinzaClaro,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Divider(thickness: 2),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleIcon(
                    iconPath: 'assets/informacao-financeira.png',
                    color: cinzaClaro,
                    label: 'Gráficos'),
                CircleIcon(
                    iconPath: 'assets/botao-de-inicio.png',
                    color: cinzaClaro,
                    label: 'Áreas'),
                CircleIcon(
                    iconPath: 'assets/lampada-de-ideia.png',
                    color: cinzaClaro,
                    label: 'Dicas'),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              child: charts.BarChart(
                [
                  charts.Series<BarData, String>(
                    id: 'Gastos',
                    domainFn: (BarData data, _) => data.day,
                    measureFn: (BarData data, _) => data.value,
                    data: data,
                    colorFn: (BarData data, _) =>
                        charts.ColorUtil.fromDartColor(data.color),
                  ),
                ],
                animate: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoBox(label: 'Gastos Totais', value: 'R\$87,53'),
                InfoBox(label: 'Economia', value: 'R\$192,81'),
                InfoBox(label: 'Consumo', value: '322 kWh'),
              ],
            ),
            SizedBox(height: 20),
            BottomMenu(),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String label;
  final String value;

  InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cinzaClaro,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  //final IconData icon;
  final String label;
  final Color color;
  final String iconPath;

  CircleIcon(
      {required this.iconPath,
      required this.color,
      //required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Ação quando o círculo for clicado
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                color: branco,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class BarData {
  final String day;
  final double value;
  final Color color;

  BarData(this.day, this.value, this.color);
}

class LineChartWidget extends StatelessWidget {
  final List<charts.Series<LinearSales, num>> seriesList = _createSampleData();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: charts.LineChart(
        seriesList,
        animate: true,
      ),
    );
  }

  static List<charts.Series<LinearSales, num>> _createSampleData() {
    final random = Random();
    final data = List.generate(
        7, (i) => LinearSales(i, (random.nextDouble() * 100).toInt()));
    return [
      charts.Series<LinearSales, num>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.day,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}

class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 2),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                // Mudar para home
              },
              icon: Image.asset('assets/botao-de-inicio.png'),
            ),
            IconButton(
              onPressed: () {
                // Mudar para gráficos
              },
              icon: Image.asset('assets/grafico-de-barras (1).png'),
            ),
            IconButton(
              onPressed: () {
                // Mudar para tela de dicas
              },
              icon: Image.asset('assets/lampada.png'),
            ),
            IconButton(
              onPressed: () {
                // Mudar para tela de notificações
              },
              icon: Image.asset('assets/alerta.png'),
            ),
            IconButton(
              onPressed: () {
                // Mandar pra tela de dúvidas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Quest()),
                );
              },
              icon: Image.asset('assets/ponto-de-interrogacao.png'),
            ),
          ],
        ),
      ],
    );
  }
}

class LinearSales {
  final num day;
  final num sales;

  LinearSales(this.day, this.sales);
}
