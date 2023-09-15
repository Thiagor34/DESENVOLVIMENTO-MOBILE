import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

PageController pageController = PageController();
int paginaAtual = 0;
int contador = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Contact {
  final String imagePath;
  final String name;
  final String email;

  Contact({
    required this.imagePath,
    required this.name,
    required this.email,
  });
}

List<Contact> contacts = [
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/103196282?v=4',
    name: 'Pedro Paulo de Abreu',
    email: 'pedro@email.com',
  ),
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/92828001?v=4',
    name: 'Thiago Ruan Costa',
    email: 'thiago@email.com',
  ),
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/89526223?v=4',
    name: 'Maurício Cardoso Oliveira',
    email: 'mauricio@email.com',
  ),
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/84816808?v=4',
    name: 'Ana Flávia de Freitas Corrêa',
    email: 'ana@email.com',
  ),
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/105252686?v=4',
    name: 'Natália Heinzen',
    email: 'natalia@email.com',
  ),
  Contact(
    imagePath: 'https://avatars.githubusercontent.com/u/40038663?v=4',
    name: 'Jonathan Carlos Costa',
    email: 'jonathan@email.com',
  ),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thiago Costa'),
        centerTitle: true,        
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          75), // Metade da largura/altura para obter um círculo
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover, // Ajuste a imagem para o círculo
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          75), // Metade da largura/altura para obter um círculo
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover, // Ajuste a imagem para o círculo
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          75), // Metade da largura/altura para obter um círculo
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover, // Ajuste a imagem para o círculo
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          75), // Metade da largura/altura para obter um círculo
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover, // Ajuste a imagem para o círculo
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            child: Column(children: [
              SizedBox(height: 20),
              Container(
                width: 400,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 400,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 400,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 400,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        'https://source.unsplash.com/random/',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact.imagePath),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          onTap: (page) {
            pageController.animateToPage(page,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
            setState(() {
              paginaAtual = page;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favortios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Contatos',
            ),
          ]),
    );
  }
}