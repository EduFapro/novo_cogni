import 'package:flutter/material.dart';
import '../../../../utils/enums/idioma_enums.dart';
import '../../../../utils/enums/pessoa_enums.dart';
import '../../../controllers/cadastro_participante_controller.dart';

class FormularioParticipante extends StatefulWidget {
  final CadastroParticipanteController controller;

  FormularioParticipante({required this.controller});

  @override
  State<FormularioParticipante> createState() => _FormularioParticipanteState();
}

class _FormularioParticipanteState extends State<FormularioParticipante> {
  Map<String, bool> items = {
    'Item 1': false,
    'Item 2': false,
    'Item 3': false,
    'Item 4': false,
  };

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.8;
    const double spacingWidth = 16.0;
    double adjustedFormWidth = formWidth - spacingWidth;
    double adjustedFormWidthRow2 = formWidth - 2 * spacingWidth;

    double fieldWidthRow1 = adjustedFormWidth / 2;
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.dataNascimentoController.text =
                                    pickedDate
                                        .toLocal()
                                        .toString()
                                        .split(' ')[0];
                                controller.selectedDate.value =
                                    pickedDate; // Update the selectedDate value
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Sexo>(
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
                            onChanged: (Sexo? value) {
                              controller.selectedSexo.value = value;
                            },
                            value: controller.selectedSexo.value,
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Escolaridade>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Escolaridade',
                            ),
                            items: Escolaridade.values.map((escolaridade) {
                              return DropdownMenuItem<Escolaridade>(
                                value: escolaridade,
                                child: Text(describeEscolaridade(escolaridade)),
                              );
                            }).toList(),
                            onChanged: (Escolaridade? value) {
                              controller.selectedEscolaridade.value = value;
                            },
                            value: controller.selectedEscolaridade.value,
                          ),
                        ),
                        SizedBox(width: spacingWidth),
                        SizedBox(
                          width: fieldWidthRow2,
                          child: DropdownButtonFormField<Lateralidade>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffededed),
                              labelText: 'Lateralidade',
                            ),
                            items: Lateralidade.values.map((lateralidade) {
                              return DropdownMenuItem<Lateralidade>(
                                value: lateralidade,
                                child: Text(describeLateralidade(lateralidade)),
                              );
                            }).toList(),
                            onChanged: (Lateralidade? value) {
                              controller.selectedLateralidade.value = value;
                            },
                            value: controller.selectedLateralidade.value,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Atividades',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // SizedBox(width: spacingWidth),
                      // SizedBox(
                      //   width: fieldWidthRow1,
                      //   child: TextFormField(
                      //     controller: controller.dataAvaliacaoController,
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: Color(0xffededed),
                      //       labelText: 'Data da Avaliação',
                      //     ),
                      //     readOnly: true,
                      //     onTap: () async {
                      //       DateTime? pickedDate = await showDatePicker(
                      //         context: context,
                      //         initialDate: DateTime.now(),
                      //         firstDate: DateTime(1900),
                      //         lastDate: DateTime.now(),
                      //       );
                      //       if (pickedDate != null) {
                      //         controller.dataAvaliacaoController.text =
                      //             pickedDate.toLocal().toString().split(' ')[0];
                      //       }
                      //     },
                      //   ),
                      // ),
                      SizedBox(width: spacingWidth),
                      SizedBox(
                        width: fieldWidthRow1,
                        child: DropdownButtonFormField<Idioma>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffededed),
                            labelText: 'Idioma',
                          ),
                          items: Idioma.values.map((idioma) {
                            return DropdownMenuItem<Idioma>(
                              value: idioma,
                              child: Text(idioma == Idioma.portugues
                                  ? 'Português'
                                  : 'Espanhol'),
                            );
                          }).toList(),
                          onChanged: (Idioma? value) {
                            controller.selectedIdioma.value = value;
                          },
                          value: controller.selectedIdioma.value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: EdgeInsets.only(left: spacingWidth),
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Selecione as atividades",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...items.keys.map((String key) {
                            return CheckboxListTile(
                              title: Text(key),
                              value: items[key],
                              onChanged: (bool? value) {
                                setState(() {
                                  items[key] = value!;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Handle cancel button press
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
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      controller.printFormData();
                      controller.createParticipante();
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

  String describeEscolaridade(Escolaridade escolaridade) {
    switch (escolaridade) {
      case Escolaridade.fundamental_incompleto:
        return 'Fundamental Incompleto';
      case Escolaridade.fundamental_completo:
        return 'Fundamental Completo';
      case Escolaridade.medio_incompleto:
        return 'Medio Incompleto';
      case Escolaridade.medio_completo:
        return 'Medio Completo';
      case Escolaridade.superior_incompleto:
        return 'Superior Incompleto';
      case Escolaridade.superior_completo:
        return 'Superior Completo';
      default:
        return 'Unknown';
    }
  }

  String describeLateralidade(Lateralidade lateralidade) {
    switch (lateralidade) {
      case Lateralidade.canhoto:
        return 'Canhoto';
      case Lateralidade.destro:
        return 'Destro';
      case Lateralidade.ambidestro:
        return 'Ambidestro';
      default:
        return 'Unknown';
    }
  }
}
