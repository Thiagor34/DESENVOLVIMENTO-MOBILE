import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListItens extends StatelessWidget {
  const ListItens({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Container(height: 0,),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Container(
            height: 150,
            color: Colors.white,
            child: Row(
              children: [
                Image.network('https://source.unsplash.com/200x200/?car'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PS5  Novo', style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,

                        ),),
                        Text('R\$ 2000', style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 70, 69, 69)
                        ),),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Santa Teresa, Palhoça', style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,

                        ),),
                                Text('29 Abril 18:20', style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,

                        ),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
