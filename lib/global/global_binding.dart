import 'package:get/get.dart';
import 'package:novo_cogni/global/user_controller.dart';
import 'package:novo_cogni/global/user_service.dart';

import '../app/data/datasource/evaluation_local_datasource.dart';
import '../app/data/datasource/evaluator_local_datasource.dart';
import '../app/data/datasource/participant_local_datasource.dart';
import '../app/domain/repositories/evaluation_repository.dart';
import '../app/domain/repositories/evaluator_repository.dart';
import '../app/domain/repositories/participant_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources (Lazy Initialization)
    Get.lazyPut<EvaluatorLocalDataSource>(() => EvaluatorLocalDataSource());
    Get.lazyPut<EvaluationLocalDataSource>(() => EvaluationLocalDataSource());
    Get.lazyPut<ParticipantLocalDataSource>(() => ParticipantLocalDataSource());

    // Repositories (Lazy Initialization)
    Get.lazyPut<EvaluatorRepository>(() => EvaluatorRepository(
        localDataSource: Get.find<EvaluatorLocalDataSource>()));
    Get.lazyPut<EvaluationRepository>(() => EvaluationRepository(
        localDataSource: Get.find<EvaluationLocalDataSource>()));
    Get.lazyPut<ParticipantRepository>(() => ParticipantRepository(
        localDataSource: Get.find<ParticipantLocalDataSource>()));


    // Core Services (Immediate Initialization)
    Get.put<UserService>(UserService());
    Get.put<UserController>(UserController());
  }
}
