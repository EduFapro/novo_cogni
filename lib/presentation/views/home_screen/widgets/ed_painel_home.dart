import 'package:flutter/material.dart';
import 'ed_folder_card.dart';
import 'ed_historico_avaliacoes.dart';
import 'ed_novo_participante_button.dart';

class EdPainelHome extends StatelessWidget {
  const EdPainelHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width / 4; // A quarter of the screen width
    double cardHeight = 200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Home",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 8.0),
              NovoParticipanteButton(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            children: <Widget>[
              EdFolderCard(
                cardHeight: cardHeight,
                cardWidth: cardWidth,
                folderColor: Color(0xff50bee9),
                tituloCard: "Total de Projetos",
              ),
              SizedBox(width: 8.0),
              EdFolderCard(
                cardHeight: cardHeight,
                cardWidth: cardWidth,
                folderColor: Color(0xfffdbb11),
                tituloCard: "Em progresso",
              ),
              SizedBox(width: 8.0),
              EdFolderCard(
                cardHeight: cardHeight,
                cardWidth: cardWidth,
                folderColor: Color(0xff02bf72),
                tituloCard: "Concluído",
              ),
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: EdHistoricoAvaliacoes(
              placeholder: "Pesquisar...",
            ),
          ),
        )

      ],
    );
  }
}
