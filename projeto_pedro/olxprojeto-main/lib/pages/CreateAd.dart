import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAd extends StatefulWidget {
  const CreateAd({Key? key}) : super(key: key);

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  var image = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  loadImage() async {
    var picker = ImagePicker();
    var uploadImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = uploadImage;
    });
  }

  createADS(image) async {
    await Firebase.initializeApp();

    await FirebaseFirestore.instance.collection('Produtos').add({
      'nome': nameController.text,
      'preco': double.parse(priceController.text),
      'urlImagem': await uploadImageToStorage(image),
    });

    print('Produto salvo no Firestore com sucesso!');
  }

  Future<String> uploadImageToStorage(image) async {
    Reference root = FirebaseStorage.instance
        .ref()
        .child('Fotos')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    var progress = await root.putFile(File(image.path));

    return await progress.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            color: Colors.grey[200],
            child: image == null
                ? TextButton.icon(
                    onPressed: loadImage,
                    icon: Icon(Icons.photo_camera),
                    label: Text('Carregar Imagem'),
                  )
                : Image.file(File(image.path), fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Anúncio'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Preço do Anúncio'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createADS(image);
            },
            child: Text('Criar Anúncio'),
          ),
          // Image.network(
          //     'https://firebasestorage.googleapis.com/v0/b/crudads.appspot.com/o/Fotos%2F1700265827267.jpg?alt=media&token=91fa50f8-5588-496b-ae04-6092bce8b2b8')
        ],
      ),
    );
  }
}
