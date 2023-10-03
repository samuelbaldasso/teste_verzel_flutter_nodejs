import 'dart:convert';

class Carro {
  final int id;
  final String marca;
  final String modelo;
  final int ano;
  final String preco; 
  final String descricao;
  final String imagemUrl;

  Carro({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.preco,
    required this.descricao,
    required this.imagemUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'preco': preco,
      'descricao': descricao,
      'imagem_url': imagemUrl,
    };
  }

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id'] as int,
      marca: map['marca'] as String,
      modelo: map['modelo'] as String,
      ano: map['ano'] as int,
      preco: map['preco'] as String,
      descricao: map['descricao'] as String,
      imagemUrl: map['imagem_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Carro.fromJson(String source) => Carro.fromMap(json.decode(source) as Map<String, dynamic>);
}
