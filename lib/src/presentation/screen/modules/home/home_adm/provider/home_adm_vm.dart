

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../core/fp/either.dart';
import '../../../../../../core/providers/application_providers.dart';
import '../../../../../../domain/models/barbershop_model.dart';
import '../../../../../../domain/models/user_model.dart';
import 'home_adm_state.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeADMVM extends _$HomeADMVM {
  @override
  Future<HomeADMState> build() async {
    final repository = ref.read(personRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.read(getMyBarbershopProvider.future);
    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getCustomers(barbershopId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];
        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }
        employees.addAll(employeesData);
        return HomeADMState(
          status: HomeADMStateStatus.loaded,
          employees: employees,
        );
      case Failure():
        return HomeADMState(
          status: HomeADMStateStatus.error,
          employees: [],
        );
    }
  }

  Future<void> logout() async => ref.watch(logoutProvider.future);
}
