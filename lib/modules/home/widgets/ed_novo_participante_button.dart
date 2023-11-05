import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes.dart';

class NovoParticipanteButton extends StatelessWidget {
  const NovoParticipanteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.toNamed(AppRoutes.cadastroParticipante);
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
        children: <Widget>[
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 4.0),
          Text("Novo Participante"),
        ],
      ),
    );
  }
}