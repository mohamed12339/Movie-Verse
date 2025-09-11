import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features/network/model/response/login_response/login_response.dart';
import 'package:project_movie_app/features/network/model/response/register_response/register_response.dart';
import 'package:project_movie_app/features/network/model/response/token_response/token_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/request/login_request/login_request.dart';
import '../model/request/register_request/register_request.dart';

part 'services.g.dart';

@RestApi(baseUrl: 'https://route-movie-apis.vercel.app/')
@injectable
abstract class Services {
  @factoryMethod
  factory Services(Dio dio) = _Services;

  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST('/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest registerRequest);
}
