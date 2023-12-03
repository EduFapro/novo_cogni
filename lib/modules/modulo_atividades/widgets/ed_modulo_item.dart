import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/modulo_atividades/widgets/tarefas_button.dart';

import '../../../routes.dart';

class EdModuloItem extends StatelessWidget {
  const EdModuloItem({super.key});

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
            "Way2Age",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white70),
          ),
        ),
        Container(
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
                        "Ouvir Áudio",
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
        ),
      ],
    );
  }
}

