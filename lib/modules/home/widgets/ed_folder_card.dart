import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EdFolderCard extends StatelessWidget {
  const EdFolderCard({
    super.key,
    required this.cardHeight,
    required this.cardWidth,
    required this.folderColor,
    required this.tituloCard,
    required this.numero,
  });

  final double cardHeight;
  final double cardWidth;
  final String tituloCard;
  final Color folderColor;
  final int numero;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          color: folderColor,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 120,
                  child: SvgPicture.asset(
                    "assets/folder.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(tituloCard),
                    Text(numero.toString()),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}