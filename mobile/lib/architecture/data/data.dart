import 'package:moti/architecture/data/error.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef SuccessDataMapper<T, R> = R Function(T data);
typedef ErrorDataMapper<T> = T Function(AppError error);

class Data<T> {
  const Data._({
    T? data,
    AppError? error,
  })  : _error = error,
        _data = data;

  factory Data.success(T data) => Data._(data: data);

  factory Data.error(AppError error) => Data._(error: error);

  final T? _data;
  final AppError? _error;

  R map<R>({
    required SuccessDataMapper<T, R> success,
    required ErrorDataMapper<R> error,
  }) {
    if (_data != null && _error == null) {
      return success(_data);
    }

    return error(
      _error ??
          AppError.unexpected(ArgumentError('Data and error are null')),
    );
  }
}
