class Modelo {
  String nome;
  List<String> campos;

  Modelo({required this.nome, required this.campos});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'campos': campos,
    };
  }

  factory Modelo.fromMap(Map<String, dynamic> map) {
    return Modelo(
      nome: map['nome'],
      campos: List<String>.from(map['campos']),
    );
  }
}