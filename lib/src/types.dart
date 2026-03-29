/// Represents a Tibetan year with its attributes
class Year {
  final int tibYear;
  final int westernYear;
  final int rabjungCycle;
  final int rabjungYear;
  final String? animal;
  final String? element;
  final String? gender;

  Year({
    required this.tibYear,
    required this.westernYear,
    required this.rabjungCycle,
    required this.rabjungYear,
    this.animal,
    this.element,
    this.gender,
  });

  Year copyWith({
    int? tibYear,
    int? westernYear,
    int? rabjungCycle,
    int? rabjungYear,
    String? animal,
    String? element,
    String? gender,
  }) {
    return Year(
      tibYear: tibYear ?? this.tibYear,
      westernYear: westernYear ?? this.westernYear,
      rabjungCycle: rabjungCycle ?? this.rabjungCycle,
      rabjungYear: rabjungYear ?? this.rabjungYear,
      animal: animal ?? this.animal,
      element: element ?? this.element,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'Year(tibYear: $tibYear, westernYear: $westernYear, '
        'rabjungCycle: $rabjungCycle, rabjungYear: $rabjungYear, '
        'animal: $animal, element: $element, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Year &&
        other.tibYear == tibYear &&
        other.westernYear == westernYear &&
        other.rabjungCycle == rabjungCycle &&
        other.rabjungYear == rabjungYear &&
        other.animal == animal &&
        other.element == element &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return tibYear.hashCode ^
        westernYear.hashCode ^
        rabjungCycle.hashCode ^
        rabjungYear.hashCode ^
        animal.hashCode ^
        element.hashCode ^
        gender.hashCode;
  }
}

/// Represents a Tibetan month
class Month {
  final int year;
  final int month;
  final bool isLeapMonth;
  final bool isDoubledMonth;
  final String? startDate;
  final String? endDate;

  Month({
    required this.year,
    required this.month,
    required this.isLeapMonth,
    this.isDoubledMonth = false,
    this.startDate,
    this.endDate,
  });

  Month copyWith({
    int? year,
    int? month,
    bool? isLeapMonth,
    bool? isDoubledMonth,
    String? startDate,
    String? endDate,
  }) {
    return Month(
      year: year ?? this.year,
      month: month ?? this.month,
      isLeapMonth: isLeapMonth ?? this.isLeapMonth,
      isDoubledMonth: isDoubledMonth ?? this.isDoubledMonth,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  String toString() {
    return 'Month(year: $year, month: $month, isLeapMonth: $isLeapMonth, '
        'isDoubledMonth: $isDoubledMonth, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Month &&
        other.year == year &&
        other.month == month &&
        other.isLeapMonth == isLeapMonth &&
        other.isDoubledMonth == isDoubledMonth &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        month.hashCode ^
        isLeapMonth.hashCode ^
        isDoubledMonth.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}

/// Represents the month info within a Day
class DayMonth {
  final int month;
  final bool isLeapMonth;
  final bool isDoubledMonth;

  DayMonth({
    required this.month,
    required this.isLeapMonth,
    required this.isDoubledMonth,
  });

  DayMonth copyWith({
    int? month,
    bool? isLeapMonth,
    bool? isDoubledMonth,
  }) {
    return DayMonth(
      month: month ?? this.month,
      isLeapMonth: isLeapMonth ?? this.isLeapMonth,
      isDoubledMonth: isDoubledMonth ?? this.isDoubledMonth,
    );
  }

  @override
  String toString() {
    return 'DayMonth(month: $month, isLeapMonth: $isLeapMonth, isDoubledMonth: $isDoubledMonth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DayMonth &&
        other.month == month &&
        other.isLeapMonth == isLeapMonth &&
        other.isDoubledMonth == isDoubledMonth;
  }

  @override
  int get hashCode {
    return month.hashCode ^ isLeapMonth.hashCode ^ isDoubledMonth.hashCode;
  }
}

/// Represents a Tibetan day with all its attributes
class Day {
  final int year;
  final DayMonth month;
  final int day;
  final bool skippedDay;
  final bool isPreviousSkipped;
  final bool isLeapDay;
  final bool isDoubledDay;
  final DateTime westernDate;

  Day({
    required this.year,
    required this.month,
    required this.day,
    required this.skippedDay,
    required this.isPreviousSkipped,
    required this.isLeapDay,
    required this.isDoubledDay,
    required this.westernDate,
  });

  Day copyWith({
    int? year,
    DayMonth? month,
    int? day,
    bool? skippedDay,
    bool? isPreviousSkipped,
    bool? isLeapDay,
    bool? isDoubledDay,
    DateTime? westernDate,
  }) {
    return Day(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      skippedDay: skippedDay ?? this.skippedDay,
      isPreviousSkipped: isPreviousSkipped ?? this.isPreviousSkipped,
      isLeapDay: isLeapDay ?? this.isLeapDay,
      isDoubledDay: isDoubledDay ?? this.isDoubledDay,
      westernDate: westernDate ?? this.westernDate,
    );
  }

  @override
  String toString() {
    return 'Day(year: $year, month: $month, day: $day, '
        'skippedDay: $skippedDay, isPreviousSkipped: $isPreviousSkipped, '
        'isLeapDay: $isLeapDay, isDoubledDay: $isDoubledDay, '
        'westernDate: $westernDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Day &&
        other.year == year &&
        other.month == month &&
        other.day == day &&
        other.skippedDay == skippedDay &&
        other.isPreviousSkipped == isPreviousSkipped &&
        other.isLeapDay == isLeapDay &&
        other.isDoubledDay == isDoubledDay &&
        other.westernDate == westernDate;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        skippedDay.hashCode ^
        isPreviousSkipped.hashCode ^
        isLeapDay.hashCode ^
        isDoubledDay.hashCode ^
        westernDate.hashCode;
  }
}

/// Helper class for getDayBefore return value
class DayBefore {
  final int day;
  final int monthCount;

  DayBefore({required this.day, required this.monthCount});

  @override
  String toString() => 'DayBefore(day: $day, monthCount: $monthCount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DayBefore && other.day == day && other.monthCount == monthCount;
  }

  @override
  int get hashCode => day.hashCode ^ monthCount.hashCode;
}

/// Represents year attributes (animal, element, gender)
class YearAttribute {
  final String animal;
  final String element;
  final String gender;

  YearAttribute({
    required this.animal,
    required this.element,
    required this.gender,
  });

  YearAttribute copyWith({
    String? animal,
    String? element,
    String? gender,
  }) {
    return YearAttribute(
      animal: animal ?? this.animal,
      element: element ?? this.element,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'YearAttribute(animal: $animal, element: $element, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YearAttribute &&
        other.animal == animal &&
        other.element == element &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return animal.hashCode ^ element.hashCode ^ gender.hashCode;
  }
}
