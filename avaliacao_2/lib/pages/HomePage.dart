import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6E0AD5),
        centerTitle: true,
        elevation: 10,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Alinhar ícones no final
            children: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Ação quando o ícone de pesquisa é pressionado
                },
                tooltip: 'Pesquisar',
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Ação quando o ícone de notificações é pressionado
                },
                tooltip: 'Notificações',
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  // Ação quando o ícone de favoritos é pressionado
                },
                tooltip: 'Favoritos',
              ),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Thiago Costa'),
              accountEmail: Text('thiagorcosta.26@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('TC'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF6E0AD5),
              ),
            ),
            ListTile(
              title: Text('Minha Conta'),
              subtitle: Text('Informações da conta'),
              trailing: Icon(Icons.money),
              leading: Icon(Icons.money_off),
              onLongPress: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
  children: [
    Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Color(0xFF6E0AD5),
                  size: 32,
                ),
                Text(
                  'Fone',
                  style: TextStyle(color: Color(0xFF6E0AD5)),
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 2,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.devices,
                  color: Color(0xFF6E0AD5),
                  size: 32,
                ),
                Text(
                  'Eletrônicos',
                  style: TextStyle(color: Color(0xFF6E0AD5)),
                ),
              ],
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 2,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.filter_list,
                  color: Color(0xFF6E0AD5),
                  size: 32,
                ),
                Text(
                  'Filtros',
                  style: TextStyle(color: Color(0xFF6E0AD5)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    Container(
      height: 150,
      color: Colors.green, // Cor de fundo amarelo
      child: Column(
        children: [
          // Primeira seção com foto, nome, valor, etc.
          ItemSection(),
        ],
      ),
    ),
    Container(
      height: 150,
      color: Colors.yellow, // Cor de fundo amarelo
      child: Column(
        children: [
          // Segunda seção com foto, nome, valor, etc.
          ItemSection(),
        ],
      ),
    ),
    Container(
      height: 150,
      color: Colors.red, // Cor de fundo amarelo
      child: Column(
        children: [
          // Terceira seção com foto, nome, valor, etc.
          ItemSection(),
        ],
      ),
    ),
  ],
),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }
}

PageController pageController = PageController();
int pageNow = 0;

class ItemSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Largura da seção (ajuste conforme necessário)
      margin: EdgeInsets.all(10), // Margem entre as seções
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1), // Borda cinza
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Adicione a foto do item aqui
          Image.asset('assets/item_image.png'), // Substitua pelo caminho da imagem do item

          // Adicione o nome do item aqui
          Text(
            'Nome do Item',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Adicione o valor do item aqui
          Text(
            'R\$ 100,00',
            style: TextStyle(fontSize: 14),
          ),

          // Adicione outras informações do item aqui
          // Exemplo: Descrição, avaliação, botões, etc.
        ],
      ),
    );
  }
}
