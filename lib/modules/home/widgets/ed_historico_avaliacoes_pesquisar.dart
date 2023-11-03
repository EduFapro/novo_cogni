import 'package:flutter/cupertino.dart';

import '../../widgets/ed_input_text.dart';

class EdHistoricoAvaliacoesPesquisar extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  const EdHistoricoAvaliacoesPesquisar({
    super.key,
    required this.placeholder,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            placeholder: placeholder,
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }
}

