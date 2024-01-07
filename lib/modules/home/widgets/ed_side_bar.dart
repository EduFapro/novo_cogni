import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/translation/ui_strings.dart';
import '../../../routes.dart';
import '../../widgets/ed_language_dropdown.dart';
import 'ed_main_sidebar_button.dart';
import 'ed_profile_avatar.dart';
import 'ed_square_button.dart';

class EdSidebar extends StatelessWidget {
  const EdSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            "CogniVoice",
            style: GoogleFonts.notoSans(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: EdMainSidebarButton(
            icon: Icons.home,
            text: UiStrings.home,
            onPressed: () {
              Get.toNamed(AppRoutes.home,);

            },),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: EdMainSidebarButton(
            icon: Icons.person_3,
            text: UiStrings.evaluators,
            onPressed: () {
              Get.toNamed(AppRoutes.evaluators);

            },
          ),
        ),
        Spacer(),
        EdProfileAvatar(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // EdSquareButton(
              //   icon: Icons.settings_rounded,
              //   backgroundColor: Colors.black,
              //   iconColor: Colors.white,
              //   onTap: () {},
              // ),
              SizedBox(width: 8.0),
              EdSquareButton(
                icon: Icons.logout_rounded,
                backgroundColor: Colors.black,
                iconColor: Colors.white,
                onTap: () {
                  Get.offAllNamed(AppRoutes.login);

                },
              ),
            ],
          ),
        ),
        EdLanguageDropdown(),],
    );
  }
}
