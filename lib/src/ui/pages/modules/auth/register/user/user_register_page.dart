// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/ui/helpers/form_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../../core/ui/helpers/messages.dart';
import 'user_register_vm.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
          break;
        case UserRegisterStateStatus.error:
          Messages.showError('Erro ao realizar cadastro',context);

          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // desabilita o botão de voltar
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: ClipOval(
            child: Container(
              //  color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                // color: context.primaryColor,
              ),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Atacadão Eletrônicos', style: TextStyle(fontSize: 12)),
            Text('Criar Nova Conta', style: TextStyle(fontSize: 16))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatória'),
                    Validatorless.min(
                        6, 'Senha deve conter no mínimo 6 caracteres'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar senha é obrigatório'),
                    // Validatorless.min(6, 'Senha deve conter no mínimo 6 caracteres'),
                    Validatorless.compare(
                        passwordEC, 'As senhas diferente de confirmar senha'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        userRegisterVm.register(
                          name: nameEC.text,
                          email: emailEC.text,
                          password: passwordEC.text,
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
