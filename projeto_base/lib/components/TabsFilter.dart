import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TabsFilter extends StatelessWidget {
  const TabsFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Container(padding: EdgeInsets.symmetric(vertical: 15), width: MediaQuery.of(context).size.width / 3, child: Text('Teste', textAlign: TextAlign.center,), decoration: BoxDecoration(color: Colors.white),),
              Container(padding: EdgeInsets.symmetric(vertical: 15), width: MediaQuery.of(context).size.width / 3, child: Text('Teste', textAlign: TextAlign.center,), decoration: BoxDecoration(color: Colors.white),),
              Container(padding: EdgeInsets.symmetric(vertical: 15), width: MediaQuery.of(context).size.width / 3, child: Text('Teste', textAlign: TextAlign.center,), decoration: BoxDecoration(color: Colors.white),),
            ],
          );
  }
}