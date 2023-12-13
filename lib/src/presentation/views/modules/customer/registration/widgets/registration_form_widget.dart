// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/helpers/form_helper.dart';
import 'package:flutter_ecommerce_app_01/src/presentation/widgets/TextFormField/my_textformfield_general.dart';

import 'package:validatorless/validatorless.dart';

import '../../../../../../domain/models/customer_model.dart';

import '../../../../../widgets/TextFormField/my_textformfield_multiline.dart';
import '../../../../../widgets/TextFormField/my_textformfield_name.dart';
import 'user_image_widget.dart';

class RegistrationFormWidget extends StatefulWidget {
  final void Function(CustomerModel) onSubmit;

  const RegistrationFormWidget({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<RegistrationFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<RegistrationFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameEC = TextEditingController();
  final _cnpjCpfEC = TextEditingController();
  final _companyNameEC = TextEditingController();
  final _phoneEC = TextEditingController();

  final _cepEC = TextEditingController();
  final _addressEC = TextEditingController();
  final _baseStoreEC = TextEditingController();

  final _formData = CustomerModel();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    print('aqui 111');

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }
    print('aqui 222');
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              UserImageWidget(
                onImagePick: _handleImagePick,
              ),

              // -Nome Completo --
              MyTextFormFieldName(
                  fieldLabel: 'Nome Completo',
                  controller: _fullNameEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),

              // -CPF/CNPJ --
              MyTextFormFieldName(
                  fieldLabel: 'CNPJ ou CPF',
                  controller: _cnpjCpfEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),

              // - Telefone --
              MyTextFormFieldName(
                  fieldLabel: 'Nome da Empresa',
                  controller: _companyNameEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),
              // -CEP --
              MyTextFormFieldName(
                  fieldLabel: 'Telefone Celular',
                  controller: _phoneEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),
              // -ENDEREÇO --
              MyTextFormFieldName(
                  fieldLabel: 'CEP',
                  controller: _cepEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),
              // -CIDADE --
              MyTextFormFieldMultiline(
                  fieldLabel: 'Endereço',
                  controller: _addressEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),

              const SizedBox(height: 5),
              // -ESTADO --

              MyTextFormFieldName(
                  fieldLabel: 'Loja base de compra',
                  controller: _baseStoreEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Nome obrigatório'),
                    Validatorless.email('Nome inválido'),
                  ])),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('ENVIAR CADASTRO PARA APROVAÇÃO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
