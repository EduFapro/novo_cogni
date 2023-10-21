import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/avaliador_entity.dart';
import '../../utils/enums/pessoa_enums.dart';
import '../controllers/avaliadores_controller.dart';

class EdTableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avaliadoresController = Get.find<AvaliadoresController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headers using Row widget
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: Text('Nome', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Sobrenome', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Data de Nascimento', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Sexo', style: TextStyle(fontWeight: FontWeight.bold))),
                // Add more headers as needed
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: avaliadoresController.avaliadoresList.length,
              itemBuilder: (context, index) {
                final avaliador = avaliadoresController.avaliadoresList[index];
                return DataRowWidget(avaliador: avaliador); // Custom widget for each row
              },
            ),
          ),
        ],
      );
    });
  }
}

class DataRowWidget extends StatelessWidget {
  final AvaliadorEntity avaliador;

  DataRowWidget({required this.avaliador});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(avaliador.nome)),
          Expanded(child: Text(avaliador.sobrenome)),
          Expanded(child: Text(avaliador.email)),
          Expanded(child: Text(DateFormat('dd/MM/yyyy').format(avaliador.dataNascimento))),
          Expanded(child: Text(avaliador.sexo == Sexo.homem ? 'Homem' : 'Mulher')),
          // Add more cells for additional columns
        ],
      ),
    );
  }
}
