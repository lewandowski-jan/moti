import 'package:moti/architecture/data/error.dart';

typedef Json = Map<String, dynamic>;
typedef SuccessMapper<T> = T Function(Json data);
typedef ErrorMapper<T> = T Function(AppError error);

class Response {
  const Response._({
    Json? json,
    AppError? error,
  })  : _json = json,
        _error = error;

  factory Response.success(Json json) => Response._(json: json);

  factory Response.error(AppError error) => Response._(error: error);

  final Json? _json;
  final AppError? _error;

  T map<T>({
    required SuccessMapper<T> success,
    required ErrorMapper<T> error,
  }) {
    if (_json != null && _error == null) {
      return success(_json);
    }

    return error(
      _error ?? AppError.unexpected(ArgumentError('Json and error are null')),
    );
  }
}
