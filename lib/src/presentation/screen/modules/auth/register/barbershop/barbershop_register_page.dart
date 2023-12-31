import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_01/src/core/helpers/form_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../../core/helpers/messages.dart';
import '../../../../../../core/widgets/hours_panel.dart';
import '../../../../../../core/widgets/weekdays_panel.dart';
import 'barbershop_register_state.dart';
import 'barbershop_register_vm.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVM = ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.inital:
          break;
        case BarbershopRegisterStateStatus.error:
         Messages.showError('Desculpe ocorreu um erro ao registrar barbearia', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(label: Text('Nome')),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(label: Text('E-mail')),
                ),
                const SizedBox(height: 5.0),
                WeekdaysPanel(onDayPressed: (weekDay) {
                  barbershopRegisterVM.addOrRemoveOpenDay(weekDay);
                }),
                const SizedBox(height: 24.0),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (hour) {
                    barbershopRegisterVM.addOrRemoveOpenHour(hour);
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        barbershopRegisterVM.register(nameEC.text, emailEC.text);
                    }
                  },
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
