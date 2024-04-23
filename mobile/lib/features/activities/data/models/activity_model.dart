// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/architecture/data/model.dart';
import 'package:moti/features/activities/data/models/amount_model.dart';

class ActivityModel extends Model {
  const ActivityModel({
    this.name,
    this.date,
    this.amount,
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
    );
  }

  final String? name;
  final DateTime? date;
  final AmountModel? amount;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'amount': amount?.toJson(),
    };
  }
}
