import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/form_helper.dart';

class MyTextFormFieldEmail extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const MyTextFormFieldEmail({
    Key? key,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: Validatorless.multiple([
        Validatorless.required('E-mail obrigatório'),
        Validatorless.email('E-mail inválido'),
      ]),
      focusNode: focusNode,
      //Esconde o teclado ao clicar fora do campo
      onTapOutside: (_) => context.unfocus(),
      decoration: const InputDecoration(
        label: Text('E-mail'),
        hintText: 'Digite seu login',
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      keyboardType: TextInputType.emailAddress,
      // obscureText: true,
    );
  }
}
