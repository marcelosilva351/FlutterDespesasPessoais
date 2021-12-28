import 'package:flutter/material.dart';




class TextFiledTransacao extends StatelessWidget {
  var controller = TextEditingController();
  var texto = "";

  TextFiledTransacao(this.controller, this.texto);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(fillColor: Colors.purple,hoverColor: Colors.purple,label: Text(texto)),
    );  }
}
