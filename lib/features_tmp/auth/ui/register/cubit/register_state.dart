import 'package:project_movie_app/core/api_result/api_result.dart';

class RegisterState {
  late ApiResult<void> registerApi;

  RegisterState.initial() {
    registerApi = InitialApiResult();
  }
  RegisterState({required this.registerApi});
}
