import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novo_cogni/modules/widgets/ed_form_title.dart';
import '../../mixins/ValidationMixin.dart';
import '../../routes.dart';
import '../widgets/ed_input_text.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> with ValidationMixin {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
            child: Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
                child: Form(
                  key: formKey,
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormTitle(title: 'Login'),
                          const SizedBox(height: 10.0),
                          EdInputText(
                            placeholder: "Email",
                            validator: validateEmail,
                            onSaved: (value) => email = value ?? '',
                          ),
                          const SizedBox(height: 10.0),
                          EdInputText(
                            placeholder: "Senha",
                            obscureText: true,
                            validator: validatePassword,
                            onSaved: (value) => password = value ?? '',
                          ),
                          const SizedBox(height: 20.0),
                          const EdEndText(text: "Esqueceu sua senha?"),
                          const SizedBox(height: 20.0),

                          // Display login error
                          Obx(() {
                            if (controller.loginError.value.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  controller.loginError.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox
                                  .shrink(); // Return an empty widget if there's no error
                            }
                          }),

                          TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                print("Email: $email, Password: $password");
                                var successfulAdminLogin =
                                    await controller.logAdmin(email, password);
                                if (successfulAdminLogin) {
                                  print("hohohoho");
                                  Get.toNamed(AppRoutes.home);
                                } else {
                                  var successfulLogin =
                                  await controller.login(email, password);
                                  if (successfulLogin) {
                                    if ((controller
                                        .currentAvaliadorFirstLogin.value == false)) {
                                      print(controller
                                          .currentAvaliadorFirstLogin.value);
                                      Get.toNamed(AppRoutes.home);
                                    } else {
                                      Get.toNamed(
                                        AppRoutes.novaSenha,
                                        arguments: {
                                          'firstLogin': controller
                                              .currentAvaliadorFirstLogin.value,
                                          'avaliadorID': controller
                                              .currentAvaliadorID.value,
                                        },
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(20),
                              textStyle: const TextStyle(fontSize: 16),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Entrar"),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF161E2E),
    );
  }
}

class EdEndText extends StatelessWidget {
  final String text;

  const EdEndText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
