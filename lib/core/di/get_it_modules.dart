import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GetItModule {
  Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(requestBody: true));

    return dio;
  }
}
