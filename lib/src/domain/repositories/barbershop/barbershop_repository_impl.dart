import 'dart:developer';
import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/either.dart';
import '../../../core/fp/nil.dart';

import '../../../core/restClient/rest_client.dart';
import '../../entities/barbershop_model.dart';

import '../../entities/product_model.dart';

import 'barbershop_repository.dart';


class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClientApp restClient;
  BarbershopRepositoryImpl({
    required this.restClient,
  });


  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(ProductModel productModel) async {
    switch (productModel) {
      case ProductModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(BarbershopModel.fromMap(data));
      case ProductModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${productModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(({String email, String name, List<String> openingDays, List<int> openingHours}) data) async {
    try {
      await restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar barbearia', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar barbearia'));
    }
  }
}
