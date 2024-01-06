import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:novo_cogni/constants/translation/ui_strings.dart';
import '../../../constants/enums/person_enums.dart';
import '../evaluators_controller.dart';
import '../../widgets/ed_input_text.dart';
import 'ed_new_evaluator_button.dart';

class EdEvaluatorsList extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  EdEvaluatorsList({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EvaluatorsController controller = Get.find<EvaluatorsController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            UiStrings.evaluatorsList,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          EdInputText(
            placeholder: placeholder,
            obscureText: obscureText,
          ),
          Expanded(
            child: Obx(() {
              var evaluatorsList = controller.evaluatorsList;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16,
                  columns: [
                    DataColumn(label: Text(UiStrings.name)),
                    DataColumn(label: Text(UiStrings.email)),
                    DataColumn(label: Text(UiStrings.dateOfBirth)),
                    DataColumn(label: Text(UiStrings.sex)),
                  ],
                  rows: evaluatorsList.map((evaluator) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${evaluator.name} ${evaluator.surname}')),
                        DataCell(Text(evaluator.email)),
                        DataCell(Text(DateFormat('dd/MM/yyyy').format(evaluator.birthDate))),
                        DataCell(Text(evaluator.sex == Sex.male ? 'Male' : 'Female')),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ),
          SizedBox(
            width: 900,
            child: EdNewEvaluatorButton(),
          ),
        ],
      ),
    );
  }
}
