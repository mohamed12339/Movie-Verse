import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';

class RegisterState {
  late ApiResult<TokenResponse> registerApi;

  RegisterState.initial() {
    registerApi = InitialApiResult();
  }
  RegisterState({required this.registerApi});
}
