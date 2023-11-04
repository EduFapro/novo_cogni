import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/domain/entities/avaliador_entity.dart';
import '../../routes.dart';
import '../avaliadores/avaliadores_controller.dart';

class EdNovoAvaliadorButton extends StatelessWidget {
  const EdNovoAvaliadorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // Navigate and wait for the result
        var result = await Get.toNamed(AppRoutes.cadastroAvaliador);
        // If the result is a new Avaliador, add it to the list
        if (result is AvaliadorEntity) {
          final AvaliadoresController controller = Get.find();
          controller.addAvaliador(result);
        }
      },

      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: Color(0xff17120f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 4.0),
          Text("Novo Avaliador"),
        ],
      ),
    );
  }
}
