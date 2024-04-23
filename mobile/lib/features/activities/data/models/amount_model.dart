import 'package:moti/architecture/data/model.dart';

class AmountModel extends Model {
  const AmountModel({
    required this.type,
    required this.unit,
    required this.value,
  });

  factory AmountModel.fromJson(Map<dynamic, dynamic> json) {
    return AmountModel(
      type: json['type'] != null ? json['type'] as String : null,
      unit: json['unit'] != null ? json['unit'] as String : null,
      value: json['value'] != null ? json['value'] as double : null,
    );
  }

  final String? type;
  final String? unit;
  final double? value;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'unit': unit,
      'value': value,
    };
  }
}
