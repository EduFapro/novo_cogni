import '../../data/datasource/participante_local_datasource.dart';
import '../../domain/entities/participante_entity.dart';

class ParticipanteRepository {
  final ParticipanteLocalDataSource localDataSource;

  ParticipanteRepository({required this.localDataSource});

  // Create an Participant
  Future<int?> createParticipante(ParticipanteEntity participante) async {
    return await localDataSource.create(participante);
  }

  // Get an Participant by ID
  Future<ParticipanteEntity?> getParticipante(int id) async {
    return await localDataSource.getParticipante(id);
  }

  // Delete an Participante by ID
  Future<int> deleteParticipante(int id) async {
    return await localDataSource.deleteParticipante(id);
  }

  // Update an Participante
  Future<int> updateParticipante(ParticipanteEntity participante) async {
    return await localDataSource.updateParticipante(participante);
  }

  // Get all Participantes
  Future<List<ParticipanteEntity>> getAllParticipantes() async {
    try {
      return await localDataSource.getAllParticipantes();
    } catch (e) {
      print('Error fetching all avaliacoes: $e');
      return [];
    }
  }
  Future<ParticipanteEntity?> getParticipanteByAvaliacao(int avaliacaoId) async {
    return await localDataSource.getParticipanteByAvaliacao(avaliacaoId);
  }
  // Get the number of Participantes
  Future<int?> getNumeroParticipantes() async {
    return await localDataSource.getNumeroParticipantes();
  }
}
