import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../../data/restClient/rest_client.dart';

import '../../models/user_model.dart';
import 'person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final RestClientApp restClient;
  PersonRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));


      
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) personData) async {
    try {
      await restClient.auth.post('/Persons', data: {
        'email': personData.email,
        'name': personData.name,
        'password': personData.password,
        'profile': 'ADM',
      });
      return Success(Nil());
    } on Exception catch (e, s) {
      log('Erro ao cadastrar usuário', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao cadastrar usuário admin'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getCustomers(
      int barbershopId) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/Persons', queryParameters: {'barbershop_id': barbershopId});

      final customers = data.map((e) => UserModel.fromMap(e)).toList();
      return Success(customers);
    } on Exception catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid json)',
          error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar colaboradores'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsCustomer(
      ({List<int> workHours, List<String> workdays}) personModel) async {
    try {
      final personModelResult = await me();

      final int personId;

      switch (personModelResult) {
        case Success(value: UserModel(:var id)):
          personId = id;
        case Failure(:var exception):
          return Failure(exception);
      }
      await restClient.auth.put('/Persons/$personId', data: {
        'work_days': personModel.workdays,
        'work_hours': personModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir administrador como colaborador',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerCustomer(
    ({
      int barbershopId,
      String email,
      String name,
      String password,
      List<String> workdays,
      List<int> workHours,
    }) personModel,
  ) async {
    try {
      await restClient.auth.post(
        '/Persons',
        data: {
          'barbershop_id': personModel.barbershopId,
          'name': personModel.name,
          'email': personModel.email,
          'password': personModel.password,
          'profile': 'CUSTOMER',
          'work_days': personModel.workdays,
          'work_hours': personModel.workHours,
        },
      );

      return Success(nil);
    } on DioException catch (e, s) {
      log(
        'Erro ao inserir administrador como colaborador',
        error: e,
        stackTrace: s,
      );
      return Failure(
        RepositoryException(
          message: 'Erro ao inserir administrador como colaborador',
        ),
      );
    }
  }
}
