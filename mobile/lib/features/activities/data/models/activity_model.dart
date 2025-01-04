// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/architecture/data/model.dart';
import 'package:moti/features/activities/data/models/amount_model.dart';

class ActivityModel extends Model {
  const ActivityModel({
    required this.name,
    required this.date,
    required this.amount,
    required this.motiPoints,
  });

  factory ActivityModel.fromJson(Map<dynamic, dynamic> json) {
    return ActivityModel(
      name: json['name'] != null ? json['name'] as String : null,
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] as int)
          : null,
      amount: json['amount'] != null
          ? AmountModel.fromJson(json['amount'] as Map<dynamic, dynamic>)
          : null,
      motiPoints:
          json['motiPoints'] != null ? json['motiPoints'] as double : null,
    );
  }

  final String? name;
  final DateTime? date;
  final AmountModel? amount;
  final double? motiPoints;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'amount': amount?.toJson(),
      'motiPoints': motiPoints,
    };
  }
}
