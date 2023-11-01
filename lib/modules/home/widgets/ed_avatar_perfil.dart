import 'package:flutter/material.dart';

class EdAvatarPerfil extends StatelessWidget {
  const EdAvatarPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 50.0,
            child: Image.asset('assets/profile-placeholder.png',
                width: 300, height: 300),
          ),
          Text(
            "Nome Fulano",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Especialidade Fulano",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
