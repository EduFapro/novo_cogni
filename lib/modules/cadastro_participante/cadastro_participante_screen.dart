import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/cadastro_participante/widgets/formulario_participantes.dart';

import 'cadastro_participante_controller.dart';

class CadastroParticipanteScreen extends StatelessWidget {
  const CadastroParticipanteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is available for the child widgets
    return GetBuilder<CadastroParticipanteController>(
      init: CadastroParticipanteController(Get.find()), // Initialize the controller
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xfffdfdfd),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Cadastro do Participante",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: FormularioParticipante(controller: controller), // Pass the controller to the FormularioParticipante widget
        ),
      ),
    );
  }
}

