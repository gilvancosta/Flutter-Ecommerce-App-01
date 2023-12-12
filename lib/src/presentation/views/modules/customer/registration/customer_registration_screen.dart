import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/helpers/form_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/avatar_widget.dart';

class CustomerRegistrationScreen extends ConsumerStatefulWidget {
  const CustomerRegistrationScreen({super.key});

  @override
  ConsumerState<CustomerRegistrationScreen> createState() =>
      CustomerRegistrationScreenState();
}

class CustomerRegistrationScreenState
    extends ConsumerState<CustomerRegistrationScreen> {
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
    //  final userModelAsync = ref.watc(getMeProvider);
    final appRouter = ref.watch(appRouterProvider);

    // final userRegisterVm1 = ref.watch(userRegisterVmProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // desabilita o botão de voltar
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userLoginServiceProvider).logout();
              appRouter.pushReplacement('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Atacadão Eletrônicos', style: TextStyle(fontSize: 12)),
            Text('Cadastro de Cliente', style: TextStyle(fontSize: 16))
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
                // ========== copia =====================
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
// ========== copia =====================

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

// ========== copia =====================

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

// ========== copia =====================

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Enviar Cadastro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
