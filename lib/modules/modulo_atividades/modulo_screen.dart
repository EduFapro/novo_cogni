import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/modulo_atividades/widgets/tarefas_button.dart';
import 'package:novo_cogni/routes.dart';
import 'modulo_controller.dart';
import 'widgets/ed_modulo_item.dart';

class ModuloScreen extends StatelessWidget {
  const ModuloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModuloController controller = Get.find<ModuloController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Avaliação"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.greenAccent,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
                  () => Card(
                color: Color(2631464),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: screenWidth * 0.3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(controller.participante.value?.nome ?? ''),
                        Text('Idade:${controller.age} anos'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              child: const Text(
                "Lista de Atividades",
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(

                width: screenWidth * 0.3,
                child: Card(
                  child: Column(
                    children: [
                      EdModuloItem(),
                      Container(
                        height: screenHeight * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Contar-nos seu Nome",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            TarefasButton(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.07,
                            color: Colors.black54,
                            child: Text(
                              "Testes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Ouvir Áudio",
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                                TarefasButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.tarefa);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Contar-nos seu Nome",
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                                TarefasButton(
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
