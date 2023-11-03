import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/routes.dart';
import 'package:novo_cogni/utils/enums/modulo_enums.dart';
import '../home_controller.dart';

class EdHistoricoAvaliacoesTable extends StatelessWidget {
  EdHistoricoAvaliacoesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    // Wrap with Obx to listen for changes
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Table Header
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("Nome",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Status",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Avaliador",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Data",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Divider(),

              // Table Rows
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.avaliacoes.length,
                  itemBuilder: (context, index) {
                    if (index < controller.participantes.length &&
                        index < controller.modulos.length &&
                        index < controller.avaliadores.length) {
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
                              Expanded(
                                  flex: 2,
                                  child: Text(modulo.status.description)),
                              Expanded(flex: 2, child: Text(avaliador.nome)),
                              Expanded(
                                flex: 2,
                                child: Text(modulo.date != null
                                    ? dateFormat.format(modulo.date!)
                                    : ''),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.modulo),
                                child: Icon(Icons.create_rounded),
                              ),
                              const Icon(Icons.delete),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        );
      }
    });
  }
}
