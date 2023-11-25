import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../domain/entities/participante_entity.dart';
import '../../enums/pessoa_enums.dart';
import '../data_constants/avaliacao_constants.dart';
import '../data_constants/participante_constants.dart';
import '../data_constants/database_constants.dart';
import 'database_helper.dart';

class ParticipanteLocalDataSource {

  static final ParticipanteLocalDataSource _instance = ParticipanteLocalDataSource._internal();
  factory ParticipanteLocalDataSource() => _instance;
  ParticipanteLocalDataSource._internal();

  final dbHelper = DatabaseHelper();

  Future<Database?> get db async => dbHelper.db;

  Future<int?> create(ParticipanteEntity participante) async {
    try {
      final Database? database = await db;

      final sexoValue = participante.sexo == Sexo.homem ? 'Homem' : 'Mulher';

      return await database!.insert(
        TABELA_PARTICIPANTES,
        {
          NOME_PARTICIPANTE: participante.nome,
          SOBRENOME_PARTICIPANTE: participante.sobrenome,
          DATA_NASCIMENTO_PARTICIPANTE: participante.dataNascimento.toIso8601String(),
          SEXO_PARTICIPANTE: sexoValue,
          ESCOLARIDADE_PARTICIPANTE: participante.escolaridade.toString().split('.').last,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return null;
    }
  }


Future<ParticipanteEntity?> getParticipante(int id) async {
    try {
      final Database? database = await db;

      final List<Map<String, dynamic>> maps = await database!.query(
        TABELA_PARTICIPANTES,
        where: '$ID_PARTICIPANTE = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ParticipanteEntity.fromMap(maps.first);
      }

      return null;
    } catch (ex) {
      print(ex);
      return null;
    }
  }


  Future<int> deleteParticipante(int id) async {
    try {
      final Database? database = await db;

      return await database!.delete(
        TABELA_PARTICIPANTES,
        where: "$ID_PARTICIPANTE = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<int> updateParticipante(ParticipanteEntity participante) async {
    try {
      final Database? database = await db;

      return await database!.update(
        TABELA_PARTICIPANTES,
        participante.toMap(),
        where: "$ID_PARTICIPANTE = ?",
        whereArgs: [participante.participanteID],
      );
    } catch (ex) {
      print(ex);
      return -1;
    }
  }

  Future<List<ParticipanteEntity>> getAllParticipantes() async {
    try {
      final Database? database = await db;
      final List<Map<String, dynamic>> maps = await database!.query(TABELA_PARTICIPANTES);

      return List.generate(maps.length, (i) {
        return ParticipanteEntity.fromMap(maps[i]);
      });
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<ParticipanteEntity?> getParticipanteByAvaliacao(int avaliacaoId) async {
    final Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query(
      TABELA_AVALIACOES, // Assuming the participanteID is stored in the avaliacoes table
      columns: [ID_PARTICIPANTE_FK], // Replace with your foreign key column name
      where: '$ID_AVALIACAO = ?', // Replace with your primary key column name for avaliacoes
      whereArgs: [avaliacaoId],
    );

    if (maps.isNotEmpty) {
      int participanteId = maps.first[ID_PARTICIPANTE_FK];
      return await getParticipante(participanteId);
    }
    return null;
  }

  Future<int?> getNumeroParticipantes() async {
    final Database? database = await db;
    final List<Map<String, dynamic>> result = await database!.rawQuery("SELECT COUNT(*) AS count FROM $TABELA_PARTICIPANTES");
    return result.first["count"] as int?;
  }

  Future<void> closeDatabase() async {
    final Database? database = await db;
    return database!.close();
  }
}