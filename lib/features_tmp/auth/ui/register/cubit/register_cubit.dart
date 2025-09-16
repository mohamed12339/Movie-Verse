import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/core/utility/app_preferences/token_storage.dart';
import 'package:project_movie_app/core/utility/app_preferences/user_storage.dart';
import 'package:project_movie_app/features_tmp/auth/domain/usecase/register_usecase.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/auth/ui/register/cubit/register_state.dart';
import 'package:project_movie_app/features_tmp/network/model/response/token_response/token_response.dart';



@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(RegisterState.initial());


  Future<void> register({required String confirmPassword, required String name, required String email, required String password,required String phone, required int avatarId,}) async {
    var request = RegisterRequest( /// اظريت اني اخزن الحاجة بايدي كان لازم اعمل كدا
      name: name,
      email: email,
      password: password,
      phone: phone,
      avaterId: avatarId,
      confirmPassword: confirmPassword,
    );
    emit(RegisterState(registerApi: LoadingApiResult()));
    var response = await _registerUseCase(request);

   /// هنا انا عملت كدا عشان مفيش api لل profile فا هضطر اخزن انا الحاجة بقا لما اعمل register
    if (response is SuccessApiResult<TokenResponse>) {
      final user = response.data?.data;
      final tokenResponse = response.data;
      if (user != null) {
        await UserStorage.saveUser(
          name: user.name,
          email: user.email,
          avatarId: user.avaterId,
        );
        await TokenStorage.saveToken(tokenResponse!.token);
      }
    }

    emit(RegisterState(registerApi: response));
  }

}