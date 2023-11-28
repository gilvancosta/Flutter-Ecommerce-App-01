import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../theme/app_icons.dart';

class MyTextFormFieldPassword extends StatelessWidget {
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  MyTextFormFieldPassword({
    Key? key,
    this.obscureText = true,
    this.controller,
    this.validator,
    this.focusNode,
  })  : obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: Validatorless.multiple([
            Validatorless.required('Senha obrigatória'),
            Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
          ]),
          focusNode: focusNode,
          decoration: InputDecoration(
            label: const Text('Senha'),
            hintText: 'Digite sua senha',
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                !obscureTextValue ? AppIcons.eye_slash : AppIcons.eye,
                size: 15,
              ),
              onPressed: () {
                obscureTextVN.value = !obscureTextValue;
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
