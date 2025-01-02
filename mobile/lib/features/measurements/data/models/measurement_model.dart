import 'package:moti/architecture/data/model.dart';
import 'package:moti/features/measurements/domain/measurement_unit_value_object.dart';

class MeasurementModel extends Model {
  MeasurementModel({
    required this.unit,
    required this.amount,
    required this.timestamp,
  });

  factory MeasurementModel.fromJson(Map<dynamic, dynamic>? json) {
    return MeasurementModel(
      unit: json?['unit'] != null
          ? MeasurementUnit.fromString(json!['unit'])
          : null,
      amount: json?['amount'] is double ? json!['amount'] as double : null,
      timestamp: json?['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json?['timestamp'] as int)
          : null,
    );
  }

  final MeasurementUnit? unit;
  final double? amount;
  final DateTime? timestamp;

  @override
  Map<String, dynamic> toJson() {
    return {
      'unit': unit?.toString(),
      'amount': amount,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }
}
