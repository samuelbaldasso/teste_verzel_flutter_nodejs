import 'dart:convert';

class User {
  final int? id;
  final String? nome;
  final String email;
  final String senha;
  final String? imagemUrl;

  User({
    this.id,
    this.nome,
    required this.email,
    required this.senha,
    this.imagemUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id ?? 0,
      'nome': nome ?? "",
      'email': email,
      'senha': senha,
      'imagem_url': imagemUrl ?? "",
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? "",
      email: map['email'] ?? "",
      senha: map['senha'] ?? "",
      imagemUrl: map['imagem_url'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
