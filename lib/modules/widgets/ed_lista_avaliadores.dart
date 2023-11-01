import 'package:flutter/cupertino.dart';
import 'ed_input_text.dart';
import 'ed_novo_avaliador_button.dart';
import 'ed_table_list.dart';

class EdListaAvaliadores extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  const EdListaAvaliadores({
    super.key,
    required this.placeholder,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Lista de Avaliadores",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          EdInputText(
            placeholder: placeholder,
            obscureText: obscureText,
          ),
          Expanded(
            child: EdTableList(),
          ),
          SizedBox(
            width: 900,
            child: EdNovoAvaliadorButton(),
          ),
        ],
      ),
    );
  }
}
