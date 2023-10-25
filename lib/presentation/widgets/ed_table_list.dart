import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../utils/enums/pessoa_enums.dart';
import '../controllers/avaliadores_controller.dart';

class EdTableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avaliadoresController = Get.find<AvaliadoresController>();

    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 16, // Adjust as needed
          columns: const [
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Data de Nascimento')),
            DataColumn(label: Text('Sexo')),
            // Add more columns as needed
          ],
          rows: avaliadoresController.avaliadoresList.map((avaliador) {
            return DataRow(
              cells: [
                DataCell(Text('${avaliador.nome} ${avaliador.sobrenome}')), // Concatenated name and surname
                DataCell(Text(avaliador.email)),
                DataCell(Text(DateFormat('dd/MM/yyyy').format(avaliador.dataNascimento))),
                DataCell(Text(avaliador.sexo == Sexo.homem ? 'Homem' : 'Mulher')),
                // Add more cells for additional columns
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}
