import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app/enums/pessoa_enums.dart';
import '../avaliadores/avaliadores_controller.dart';
import 'ed_input_text.dart';
import 'ed_novo_avaliador_button.dart';

class EdListaAvaliadores extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  EdListaAvaliadores({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AvaliadoresController controller = Get.find<AvaliadoresController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Lista de Avaliadores",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          EdInputText(
            placeholder: placeholder,
            obscureText: obscureText,
          ),
          Expanded(
            child: Obx(() {
              var avaliadoresList = controller.avaliadoresList;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: const [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Data de Nascimento')),
                    DataColumn(label: Text('Sexo')),
                  ],
                  rows: avaliadoresList.map((avaliador) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${avaliador.nome} ${avaliador.sobrenome}')),
                        DataCell(Text(avaliador.email)),
                        DataCell(Text(DateFormat('dd/MM/yyyy').format(avaliador.dataNascimento))),
                        DataCell(Text(avaliador.sexo == Sexo.homem ? 'Homem' : 'Mulher')),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          SizedBox(
            width: 900,
            child: EdNovoAvaliadorButton(),
          ),
        ],
      ),
    );
  }
}
