
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/auth/domain/usecase/register_usecase.dart';
import 'package:project_movie_app/features_tmp/network/model/request/register_request/register_request.dart';
import 'package:project_movie_app/features_tmp/auth/ui/register/cubit/register_state.dart';


@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(RegisterState.initial());

  Future<void> register(RegisterRequest request) async {
    emit(RegisterState(registerApi: LoadingApiResult()));
    ApiResult<void> response = await _registerUseCase(request);
    emit(RegisterState(registerApi: response));
  }
}
