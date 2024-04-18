// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:moti/core/storable.dart';
import 'package:moti/features/activities/data/models/amount.dart';

class Activity implements IStorable {
  const Activity({
    this.name,
    this.date,
    this.amount,
  });

  factory Activity.fromJson(Map<dynamic, dynamic> json) {
    return Activity(
      name: json['name'] != null ? json['name'] as String : null,
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] as int)
          : null,
      amount: json['amount'] != null
          ? Amount.fromJson(json['amount'] as Map<dynamic, dynamic>)
          : null,
    );
  }

  final String? name;
  final DateTime? date;
  final Amount? amount;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'amount': amount?.toJson(),
    };
  }

  Activity copyWith({
    String? name,
    DateTime? date,
    Amount? amount,
  }) {
    return Activity(
      name: name ?? this.name,
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }
}
