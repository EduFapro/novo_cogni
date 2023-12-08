import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/cadastro_avaliador/widgets/formulario_avaliador.dart';
import 'package:novo_cogni/modules/cadastro_avaliador/cadastro_avaliador_controller.dart';

class CadastroAvaliadorScreen extends GetView<CadastroAvaliadorController> {
  const CadastroAvaliadorScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Cadastro do Avaliador", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: FormularioAvaliador(),
    );
  }
}
