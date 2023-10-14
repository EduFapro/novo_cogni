
import 'atividade_entity.dart';

class AvaliacaoEntity {
  final int? avaliacaoID;
  final int avaliadorID;
  final int participanteID;
  final List<AtividadeEntity> activities;

  AvaliacaoEntity({
    this.avaliacaoID,
    required this.avaliadorID,
    required this.participanteID,
    required this.activities,
  });

  Map<String, dynamic> toMap() {
    return {
      'evaluationID': avaliacaoID,
      'avaliadorID': avaliadorID,
      'participanteID': participanteID,
      // Activities conversion might be handled differently based on your needs
      // If you need to store activities as a JSON string in the DB, you can serialize them here.
      'activities': activities.map((activity) => activity.toMap()).toList(),
    };
  }

  static AvaliacaoEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoEntity(
      avaliacaoID: map['evaluationID'] as int?,
      avaliadorID: map['avaliadorID'] as int,
      participanteID: map['participanteID'] as int,
      activities: (map['activities'] as List).map((activityMap) => AtividadeEntity.fromMap(activityMap)).toList(),
    );
  }
}
