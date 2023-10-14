import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/avaliadores_controller.dart';
import '../../widgets/ed_lista_avaliadores.dart';

class AvaliadoresScreen extends StatelessWidget {
  const AvaliadoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avaliadoresController = Get.find<AvaliadoresController>();
    double screenHeight = MediaQuery.of(context).size.height;
    double bodyHeight = screenHeight * 0.85;

    return Scaffold(
      appBar: AppBar(
        title: Text("Avaliadores"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: bodyHeight,
        child: EdListaAvaliadores(placeholder: 'Buscar...'),
      ),
    );
  }
}
