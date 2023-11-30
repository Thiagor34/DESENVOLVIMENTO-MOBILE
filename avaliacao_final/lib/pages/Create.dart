import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateAdState();
}

class _CreateAdState extends State<Create> {
  
  var image = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String selectedType = 'Débito';
  String selectedPag = 'Pix';
  DateTime selectedDate = DateTime.now();
  List<String> categories = [];
  List<Map<String, dynamic>> lancamentos = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadUserLancamentos();
        valueController.addListener(() {
      formatCurrency();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

    void formatCurrency() {
    String text = valueController.text;
    if (text.isNotEmpty) {
      text = text.replaceAll(RegExp(r'[^0-9]'), '');

      double value = double.parse(text) / 100;

      String formattedValue = NumberFormat.currency(
        locale: 'pt_BR',
        symbol: 'R\$',
      ).format(value);

      valueController.value = valueController.value.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  createLancamento() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    if (nameController.text.isEmpty ||
        categoryController.text.isEmpty ||
        valueController.text.isEmpty ||
        descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    double valor = double.parse(valueController.text.replaceAll(RegExp(r'[^0-9]'), '')) / 100;

    await FirebaseFirestore.instance.collection('Lancamentos').add({
      'UID': userUID,
      'Nome': nameController.text,
      'Categoria': categoryController.text,
      'Descricao': descController.text,
      'Valor': valor,
      'Tipo': selectedType,
      'Pagamento': selectedPag,
      'Data': selectedDate,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lançamento salvo com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        nameController.clear();
        categoryController.clear();
        valueController.clear();
        descController.clear();
        selectedType = 'Débito';
        selectedPag = 'Pix';
        selectedDate = DateTime.now();
      });
    });

    print('Lançamento salvo no Firestore com sucesso!');
  }

  _openCategoryPickerDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Escolha uma Categoria"),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: categories.map((category) {
                return ListTile(
                  title: Text(
                    category,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    _selectCategory(category);
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _openAddCategoryDialog(context);
              },
              child: Text(
                "Cadastrar Nova",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _openAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController newCategoryController = TextEditingController();

        return AlertDialog(
          title: Text("Cadastrar Nova Categoria"),
          content: Column(
            children: [
              TextField(
                controller: newCategoryController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                _saveNewCategory(newCategoryController.text);
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _loadUserLancamentos() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('Lancamentos')
              .where('UID', isEqualTo: userUID)
              .get();

      if (mounted) {
        setState(() {
          lancamentos = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      }
    } catch (e) {
      print('Erro ao buscar lançamentos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Lançamento'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Categoria: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 18.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: categoryController,
                            readOnly: true,
                            onTap: () {
                              _openCategoryPickerDialog(context);
                            },
                            decoration: InputDecoration(
                              hintText: 'Selecione a categoria',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _openCategoryPickerDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Tipo: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      items: <String>['Débito', 'Crédito'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Pagamento: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: selectedPag,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPag = newValue!;
                        });
                      },
                      items: <String>['Pix', 'Dinheiro', 'Cartão']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(selectedDate.toLocal())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 18.0),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _selectDate(context),
                    label: Text(''),
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createLancamento();
            },
            child: Text('Criar Lançamento'),
          ),
        ],
      ),
    );
  }

  void _loadCategories() async {
    try {
      String userUID = FirebaseAuth.instance.currentUser!.uid;

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('Categorias')
              .where('userUID', isEqualTo: userUID)
              .get();

      if (mounted) {
        setState(() {
          categories =
              snapshot.docs.map((doc) => doc['Nome'] as String).toList();
        });
      }
    } catch (e) {
      print('Erro ao buscar categorias: $e');
    }
  }

  void _selectCategory(String category) {
    setState(() {
      categoryController.text = category;
    });
  }

  void _saveNewCategory(String newCategory) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('Categorias').add({
      'Nome': newCategory,
      'userUID': userUID,
    });

    _loadCategories();
  }
}
