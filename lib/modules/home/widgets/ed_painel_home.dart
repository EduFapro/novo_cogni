import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novo_cogni/modules/home/home_controller.dart';
import 'ed_historico_avaliacoes.dart';
import 'ed_folder_card.dart';
import 'ed_novo_participante_button.dart';

class EdPainelHome extends GetView<HomeController> {
  const EdPainelHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = screenWidth / 6;
    double cardHeight = 100;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Home",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              NovoParticipanteButton(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Obx(
                () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xff50bee9),
                  tituloCard: "Total de Projetos",
                  numero: controller.numAvaliacoesTotal.value,
                ),
              ),
              SizedBox(width: 50.0),
              Obx(
                () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xfffdbb11),
                  tituloCard: "Em progresso",
                  numero: controller.numAvaliacoesInProgress.value,
                ),
              ),
              SizedBox(width: 50.0),
              Obx(
                () => EdFolderCard(
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  folderColor: Color(0xff02bf72),
                  tituloCard: "Concluído",
                  numero: controller.numAvaliacoesFinished.value,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: EdHistoricoAvaliacoes(),
        ),
      ],
    );
  }
}
