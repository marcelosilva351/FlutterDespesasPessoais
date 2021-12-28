
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarDespesa extends StatefulWidget {
var despesaId;


EditarDespesa(this.despesaId);

  @override
  _State createState() => _State();
}

class _State extends State<EditarDespesa> {
  var controllerTitulo = TextEditingController();
  var controllerValor = TextEditingController();

  _funcaoEditarTransacao() async{
    var despesaId = widget.despesaId;
    var uriParse = Uri.parse("https://localhost:44356/v1/despesas/$despesaId");
    var valorToBody = double.parse(controllerValor.text);
    var bodyPut = json.encode({

        "Titulo" : controllerTitulo.text,
        "Valor" : valorToBody
      });

    var response = await http.put(uriParse,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: bodyPut
    );

    if(response.statusCode == 204){
      setState(() {

      });
      Navigator.pop(context);

    }else{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Ocorreu um erro ao editar a transaçãoo"),
        );
      });
    }


  }



  @override
  Widget build(BuildContext context) {
    return Container(
    height: 200,
    width: 300,
    child:
     AlertDialog(
        title: Text("Editar Despesa"),
       content: Column
         (
         children: [
           TextField(
             controller: controllerTitulo,
             decoration: InputDecoration(label: Text("Titulo")),
           ),
           TextField(
             controller: controllerValor,
             decoration: InputDecoration(label: Text("Valor")),
           )
         ],
       ),
       actions: [
         FlatButton(onPressed: (){
           _funcaoEditarTransacao();

         }
         , child: Text("Editar transação"),
         color: Colors.purple,)
       ],
)
    );
  }
}
