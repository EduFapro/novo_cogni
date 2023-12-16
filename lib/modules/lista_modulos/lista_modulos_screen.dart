import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lista_modulos_controller.dart';
import 'widgets/ed_modulo_item.dart';

class ListaModulosScreen extends GetView<ListaModulosController> {
  const ListaModulosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.delete<ListaModulosController>();
            Get.back();
          },
        ),
        title: Text("Avaliação"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.greenAccent,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => Card(
                color: Color(0x00282728),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: screenWidth * 0.3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(controller.participante.value?.nome ?? ''),
                        Text('Idade:${controller.age} anos'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth,
              child: const Text(
                "Lista de Atividades",
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: screenWidth * 0.3,
                child: Card(
                  child: Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        children: controller.listaModulos.value
                                ?.map((modulo) => EdModuloItem(
                                      moduloName: modulo?.titulo ?? "",
                                      moduloId: modulo!.moduloID!,
                                    ))
                                .toList() ??
                            [Text('No modules available')],
                      );
                    }
                  }),

                  // child: Column(
                  //   children: [
                  //     EdModuloItem(),
                  //     Container(
                  //       height: screenHeight * 0.04,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Text(
                  //             "Contar-nos seu Nome",
                  //             style:
                  //                 TextStyle(fontSize: 20, color: Colors.black),
                  //           ),
                  //           TarefasButton(
                  //             onPressed: () {},
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Column(
                  //       children: [
                  //         Container(
                  //           width: screenWidth * 0.5,
                  //           height: screenHeight * 0.07,
                  //           color: Colors.black54,
                  //           child: Text(
                  //             "Testes",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //                 fontSize: 40,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Colors.white70),
                  //           ),
                  //         ),
                  //         Container(
                  //           height: screenHeight * 0.04,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Text(
                  //                 "Ouvir Áudio",
                  //                 style: TextStyle(
                  //                     fontSize: 20, color: Colors.black),
                  //               ),
                  //               TarefasButton(
                  //                 onPressed: () {
                  //                   Get.toNamed(AppRoutes.tarefa);
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           height: screenHeight * 0.04,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Text(
                  //                 "Contar-nos seu Nome",
                  //                 style: TextStyle(
                  //                     fontSize: 20, color: Colors.black),
                  //               ),
                  //               TarefasButton(
                  //                 onPressed: () {},
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
