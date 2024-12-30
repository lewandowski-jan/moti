import 'package:equatable/equatable.dart';
import 'package:moti/architecture/domain/validable.dart';

abstract class ValueObjectBase<T extends Object> extends Equatable
    implements IValidable {
  late final T? value;

  @override
  bool get valid => value != null;

  T getOr(T fallback) => value ?? fallback;

  @override
  List<dynamic> get props => [value];
}
