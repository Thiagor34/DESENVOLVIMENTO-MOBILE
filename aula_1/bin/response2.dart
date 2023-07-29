import 'dart:convert';

import 'package:http/http.dart' as http;

getUser() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  var response = await http.get(url);
  var data = jsonDecode(response.body);

  //retorno do json
  var post = data.map((json) => modelUser.fromJson(json)).toList();

  for(var user in post) {
    print(user.post);
  }
}

void main() {
  getUser();
}


//model
class modelUser{
  String post;
  String titulo;
  
//construtor
  modelUser({
    required this.post, 
    required this.titulo
  });

//monta o json
  factory modelUser.fromJson(Map<String, dynamic>json){
    return modelUser(post: json['title'], titulo: json['body']);
  }
}