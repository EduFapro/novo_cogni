import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/app/enums/modulo_enums.dart';
import 'package:novo_cogni/routes.dart';
import '../home_controller.dart';

class EdHistoricoAvaliacoesTable extends StatelessWidget {
  EdHistoricoAvaliacoesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoading.isTrue) {
        return Center(child: CircularProgressIndicator());
      } else {
        print(controller.avaliacoes.length);
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
                    bool isIndexInRange =
                        index <= controller.modulos.length ;
                    if (isIndexInRange) {
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
                                onTap: () {
                                  Get.toNamed(AppRoutes.modulo,
                                    arguments: {
                                      'participante': participante,
                                      'modulo': modulo,
                                    },
                                  );
                                },
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
