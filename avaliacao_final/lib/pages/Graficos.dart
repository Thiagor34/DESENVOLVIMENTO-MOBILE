import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Graficos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard de Despesas'),
      ),
      body: Center(
        child: FutureBuilder<List<PieChartSectionData>>(
          future: _generateSections(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: snapshot.data ?? [],
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: _generateCategoryLabels(snapshot.data),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _generateCategoryLabels(List<PieChartSectionData>? sections) {
    if (sections == null) return [];

    List<Widget> labels = [];

    for (int i = 0; i < sections.length; i++) {
      labels.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                color: sections[i].color,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${sections[i].title ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return labels;
  }

  Future<List<PieChartSectionData>> _generateSections() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Lancamentos')
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('Tipo', isEqualTo: 'Débito')
        .get();

    double totalDebitos = 0;
    List<double> data = [];
    List<String> categorias = [];

    // Calcular total de débitos
    querySnapshot.docs.forEach((document) {
      var dadosLancamento = document.data() as Map<String, dynamic>;
      double valor = dadosLancamento['Valor'] ?? 0;
      totalDebitos += valor;
    });

    // Calcular total por categoria
    querySnapshot.docs.forEach((document) {
      var dadosLancamento = document.data() as Map<String, dynamic>;
      double valor = dadosLancamento['Valor'] ?? 0;
      String categoria = dadosLancamento['Categoria'] ?? '';

      int index = categorias.indexOf(categoria);
      if (index != -1) {
        data[index] += valor;
      } else {
        categorias.add(categoria);
        data.add(valor);
      }
    });

    List<PieChartSectionData> sections = [];

    for (int i = 0; i < data.length; i++) {
      double percentage = (data[i] / totalDebitos) * 100;

      sections.add(
        PieChartSectionData(
          color: _getRandomColor(),
          value: percentage,
          title: '${categorias[i]}: ${percentage.toStringAsFixed(2)}%',
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }

    return sections;
  }

  Color _getRandomColor() {
    return Color.fromRGBO(
      255,
      (DateTime.now().microsecondsSinceEpoch % 255).toInt(),
      (DateTime.now().microsecondsSinceEpoch % 255).toInt(),
      1,
    );
  }
}
