import '../../../core/exceptions/service_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../repositories/pessoa/person_repository.dart';
import '../person/person_service.dart';
import 'person_register_service.dart';

class PersonRegisterServiceImpl implements PersonRegisterService {
  final PersonRepository personRepository;
  final PersonService personService;
  PersonRegisterServiceImpl({
    required this.personRepository,
    required this.personService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) personData) async {
    final registerResult = await personRepository.registerAdmin(personData);

    switch (registerResult) {
      case Success():
        return personService.execute(personData.email, personData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
