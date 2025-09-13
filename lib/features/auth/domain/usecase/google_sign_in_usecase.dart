import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class GoogleSignInUseCase {
  final AuthRepository _repo;
  GoogleSignInUseCase(this._repo);

  Future<ApiResult<void>> call() {
    return _repo.signInWithGoogle();
  }
}
