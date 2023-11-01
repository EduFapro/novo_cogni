import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'widgets/ed_barra_lateral.dart';
import 'widgets/ed_painel_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>(); // Getting the controller instance

    double screenWidth = MediaQuery.of(context).size.width;
    double oneSeventhWidth = screenWidth / 7;
    double sixSeventhWidth = 6 * oneSeventhWidth;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffdfdfd),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Cadastro do Avaliador",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Container(
            width: oneSeventhWidth,
            color: Color(0xff000000),
            child: EdBarraLateral(),
          ),
          Container(
            width: sixSeventhWidth,
            color: Color(0xfff3f2f2),
            child: EdPainelHome(),
          ),
        ],
      ),
    );
  }
}
