import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../utils/enums/pessoa_enums.dart';
import '../../domain/entities/avaliador_entity.dart';
import '../data_constants/avaliador_constants.dart';
import '../data_constants/constantes_gerais.dart';
import 'database_helper.dart';

class AvaliadorLocalDataSource {
  static final AvaliadorLocalDataSource _instance =
  AvaliadorLocalDataSource.internal();

  factory AvaliadorLocalDataSource() => _instance;

  AvaliadorLocalDataSource.internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(await getDatabasesPath(), DATABASE_NAME);
    print(path);

    return await openDatabase(path, version: VERSAO_DATABASE,
        onCreate: (Database db, int newestVersion) async {
          await db.execute(SCRIPT_CREATE_TABELA_AVALIADORES);
        });
  }

// avaliador_local_datasource.dart
  Future<int?> create(AvaliadorEntity avaliador) async {
    try {
      final Database? database = await db;

      final sexoValue = avaliador.sexo == Sexo.homem ? 'Homem' : 'Mulher';

      return await database!.insert(
        TABELA_AVALIADORES,
        {
          NOME_AVALIADOR: avaliador.nome,
          SOBRENOME_AVALIADOR: avaliador.sobrenome,
          DATA_NASCIMENTO_AVALIADOR: avaliador.dataNascimento.toIso8601String(),
          SEXO_AVALIADOR: sexoValue,
          CPF_OU_NIF_AVALIADOR: avaliador.cpfOuNif,
          EMAIL_AVALIADOR: avaliador.email,
          PASSWORD_AVALIADOR: '0000'  // Add this line
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }


  Future<AvaliadorEntity?> getAvaliador(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_AVALIADORES,
        where: '$ID_AVALIADOR = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return AvaliadorEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<int> deleteAvaliador(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABELA_AVALIADORES,
        where: "$ID_AVALIADOR = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateAvaliador(AvaliadorEntity avaliador) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABELA_AVALIADORES,
        avaliador.toMap(),
        where: "$ID_AVALIADOR = ?",
        whereArgs: [avaliador.avaliadorID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<AvaliadorEntity>> getAllAvaliadores() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABELA_AVALIADORES);

      return List.generate(maps.length, (i) {
        return AvaliadorEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<int?> getNumeroAvaliadores() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_AVALIADORES");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }

  Future<AvaliadorEntity?> getAvaliadorByEmail(String email) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_AVALIADORES,
        where: '$EMAIL_AVALIADOR = ?',
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        return AvaliadorEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

}
