import 'package:equatable/equatable.dart';

enum Environment { dev, tst, prod }

class AppConfiguration extends Equatable {
  const AppConfiguration({required this.environment});

  final Environment environment;

  @override
  List<Object?> get props => [environment];
}
