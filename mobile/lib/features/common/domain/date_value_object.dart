import 'dart:math';

import 'package:collection/collection.dart';
import 'package:moti/architecture/domain/value_object.dart';

class DateValueObject extends ValueObject<DateTime>
    implements Comparable<DateValueObject> {
  DateValueObject(super.value);

  DateValueObject.invalid() : super.invalid();

  factory DateValueObject.today() => DateValueObject(DateTime.now());

  bool get isToday => this == DateValueObject.today();

  @override
  DateTime getOr(DateTime fallback) {
    final result = getOrNull ?? fallback;
    return DateTime(result.day, result.month, result.year);
  }

  @override
  DateTime? validate(DateTime? value) {
    if (value == null) {
      return null;
    }

    return DateTime(value.year, value.month, value.day);
  }

  @override
  int compareTo(DateValueObject other) {
    if (getOrNull == null) {
      return -1;
    }

    if (other.getOrNull == null) {
      return 1;
    }

    return getOrNull!.compareTo(other.getOrNull!);
  }

  bool isAfter(DateValueObject other) {
    final date = getOrNull;
    if (date == null) {
      return false;
    }

    final otherDate = other.getOrNull;
    if (otherDate == null) {
      return false;
    }

    return date.isAfter(otherDate);
  }

  DateValueObject operator -(Duration duration) {
    final date = getOrNull;
    if (date == null) {
      return DateValueObject.invalid();
    }

    return DateValueObject(date.subtract(duration));
  }
}

extension IterableDateValueObjectX on Iterable<DateValueObject> {
  int get currentStreak {
    if (every((e) => !e.valid || isEmpty)) {
      return 0;
    }

    final dates = where((e) => e.valid)
        .map((e) => e.getOrNull!)
        .toSet()
        .sorted((a, b) => b.compareTo(a));

    final today = DateValueObject.today().getOrNull!;
    final firstDateDifference = today.difference(dates.first).inDays;
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
        .map((e) => e.getOrNull!)
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
