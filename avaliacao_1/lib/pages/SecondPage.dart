import 'package:avaliacao_1/components/getapi.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController cityController = TextEditingController();
  String cityName = '';
  String temperature = '';
  String minTemperature = '';
  String maxTemperature = '';
  String weatherDescription = ''; 
  bool showResults = false; // Para controlar a visibilidade dos círculos
 
  void _searchCity(BuildContext context) async {
    cityName = cityController.text;
    var apiData = await getApi(cityName);

    if (apiData.isNotEmpty) {
      var mainData = apiData['main'];
      var temp = mainData['temp']; // Temperatura atual
      var minTemp = mainData['temp_min']; // Temperatura mínima
      var maxTemp = mainData['temp_max']; // Temperatura máxima
      var weather = apiData['weather'][0]['description']; // Descrição do tempo
      var name = apiData['name'];

      setState(() {
        temperature = temp.toStringAsFixed(2) + "°C";
        minTemperature = minTemp.toStringAsFixed(2) + "°C";
        maxTemperature = maxTemp.toStringAsFixed(2) + "°C";
        weatherDescription = 'Tempo: $weather'.toUpperCase(); // Define a descrição do tempo
        cityName = name;
        showResults = true;
        cityController.text = '';
      });
    } else {
      setState(() {
        temperature = 'Cidade não encontrada';
        minTemperature = '';
        maxTemperature = '';
        weatherDescription = '';
        showResults = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Campo de pesquisa de cidade
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'Pesquisar Cidade',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _searchCity(context); // Realiza a pesquisa ao clicar no botão
              },
              child: Text('Pesquisar'),
            ),
            SizedBox(height: 20.0),
            // Nome da cidade pesquisada
            Text(
              cityName.isNotEmpty ? cityName.toUpperCase() : '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: showResults,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 65, 247, 126),
                      border: Border.all(
                        color: Colors.black, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    child: Center(
                      child: Text(
                        maxTemperature,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0), // Espaçamento
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Visibility(
                    visible: showResults,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height:100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 89, 141, 255),
                            border: Border.all(
                              color: Colors.black, // Cor da borda
                              width: 1.0, // Largura da borda
                            ),
                          ),
                          child: Center(
                            child: Text(
                              minTemperature,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.black, // Cor da borda
                              width: 1.0, // Largura da borda
                            ),
                          ),
                          child: Center(
                            child: Text(
                              maxTemperature,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0), // Espaçamento
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'MIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Text(
                        'MAX',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  // Descrição do tempo
                  Text(
                    weatherDescription,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
