import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/enums/pessoa_enums.dart';
import '../cadastro_avaliador_controller.dart';

class FormularioAvaliador extends StatelessWidget {


  final controller = Get.find<CadastroAvaliadorController>();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double formWidth = screenWidth * 0.8;
    const double spacingWidth = 16.0;
    double adjustedFormWidth = formWidth - spacingWidth;
    double adjustedFormWidthRow2 = formWidth - 2 * spacingWidth;

    double fieldWidthRow1 = (adjustedFormWidth) / 2;
    double fieldWidthRow2 = adjustedFormWidthRow2 / 3;
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Dados de Identificação',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.nomeCompletoController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              border: InputBorder.none,
                              labelText: 'Nome Completo',
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow1,
                          child: TextFormField(
                            controller: controller.dataNascimentoController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Data de Nascimento',
                            ),
                            readOnly: true,
                            onTap: () {
                              controller.selectDate(context);
                            },
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Sexo>(
                            value: controller.selectedSexo.value,
                            onChanged: (Sexo? newValue) {
                              controller.selectedSexo.value = newValue;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Sexo',
                            ),
                            items: Sexo.values.map((sexo) {
                              return DropdownMenuItem<Sexo>(
                                value: sexo,
                                child: Text(
                                    sexo == Sexo.homem ? 'Homem' : 'Mulher'),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.especialidadeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Especialidade',
                            ),
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.CPF_NIFController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'CPF/NIF',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidthRow2,
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xff000000), width: 2.0),
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Cancelar",
                        style: TextStyle(color: Color(0xff000000))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      controller.printFormData();
                      controller.createAvaliador();
                      Get.back();
                    },

                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Color(0xff17120f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Cadastrar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
