import '../../data/datasource/participant_local_datasource.dart';
import '../../domain/entities/participant_entity.dart';

class ParticipantRepository {
  final ParticipantLocalDataSource localDataSource;

  ParticipantRepository({required this.localDataSource});

  // Create a Participant
  Future<int?> createParticipant(ParticipantEntity participant) async {
    return await localDataSource.create(participant);
  }

  // Get a Participant by ID
  Future<ParticipantEntity?> getParticipant(int id) async {
    return await localDataSource.getParticipant(id);
  }

  // Delete a Participant by ID
  Future<int> deleteParticipant(int id) async {
    return await localDataSource.deleteParticipant(id);
  }

  // Update a Participant
  Future<int> updateParticipant(ParticipantEntity participant) async {
    return await localDataSource.updateParticipant(participant);
  }

  // Get all Participants
  Future<List<ParticipantEntity>> getAllParticipants() async {
    try {
      return await localDataSource.getAllParticipants();
    } catch (e) {
      print('Error fetching all participants: $e');
      return [];
    }
  }

  // Get a Participant by Evaluation ID
  Future<ParticipantEntity?> getParticipantByEvaluation(int evaluationId) async {
    return await localDataSource.getParticipantByEvaluation(evaluationId);
  }

  // Get the number of Participants
  Future<int?> getNumberOfParticipants() async {
    return await localDataSource.getNumberOfParticipants();
  }
}
