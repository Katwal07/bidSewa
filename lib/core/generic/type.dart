sealed class Result<S>{
  const Result();
}

class Success<S> extends Result<S>{
  final S value;

  Success({required this.value});
}

class Failure<S> extends Result<S>{
  final Exception exception;

  Failure({required this.exception});
}