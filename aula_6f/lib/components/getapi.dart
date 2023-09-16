import 'dart:convert';

import 'package:http/http.dart' as http;

Future getApi() async {
  var url = Uri.parse('https://raw.githubusercontent.com/wellingtoncosta/fake-contacts-api/master/db.json');
  var response = await http.get(url);
  var data = await jsonDecode(response.body);
  return data['contacts'];
}