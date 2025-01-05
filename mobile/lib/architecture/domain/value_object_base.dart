import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moti/architecture/domain/validable.dart';

abstract class ValueObjectBase<T extends Object> extends Equatable
    implements IValidable {
  @protected
  late final T? value;

  @override
  bool get valid => value != null;

  T getOr(T fallback) => value ?? fallback;

  T? get getOrNull => value;

  @override
  List<dynamic> get props => [value];
}
