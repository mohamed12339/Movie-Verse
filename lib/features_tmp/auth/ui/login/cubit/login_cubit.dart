import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:project_movie_app/features_tmp/auth/domain/usecase/login_usecase.dart';
import 'package:project_movie_app/features_tmp/auth/ui/login/cubit/login_state.dart';
import 'package:project_movie_app/features_tmp/network/model/request/login_request/login_request.dart';



@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  LoginCubit(this._loginUseCase, this._googleSignInUseCase)
    : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    var request = LoginRequest(email: email, password: password);
    emit(LoginState(loginApi: LoadingApiResult()));
    ApiResult<void> response = await _loginUseCase(request);
    emit(LoginState(loginApi: response));
  }

  Future<void> loginWithGoogle() async {
    emit(LoginState(loginApi: LoadingApiResult()));
    final res = await _googleSignInUseCase();
    emit(LoginState(loginApi: res));
  }
}
