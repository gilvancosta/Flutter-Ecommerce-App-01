import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/ui/helpers/form_helper.dart';

class My_TextFormField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  My_TextFormField({
    Key? key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(
          obscureText == true ? suffixIconButton == null : true,
          'ObscureText não pode ser enviado em conjunto com suffixIconButtom',
        ),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          //Esconde o teclado ao clicar fora do campo
          onTapOutside: (_) => context.unfocus(),   

          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(
                          !obscureTextValue ? AppIcons.eye_slash : AppIcons.eye,
                          size: 15,
                        ),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}