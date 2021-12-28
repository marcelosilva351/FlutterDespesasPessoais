
import 'package:financas/WidgetsHome/TextFiledTransacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class CriarDespesa extends StatefulWidget {
  var controllerTitulo = TextEditingController();
  var controllerDoubleVarlo = TextEditingController();


  CriarDespesa(this.controllerTitulo, this.controllerDoubleVarlo);

  _CriarDespesaState createState() => _CriarDespesaState();
}

class _CriarDespesaState extends State<CriarDespesa> {


  var stringResult = "";





  _PostDespesa() async{
    if(widget.controllerDoubleVarlo.text == "" || widget.controllerTitulo.text == ""){
      setState(() {
        stringResult = "Você não digitou todos os valores";
      });
    }else{
      setState(() {
        stringResult = "";
      });
      var valorToBody = double.tryParse(widget.controllerDoubleVarlo.text);
      var uriParse = Uri.parse("https://localhost:44356/v1/despesas");
      var bodyPost = json.encode({
        "Titulo" : widget.controllerTitulo.text,
        "Valor" : valorToBody
      });
      var response = await http.post(uriParse,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      body: bodyPost
      );

      print(response.statusCode.toString());
      if(response.statusCode == 201){
          setState(() {
          });
          Navigator.pop(context);
      }



    }

  }

  @override
  Widget build(BuildContext context) {
             return AlertDialog(
               title: Text("Criar despesa"),
               content: Container(
                 height: 200,
                 child: Column(
                   children: [
                     TextFiledTransacao(widget.controllerTitulo,"Titulo"),
                     TextFiledTransacao(widget.controllerDoubleVarlo, "Valor"),
                     Padding(padding: EdgeInsets.only(top: 35),
                       child: FlatButton(child: Text("Criar despesa",style: TextStyle(fontSize: 18,color: Colors.white),
                       ),
                         onPressed: (){
                           _PostDespesa();
                         },
                         color: Colors.purple
                         ,)
                       ,),
                     Text(stringResult,style: TextStyle(color: Colors.black,fontSize: 15))
                   ],
                 ),
               ),



    );
  }
}
