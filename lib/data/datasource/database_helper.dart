import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../data_constants/atividade_constants.dart';
import '../data_constants/avaliacao_constants.dart';
import '../data_constants/avaliador_constants.dart';
import '../data_constants/constantes_gerais.dart';
import '../data_constants/participante_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DATABASE_NAME);
    print("Database path: $path");

    return await openDatabase(path, version: VERSAO_DATABASE, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(SCRIPT_CREATE_TABELA_AVALIADORES);
    await db.execute(SCRIPT_CREATE_TABELA_PARTICIPANTES);
    await db.execute(SCRIPT_CREATE_TABELA_AVALIACOES);
    await db.execute(SCRIPT_CREATE_TABELA_ATIVIDADES);
  }


}
