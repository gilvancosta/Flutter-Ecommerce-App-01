
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
//import 'package:dio/io.dart';

import 'interceptors/auth_interceptor.dart';

final class RestClientApp extends DioForNative {
  RestClientApp()
      : super(BaseOptions(
          baseUrl: 'http://10.0.0.112:8080',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
        )) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),  
      AuthInterceptor(),
    ]);
  }

  RestClientApp get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClientApp get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
