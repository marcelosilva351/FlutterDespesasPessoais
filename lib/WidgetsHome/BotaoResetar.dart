import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






class BotaoResetar extends StatefulWidget {

  @override
  _BotaoResetarState createState() => _BotaoResetarState();


}








class _BotaoResetarState extends State<BotaoResetar> {


  _resetarTransacoes() async{
    var uriParse = Uri.parse("https://localhost:44356/v1/despesas/Resetar");


    var response = await http.put(uriParse,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
    );

    if(response.statusCode == 204){
      setState(() {
      });
    }
    else{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Erro ao resetar transações"),
        );
      });
    }


  }



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: 200,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child:
        FlatButton(child:
        Text("Resetar transações", style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
        onPressed: (){
          _resetarTransacoes();
      },)
      ),
    );
  }
}
