
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../core/providers/application_providers.dart';
import '../../../../../../domain/services/user_register_adm/user_register_adm_service.dart';
import '../../../../../../domain/services/user_register_adm/user_register_adm_service_impl.dart';

part 'user_register_providers.g.dart';

@riverpod
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) => UserRegisterAdmServiceImpl(
      
      userRegisterRepository: ref.watch(userRegisterRepositoryProvider),
      userRegisterService: ref.watch(userRegisterServiceProvider),
    );
