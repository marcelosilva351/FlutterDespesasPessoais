class Transacao {
  int id;
  String titulo;
  double valor;
  DateTime data;

  Transacao(this.id, this.titulo, this.valor, this.data);

  Transacao.fromJSson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    valor = json['valor'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['valor'] = this.valor;
    data['data'] = this.data;
    return data;
  }
}