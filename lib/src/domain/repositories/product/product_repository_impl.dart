import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/exceptions/auth_exception.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';
import '../../../core/restClient/rest_client.dart';
import '../../entities/product_model.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RestClientApp restClient;
  ProductRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
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
  Future<Either<RepositoryException, ProductModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(ProductModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(({String email, String name, String password}) productData) async {
    try {
      await restClient.auth.post('/Products', data: {
        'email': productData.email,
        'name': productData.name,
        'password': productData.password,
        'profile': 'ADM',
      });
      return Success(Nil());
    } on Exception catch (e, s) {
      log('Erro ao cadastrar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao cadastrar usuário admin'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ProductModel>>> getEmployees(int barbershopId) async {
    try {
      final Response(:List data) = await restClient.auth.get('/Products', queryParameters: {'barbershop_id': barbershopId});

      final employees = data.map((e) => ProductModel.fromMap(e)).toList();
      return Success(employees);
    } on Exception catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid json)', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar colaboradores'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(({List<int> workHours, List<String> workdays}) productModel) async {
    try {
      final productModelResult = await me();

      final int productId;

      switch (productModelResult) {
        case Success(value: ProductModel(:var id)):
          productId = id;
        case Failure(:var exception):
          return Failure(exception);
      }
      await restClient.auth.put('/Products/$productId', data: {
        'work_days': productModel.workdays,
        'work_hours': productModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir administrador como colaborador', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao inserir administrador como colaborador'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(
    ({
      int barbershopId,
      String email,
      String name,
      String password,
      List<String> workdays,
      List<int> workHours,
    }) productModel,
  ) async {
    try {
      await restClient.auth.post(
        '/Products',
        data: {
          'barbershop_id': productModel.barbershopId,
          'name': productModel.name,
          'email': productModel.email,
          'password': productModel.password,
          'profile': 'EMPLOYEE',
          'work_days': productModel.workdays,
          'work_hours': productModel.workHours,
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
