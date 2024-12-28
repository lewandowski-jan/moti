import 'package:equatable/equatable.dart';

abstract interface class IValidable with EquatableMixin {
  bool get valid;
}
