sealed class ApiResult<T> {

  bool get hasData => this is SuccessApiResult;
  bool get hasError => this is ErrorApiResult;
  AppErrors get getError => (this as ErrorApiResult).errors;
  T get getData => (this as SuccessApiResult).data;
  bool get isLoading => this is LoadingApiResult;

}


class SuccessApiResult<T> extends ApiResult<T> {
 T? data ;
 SuccessApiResult(this.data);
}
class LoadingApiResult<T> extends ApiResult<T> {}
class ErrorApiResult<T> extends ApiResult<T> {
  AppErrors errors ;
  ErrorApiResult(this.errors);
}
class InitialApiResult<T> extends ApiResult<T> {}


class AppErrors{
  String message ;
  AppErrors(this.message);
}

class NetworkError extends AppErrors{
  NetworkError(super.message);

}

class ServerError extends AppErrors{
  ServerError(super.message);
}

class IgnoredError extends AppErrors{
  IgnoredError(super.message);
}

class UnKnownError extends AppErrors{
  UnKnownError(super.message);
}

