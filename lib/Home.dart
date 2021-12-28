


import 'package:financas/WidgetsHome/BotaoResetar.dart';
import 'package:financas/WidgetsHome/CriarDespesa.dart';
import 'package:financas/WidgetsHome/Grafico.dart';
import 'package:financas/WidgetsHome/TextFiledTransacao.dart';
import 'package:financas/WidgetsHome/listaTransacao.dart';
import 'package:financas/models/Transacao.dart';
import 'package:flutter/material.dart';
 class Home extends StatefulWidget {

   @override
   _HomeState createState() => _HomeState();
 }





    class _HomeState extends State<Home>  {

      var controllerTitulo = TextEditingController();
      var controllerDoubleVarlo = TextEditingController();
      var stringResult = "";



      @override
      Widget build(BuildContext context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
             showDialog(context: context, builder: (context){
               return CriarDespesa(controllerTitulo, controllerDoubleVarlo);
             });
          },),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 40,
              color: Colors.purple,

            ),
          ),
          appBar: AppBar(title: Text("Despesas pessoas"),),
          body: Padding(padding: EdgeInsets.all(12),
            child: Column(
              children: [
                //GRAFICO
                Grafico(),
                ListaTransacao(),
                BotaoResetar()

                // LISTA TRANSACOES
        ])
        )
        );
      }
    }



