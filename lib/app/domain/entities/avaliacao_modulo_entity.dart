import '../../data/data_constants/avaliacao_modulo_constants.dart';
import '../../data/data_constants/modulo_constants.dart';

class AvaliacaoModuloEntity {
  final int avaliacaoId;
  final int moduloId;

  AvaliacaoModuloEntity({
    required this.avaliacaoId,
    required this.moduloId,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_AVALIACAO_FK: avaliacaoId,
      ID_MODULO_FK: moduloId,
    };
  }

  static AvaliacaoModuloEntity fromMap(Map<String, dynamic> map) {
    return AvaliacaoModuloEntity(
      avaliacaoId: map[ID_AVALIACAO_FK] as int,
      moduloId: map[ID_MODULO_FK] as int,
    );
  }

  // Convert AvaliacaoModuloEntity to JSON string
  String toJson() {
    final Map<String, dynamic> data = this.toMap();
    return jsonEncode(data);
  }

  // Convert JSON string to AvaliacaoModuloEntity
  static AvaliacaoModuloEntity fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return AvaliacaoModuloEntity.fromMap(data);
  }
}
