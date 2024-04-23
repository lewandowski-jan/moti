sealed class AppError implements Error {
  AppError._(this.message, [this.exception, StackTrace? stackTrace])
      : stackTrace = stackTrace ?? StackTrace.current;

  factory AppError.network(Object exception) =>
      AppErrorNetwork(exception: exception);

  factory AppError.unexpected(Object exception) => 
      AppErrorUnexpected(exception: exception);

  final String message;
  final Object? exception;

  @override
  late final StackTrace stackTrace;

  @override
  String toString() => '$message${exception != null ? '\n$exception' : ''}';
}

class AppErrorNetwork extends AppError {
  AppErrorNetwork({required Object exception})
      : super._('Network error', exception);
}

class AppErrorUnexpected extends AppError {
  AppErrorUnexpected({required Object exception})
      : super._('Unexpected error', exception);
}
