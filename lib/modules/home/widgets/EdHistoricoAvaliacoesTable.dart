import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/utils/enums/modulo_enums.dart';

import '../../widgets/ed_input_text.dart';
import '../home_controller.dart';

class EdHistoricoAvaliacoesTable extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  EdHistoricoAvaliacoesTable({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>(); // Use Get.find to obtain HomeController instance

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Histórico de Avaliações",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          EdInputText(
            placeholder: placeholder,
            obscureText: obscureText,
          ),

          // Table Header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Avaliador", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Data", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Divider(),

          // Table Rows
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.avaliacoes.length,
            itemBuilder: (context, index) {
              final participante = controller.participantes[index];
              final modulo = controller.modulos[index];
              final avaliador = controller.avaliadores[index];
              final dateFormat = DateFormat.yMd();

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(participante.nome)),
                      Expanded(flex: 2, child: Text(modulo.status.description)),
                      Expanded(flex: 2, child: Text(avaliador.nome)),
                      Expanded(flex: 2, child: Text(modulo.date != null ? dateFormat.format(modulo.date!) : '')),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
