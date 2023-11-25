import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/app/enums/modulo_enums.dart';
import '../../../routes.dart';
import '../../widgets/ed_input_text.dart';
import '../home_controller.dart';

class EdHistoricoAvaliacoes extends StatelessWidget {
  EdHistoricoAvaliacoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
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
                placeholder: "Pesquisar...",
                obscureText: false,
              ),
            ],
          ),
        ),
        Obx(() {
          if (homeController.isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else {
            return buildTable(homeController);
          }
        }),
      ],
    );
  }

  Widget buildTable(HomeController homeController) {
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
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.avaliacoes.value.length,
              itemBuilder: (context, index) {
                final avaliacao = homeController.avaliacoes.value[index];
                print("Index: $index");
                print("Avaliacao: $avaliacao");
                final dateFormat = DateFormat.yMd();
                final participante = homeController.participanteDetails[avaliacao.avaliacaoID];
                print("Participante: $participante");

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(participante?.nome ?? 'Unknown')
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(avaliacao.status.description)
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(homeController.user.value?.nome ?? 'Unknown')
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                              avaliacao.dataAvaliacao != null
                                  ? dateFormat.format(avaliacao.dataAvaliacao!)
                                  : ''
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.modulo,
                              arguments: {
                                'avaliacao': avaliacao,
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
              },
            );
          }),
        ],
      ),
    );
  }
}
