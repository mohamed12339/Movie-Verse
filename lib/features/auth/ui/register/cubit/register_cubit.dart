import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_movie_app/features/auth/ui/register/cubit/register_state.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../network/model/request/register_request/register_request.dart';
import '../../../domain/usecase/register_usecase.dart';

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
