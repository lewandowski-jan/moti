import 'package:equatable/equatable.dart';
import 'package:moti/architecture/domain/validable.dart';

abstract class Entity extends Equatable implements IValidable {
  const Entity();

  @override
  bool get valid => props.every((element) => element.valid);

  @override
  List<IValidable> get props;
}

abstract class EntityList<T extends Entity> extends Equatable {
  const EntityList(this.entities);

  final List<T> entities;

  bool get valid =>
      entities.isNotEmpty && entities.every((element) => element.valid);

  @override
  List<T> get props => entities;
}
