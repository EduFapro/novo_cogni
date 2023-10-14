import 'package:novo_cogni/presentation/views/cadastro_avaliador_screen/widgets/formulario_avaliador.dart';
import 'package:flutter/material.dart';

class CadastroAvaliadorScreen extends StatelessWidget {
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
