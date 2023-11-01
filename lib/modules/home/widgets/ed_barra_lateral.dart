import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes.dart';
import 'ed_avatar_perfil.dart';
import 'ed_botao_quadrado.dart';
import 'ed_leading_button.dart';

class EdBarraLateral extends StatelessWidget {
  const EdBarraLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Text(
            "CogniVoice",
            style: GoogleFonts.notoSans(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30,),
          EdLeadingButton(
              icon: Icons.home,
              text: "Home",
              onPressed: () {
                Get.toNamed(AppRoutes.home,);

              },),
          EdLeadingButton(
            icon: Icons.person_3,
            text: "Avaliadores",
            onPressed: () {
              Get.toNamed(AppRoutes.avaliadores);

            },
          ),
          Spacer(),
          EdAvatarPerfil(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EdBotaoQuadrado(
                  icon: Icons.settings_rounded,
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  onTap: () {},
                ),
                SizedBox(width: 8.0),
                EdBotaoQuadrado(
                  icon: Icons.logout_rounded,
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  onTap: () {
                    // Routes.instance.pushAndRemoveUntil(
                    //     route: LoginScreen(), context: context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
