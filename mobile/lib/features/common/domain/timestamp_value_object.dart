import 'dart:math';

import 'package:collection/collection.dart';
import 'package:moti/architecture/domain/value_object.dart';
import 'package:moti/features/common/domain/date_value_object.dart';

class TimestampValueObject extends ValueObject<DateTime>
    implements Comparable<TimestampValueObject> {
  TimestampValueObject(super.value);

  TimestampValueObject.invalid() : super.invalid();

  factory TimestampValueObject.now() => TimestampValueObject(DateTime.now());

  bool get isToday => date.isToday;

  DateValueObject get date => DateValueObject(value);

  @override
  DateTime? validate(DateTime? value) {
    if (value == null) {
      return null;
    }

    return value;
  }

  @override
  int compareTo(TimestampValueObject other) {
    if (value == null) {
      return -1;
    }

    if (other.value == null) {
      return 1;
    }

    return value!.compareTo(other.value!);
  }

  bool isAfter(TimestampValueObject other) {
    final date = value;
    if (date == null) {
      return false;
    }

    final otherDate = other.value;
    if (otherDate == null) {
      return false;
    }

    return date.isAfter(otherDate);
  }

  TimestampValueObject operator -(Duration duration) {
    final date = value;
    if (date == null) {
      return TimestampValueObject.invalid();
    }

    return TimestampValueObject(date.subtract(duration));
  }
}

extension IterableDateTimeValueObjectX on Iterable<TimestampValueObject> {
  int get currentStreak {
    if (every((e) => !e.valid || isEmpty)) {
      return 0;
    }

    final dates = where((e) => e.valid)
        .map((e) => e.value!)
        .toSet()
        .sorted((a, b) => b.compareTo(a));

    final now = TimestampValueObject.now().value!;
    final firstDateDifference = now.difference(dates.first).inDays;
    if (firstDateDifference > 1) {
      return 0;
    }

    var streak = 0;
    for (var i = 0; i < dates.length; i++) {
      streak++;

      final date = dates[i];
      final nextDate = i + 1 < dates.length ? dates[i + 1] : null;

      if (nextDate != null) {
        final difference = date.difference(nextDate).inDays;

        if (difference != 1) {
          break;
        }
      }
    }

    return streak;
  }

  int get longestStreak {
    if (every((e) => !e.valid || isEmpty)) {
      return 0;
    }

    var longestStreak = 0;
    var currentStreak = 0;

    final dates = where((e) => e.valid)
        .map((e) => e.value!)
        .toSet()
        .sorted((a, b) => b.compareTo(a));

    for (var i = 0; i < dates.length; i++) {
      currentStreak++;

      final date = dates[i];
      final nextDate = i + 1 < dates.length ? dates[i + 1] : null;

      if (nextDate != null) {
        final difference = date.difference(nextDate).inDays;

        if (difference != 1) {
          longestStreak = max(longestStreak, currentStreak);
          currentStreak = 0;
        }
      }
    }

    if (currentStreak > longestStreak) {
      return currentStreak;
    }

    return longestStreak;
  }
}
