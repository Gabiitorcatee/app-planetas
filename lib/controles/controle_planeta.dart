import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/planeta.dart';

class ControlePlaneta {
  static Database? _bd;

  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.bd');
    return _bd!;
  }

  Future<Database> _initBD(String localAquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminho = join(caminhoBD, localAquivo);
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBD,
    );
  }

  Future<void> _criarBD(Database db, int version) async {
    const sql = '''
CREATE TABLE planetas(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  tamanho REAL NOT NULL,
  distanciaDoSol REAL NOT NULL,
  descricao TEXT,
  apelido TEXT
)
''';
    await db.execute(sql);
  }

//faz a listagem dos items no banco de Dados
  Future<List<Planeta>> atualizarPlanetas() async {
    final db = await bd;
    final resultado = await db.query('planetas');
    //fromMap trasnforma o dado em informação binária
    return resultado.map((item) => Planeta.fromMap(item)).toList();
  }

//inserir planeta no banco de dados
  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert('planetas', planeta.toMap());
  }

//alterar planeta
  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }

//exluir planeta(id) do banco de dados
  Future<int> excluirPlaneta(int id) async {
    final db = await bd;
    return await db.delete('planetas', where: 'id = ?', whereArgs: [id]);
  }
}
