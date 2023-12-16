import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/app/domain/entities/tarefa_entity.dart';
import 'package:novo_cogni/modules/lista_modulos/widgets/tarefas_button.dart';

import '../../../routes.dart';
import '../lista_modulos_controller.dart';

class EdModuloItem extends GetView<ListaModulosController> {
  final String moduloName;
  final int moduloId;

  const EdModuloItem({
    super.key, 
    required this.moduloName, 
    required this.moduloId
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.5,
          height: screenHeight * 0.07,
          color: Colors.black54,
          child: Text(
            moduloName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white70),
          ),
        ),
        Obx(() {
          var tarefas = controller.listaTarefasDetails.value
              .firstWhere((element) => element.containsKey(moduloId), orElse: () => {})
              [moduloId] ?? [];

          return Column(
            children: tarefas.map((tarefa) => EdTarefaItem(tarefaName: tarefa.nome)).toList(),
          );
        }),
      ],
    );
  }
}

class EdTarefaItem extends StatelessWidget {
  final String tarefaName;

  const EdTarefaItem({
    super.key, 
    required this.tarefaName,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.red,
      height: screenHeight * 0.09,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD7D8D8),
                  borderRadius: BorderRadius.circular(10), // Rounded edges
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    tarefaName,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: TarefasButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.tarefa);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
