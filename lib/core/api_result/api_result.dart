sealed class ApiResult<T> {
  bool get hasData => this is SuccessApiResult;
  bool get hasError => this is ErrorApiResult;
  bool get isLoading => this is LoadingApiResult;

  AppErrors get myError => (this as ErrorApiResult).error;
  T get myData => (this as SuccessApiResult).data;
}

class SuccessApiResult<T> extends ApiResult<T> {
  T? data;
  SuccessApiResult(this.data);
}

class LoadingApiResult<T> extends ApiResult<T> {}

class ErrorApiResult<T> extends ApiResult<T> {
  AppErrors error;

  ErrorApiResult(this.error);
}

class InitialApiResult<T> extends ApiResult<T> {}

////////////////////////////////
///////////////////////////////

class AppErrors {
  String message;
  AppErrors(this.message);
}

class NetworkError extends AppErrors {
  NetworkError(super.message);
}

class ServerError extends AppErrors {
  ServerError(super.message);
}

class IgnoredError extends AppErrors {
  IgnoredError(super.message);
}

class UnKnownError extends AppErrors {
  UnKnownError(super.message);
}
