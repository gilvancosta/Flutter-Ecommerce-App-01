// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/application_providers.dart';
import '../../../../../core/router/app_router.dart';

import '../../../../../domain/models/customer_model.dart';
import 'widgets/registration_form_widget.dart';

class CustomerRegistrationScreen extends ConsumerStatefulWidget {
  const CustomerRegistrationScreen({super.key});

  @override
  ConsumerState<CustomerRegistrationScreen> createState() =>
      CustomerRegistrationScreenState();
}

class CustomerRegistrationScreenState
    extends ConsumerState<CustomerRegistrationScreen> {
  bool _isloading = false;
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

  Future<void> _handleSubmit(CustomerModel formData) async {}

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
            Text('Cadastro de Cliente', style: TextStyle(fontSize: 20))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: RegistrationFormWidget(onSubmit: _handleSubmit),
              ),
            ),
            if (_isloading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
