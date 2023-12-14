import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/helpers/messages.dart';
import '../../../../widgets/TextFormField/my_textformfield_email.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailEC = TextEditingController();
  final _emailFocus = FocusNode();
  // Método para enviar o link de redefinição de senha para o email digitado
  Future<void> passwordReset() async {
    try {
      // Método do Firebase para enviar o link no email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailEC.text);

      // Mostrar um diálogo de sucesso
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset link sent! Check your email'),
          );
        },
      );
    } catch (e) {
      // Tratar erros

      Messages.showError(
            e.toString(),
            context);

    }
  }

  @override
  void dispose() {
    emailEC.dispose();
  
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double firstContainer = (179 / 732) * screenHeight;
    final double voltarButtonWidth = (202 / 412) * screenWidth;
    final double voltarButtonHeight = (37 / 732) * screenHeight;
    final double enviarButtonWidth = (74 / 412) * screenWidth;
    final double enviarButtonHeight = (30 / 732) * screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: firstContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        ImageConstants.serpentinae,
                      ),
                      const Text('festou\ncadastro'),
                      Image.asset(
                        ImageConstants.serpentinad,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [

                        // -- Email --
                          MyTextFormFieldEmail(
                            controller: emailEC,
                            focusNode: _emailFocus,
                          ),
                          const SizedBox(height: 20),

                      
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        controller: emailEC,
                        obscureText: false,
                      ),




                      const SizedBox(height: 20),
                      InkWell(
                        onTap: passwordReset,
                        child: Container(
                          alignment: Alignment.center,
                          width: enviarButtonWidth,
                          height: enviarButtonHeight,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 13, 46, 89),
                            borderRadius:
                                BorderRadius.circular(50), // Borda arredondada
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'enviar código',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),                      
                      
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          alignment: Alignment.center,
                          width: voltarButtonWidth,
                          height: voltarButtonHeight,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 13, 46, 89),
                            borderRadius:
                                BorderRadius.circular(10), // Borda arredondada
                          ),
                          child: const Text(
                            'VOLTAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
