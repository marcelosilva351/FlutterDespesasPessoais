



import 'package:financas/WidgetsHome/EditarDespesa.dart';
import 'package:financas/models/Transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class ListaTransacao extends StatefulWidget  {
var controllerTitulo = TextEditingController();
var controllerValor = TextEditingController();

  _ListaTransacao createState() => _ListaTransacao();
}


class _ListaTransacao extends State<ListaTransacao> {


  Future<List<Transacao>> _getDespesas() async{
    List<Transacao> listTransactions = [];
    var uriParse = Uri.parse("https://localhost:44356/v1/despesas");
    var response = await http.get(uriParse,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },);
    var jsonResponse = jsonDecode(response.body);
    print(response.statusCode);
    print(jsonResponse);
      for(var transacao in jsonResponse){
        print(transacao['titulo']);
        var data = DateTime.tryParse(transacao['data']);
        var transacaoAdd = Transacao(transacao['id'], transacao['titulo'], transacao['valor'], data);
        listTransactions.add(transacaoAdd);
        print(transacaoAdd);
      }
      print("LEEEEEEEEENGH " + listTransactions.length.toString());
     return listTransactions;
  }

  _funcaoRemoverDalista(Transacao despesa) async{
    var despesaId = despesa.id;
    var uriParse = Uri.parse("https://localhost:44356/v1/despesas/$despesaId");
    var response = await http.delete(uriParse,
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },);

    if(response.statusCode == 204){
      setState(() {

      });
    }else{
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Ocorreu um erro ao excluir a transação"),
        );
      });
    }
  }







  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<Transacao>>(
          future:  _getDespesas(),
          builder: (context, snapchot) {
    switch (snapchot.connectionState) {
    case ConnectionState.waiting:
    return Center(child: CircularProgressIndicator.adaptive(),);
    break;
    case ConnectionState.done:
            return Container(
              height: 320,
              child: Expanded(child: ListView.builder(
                  itemCount: snapchot.data.length,
                  itemBuilder: (context,Index){
                    var transacao = snapchot.data[Index];
                      return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Text(DateFormat("dd MMM yyyy").format(transacao.data)),
                          Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child:
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.account_balance_wallet ,color: Colors.white,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          children: [
                                            Text("Titulo: " + transacao.titulo, style: TextStyle(fontSize: 13,color: Colors.white),),
                                            Text("Valor: " + transacao.valor.toString(), style: TextStyle(fontSize: 13,color: Colors.white), )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child:
                                          Row(
                                            children:[
                                              GestureDetector(
                                                child:     Icon(Icons.edit,color: Colors.white,),
                                                onTap: (){
                                                showDialog(context: context, builder: (context){
                                                    return EditarDespesa(transacao.id);

                                                });
                                                },

                                              ),
                                              GestureDetector(
                                                child:      Icon(Icons.delete,color: Colors.red,),
                                                onTap: (){

                                                  _funcaoRemoverDalista(transacao);
                                                  setState(() {

                                                  });
                                                },
                                              )

                                            ]
                                          )
                                      )



                                    ],
                                  ),
                                ),

                              ],
                            ),


                          ),

                        ],
                      ),
                    );



                  }
              )),
            );
           
      break;
    }




    }

      );}
  }



