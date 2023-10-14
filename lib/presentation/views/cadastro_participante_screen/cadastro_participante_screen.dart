import 'package:novo_cogni/presentation/views/cadastro_participante_screen/widgets/formulario_participantes.dart';
import 'package:flutter/material.dart';

class CadastroParticipanteScreen extends StatelessWidget {
  const CadastroParticipanteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: FormularioParticipante(),
      ),
    );
  }
}
