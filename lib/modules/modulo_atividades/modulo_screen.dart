import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/utils/enums/modulo_enums.dart';
import 'modulo_controller.dart';

class ModuloScreen extends StatelessWidget {
  const ModuloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModuloController controller = Get.find<ModuloController>(); // Use Get.find to ensure you're using the same controller instance

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0), // Added padding for better UI
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
                  () => Card(
                color: Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding inside the card
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(controller.participante.value?.nome ?? ''),
                      Text('${controller.age} years old'),
                      Text(controller.modulo.value?.status.description ?? ''),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Added space between elements
            const Text("Lista de Atividades", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10), // Added space between elements
            Expanded(
              // ListView.builder should be wrapped with Expanded in a Column
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.modulo.value?.tarefas.length ?? 0,
                  itemBuilder: (context, index) {
                    final tarefa = controller.modulo.value?.tarefas[index];
                    return ListTile(
                      title: Text(tarefa!.nome),
                      subtitle: Text(tarefa.nome),
                      // Add trailing and leading widgets if needed
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

