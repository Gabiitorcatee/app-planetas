class Planeta {
  int? id;
  String nome;
  double tamanho;
  double distanciaDoSol;
  String? descricao;
  String? apelido;

//Construtor da classe Planete
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distanciaDoSol,
    this.descricao,
    this.apelido,
  });

//Construtor alternativo
  Planeta.vazio()
      : nome = '',
        tamanho = 0.0,
        distanciaDoSol = 0.0,
        descricao = '',
        apelido = '';


//fromMap transforma a informação mapeada em binária
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id : map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distanciaDoSol: map['distanciaDoSol'],
      descricao: map['descricao'],
      apelido: map['apelido'],
    );
  }
// get id => null;

// toMap transforma a informção binária em mapeamento organizado
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'nome': nome, 
      'tamanho': tamanho,
      'distanciaDoSol': distanciaDoSol,
      'descricao': descricao,
      'apelido': apelido,
    };
  }
}
