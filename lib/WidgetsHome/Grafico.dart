import 'dart:convert';

import 'package:financas/models/MesValor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Grafico extends StatefulWidget{
  _Grafico createState() => _Grafico();
}


class _Grafico  extends State<Grafico> {

  Future<MesValor> _getGrafico() async{
    var uriParse = Uri.parse("https://localhost:44356/v1/despesas/ValorMes");
    var response = await http.get(uriParse,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },);
    print("STATUS MESS" + response.statusCode.toString());
  if(response.statusCode == 200){
    var responseJson = jsonDecode(response.body);


      var mesValor = MesValor(responseJson['mesAtual'], responseJson['valorTotalMes']);
      if(mesValor != null){
        return mesValor;
      }


  }


  }




  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return FutureBuilder<MesValor>(
        future: _getGrafico(),
        builder: (context,snapchot){
          switch(snapchot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator.adaptive());
              break;
            case ConnectionState.done:
              return Container(
                width: double.infinity,
                height: 140,
                child:
                Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text("Mês atual: " + snapchot.data.mes.toString()),
                        Center(child: Text("Total Gasto: "+ snapchot.data.valor.toString(), style: TextStyle(fontSize: 20,color: Colors.white),)),
                      ],
                    ),
                  ),
                ),
              );
              break;
          }







        });



      }
}
