import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/utils/enums/modulo_enums.dart';
import 'modulo_controller.dart';

class ModuloScreen extends StatelessWidget {
  const ModuloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModuloController controller = Get.find<ModuloController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => Card(
                color: Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(controller.participante.value?.nome ?? ''),
                      Text('Idade:${controller.age} anos'),
                      Text(controller.modulo.value?.status.description ?? ''),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Lista de Atividades",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
                child: SizedBox(
              width: screenWidth * 0.9,
              child: Card(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.1,
                          color: Colors.black54,
                          child: Text("Avaliação", style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70
                          ),),
                        ),
                        Text("Hahaha"),
                        Column(
                          children: [
                            Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.1,
                              color: Colors.black54,
                              child: Text("Testes", style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70
                              ),),
                            ),
                            Divider(),
                            Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.04,
                              child: Text("Ouvir Áudio", style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),),
                            ),
                            Divider(),
                            Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.04,
                              child: Text("Contar-nos seu Nome", style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),),
                            ),
                            Divider(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                //
                //
                // Obx(
                //       () => ListView.builder(
                //     itemCount: controller.modulo.value?.tarefas.length ?? 0,
                //     itemBuilder: (context, index) {
                //       final tarefa = controller.modulo.value?.tarefas[index];
                //       return ListTile(
                //         title: Text(tarefa!.nome),
                //         subtitle: Text(tarefa.nome),
                //         // Add trailing and leading widgets if needed
                //       );
                //     },
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
