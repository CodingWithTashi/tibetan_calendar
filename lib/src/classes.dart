import 'package:tibetan_calendar/src/generators.dart';
import 'package:tibetan_calendar/src/helpers.dart';
import 'package:tibetan_calendar/src/types.dart';

/// A TibetanDate class
///
/// [arg] - undefined will return tibetan date for today |
/// string will return tibetan day for `new Date(arg)` |
/// object will return tibetan day according to object definition
class TibetanDate {
  final int year;
  final int month;
  final int date;
  final bool isSkippedDay;
  final bool isPreviousSkipped;
  final bool isLeapDay;
  final bool isDoubledDay;
  final DateTime westernDate;
  final TibetanMonth monthObj;

  TibetanDate({
    Object? arg,
  })  : year = _initYear(arg),
        month = _initMonth(arg),
        date = _initDate(arg),
        isSkippedDay = _initSkippedDay(arg),
        isPreviousSkipped = _initIsPreviousSkipped(arg),
        isLeapDay = _initIsLeapDay(arg),
        isDoubledDay = _initIsDoubledDay(arg),
        westernDate = _initWesternDate(arg),
        monthObj = _initMonthObj(arg);

  static int _initYear(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).year;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).year;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.year;
    }
    throw ArgumentError('Invalid argument type');
  }

  static int _initMonth(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).month.month;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).month.month;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.month.month;
    }
    throw ArgumentError('Invalid argument type');
  }

  static int _initDate(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).day;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).day;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.day;
    }
    throw ArgumentError('Invalid argument type');
  }

  static bool _initSkippedDay(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).skippedDay;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).skippedDay;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.skippedDay;
    }
    throw ArgumentError('Invalid argument type');
  }

  static bool _initIsPreviousSkipped(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).isPreviousSkipped;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).isPreviousSkipped;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.isPreviousSkipped;
    }
    throw ArgumentError('Invalid argument type');
  }

  static bool _initIsLeapDay(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).isLeapDay;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).isLeapDay;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.isLeapDay;
    }
    throw ArgumentError('Invalid argument type');
  }

  static bool _initIsDoubledDay(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).isDoubledDay;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).isDoubledDay;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.isDoubledDay;
    }
    throw ArgumentError('Invalid argument type');
  }

  static DateTime _initWesternDate(Object? arg) {
    if (arg == null) {
      return getDayFromWestern(DateTime.now()).westernDate;
    } else if (arg is String) {
      return getDayFromWestern(DateTime.parse(arg)).westernDate;
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return day.westernDate;
    }
    throw ArgumentError('Invalid argument type');
  }

  static TibetanMonth _initMonthObj(Object? arg) {
    if (arg == null) {
      final day = getDayFromWestern(DateTime.now());
      return TibetanMonth(
        year: day.year,
        month: day.month.month,
        isLeapMonth: day.month.isLeapMonth,
      );
    } else if (arg is String) {
      final day = getDayFromWestern(DateTime.parse(arg));
      return TibetanMonth(
        year: day.year,
        month: day.month.month,
        isLeapMonth: day.month.isLeapMonth,
      );
    } else if (arg is Map) {
      final day = getDayFromTibetan(
        year: arg['year'] as int,
        month: arg['month'] as int,
        isLeapMonth: arg['isLeapMonth'] as bool? ?? false,
        day: arg['day'] as int,
        isLeapDay: arg['isLeapDay'] as bool? ?? false,
      );
      return TibetanMonth(
        year: day.year,
        month: day.month.month,
        isLeapMonth: day.month.isLeapMonth,
      );
    }
    throw ArgumentError('Invalid argument type');
  }

  /// Create from Western date
  factory TibetanDate.fromWestern(DateTime date) {
    return TibetanDate(arg: date.toIso8601String());
  }

  /// Create from Tibetan date components
  factory TibetanDate.fromTibetan({
    required int year,
    required int month,
    required int day,
    bool isLeapMonth = false,
    bool isLeapDay = false,
  }) {
    return TibetanDate(arg: {
      'year': year,
      'month': month,
      'isLeapMonth': isLeapMonth,
      'day': day,
      'isLeapDay': isLeapDay,
    });
  }

  /// Get Tibetan date for today
  factory TibetanDate.now() {
    return TibetanDate();
  }

  /// Getters
  int get day => westernDate.weekday; // Day of week

  TibetanYear get yearObj => TibetanYear.fromTibetan(year);

  String get westernDateStr => getDateStr(westernDate);

  /// Methods
  DateTime getWesternDate() => westernDate;

  int getDate() => date;

  int getDay() => westernDate.weekday;

  int getMonth() => month;

  TibetanMonth getMonthObj() => monthObj;

  int getYear() => year;

  TibetanYear getYearObj() => yearObj;

  @override
  String toString() {
    String double = '';
    if (isDoubledDay) {
      double = isLeapDay ? '-leap' : '-main';
    }
    return '${monthObj.toString()}-$date$double';
  }
}

/// A TibetanMonth class
///
/// [arg] - undefined will return tibetan month for current month |
/// string will return tibetan day for month of `new Date(arg)` |
/// object will return tibetan month according to object definition
class TibetanMonth {
  final int year;
  final int month;
  final bool isLeapMonth;
  final bool isDoubledMonth;
  final String startDateStr;
  final String endDateStr;
  final List<TibetanDate> _days;

  bool _daysCalculated = false;

  TibetanMonth({
    Object? arg,
    int? year,
    int? month,
    bool? isLeapMonth,
  })  : year = year ?? _initYear(arg),
        month = month ?? _initMonth(arg),
        isLeapMonth = isLeapMonth ?? _initIsLeapMonth(arg),
        isDoubledMonth = _initIsDoubledMonth(
              arg,
              year: year,
              month: month,
              isLeapMonth: isLeapMonth,
            ),
        startDateStr = _initStartDateStr(
              arg,
              year: year,
              month: month,
              isLeapMonth: isLeapMonth,
            ),
        endDateStr = _initEndDateStr(
              arg,
              year: year,
              month: month,
              isLeapMonth: isLeapMonth,
            ),
        _days = [];

  static int _initYear(Object? arg) {
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      return tibDate.year;
    } else if (arg is String) {
      final tibDate = getDayFromWestern(DateTime.parse(arg));
      return tibDate.year;
    }
    throw ArgumentError('Invalid argument type for year');
  }

  static int _initMonth(Object? arg) {
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      return tibDate.month.month;
    } else if (arg is String) {
      final tibDate = getDayFromWestern(DateTime.parse(arg));
      return tibDate.month.month;
    }
    throw ArgumentError('Invalid argument type for month');
  }

  static bool _initIsLeapMonth(Object? arg) {
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      return tibDate.month.isLeapMonth;
    } else if (arg is String) {
      final tibDate = getDayFromWestern(DateTime.parse(arg));
      return tibDate.month.isLeapMonth;
    }
    throw ArgumentError('Invalid argument type for isLeapMonth');
  }

  static bool _initIsDoubledMonth(
    Object? arg, {
    int? year,
    int? month,
    bool? isLeapMonth,
  }) {
    final y = year ?? _initYear(arg);
    final m = month ?? _initMonth(arg);
    return isDoubledMonthFunc(y, m);
  }

  static String _initStartDateStr(
    Object? arg, {
    int? year,
    int? month,
    bool? isLeapMonth,
  }) {
    final y = year ?? _initYear(arg);
    final m = month ?? _initMonth(arg);
    final isLeap = isLeapMonth ?? _initIsLeapMonth(arg);
    final monthData = getMonthFromTibetan(
      year: y,
      month: m,
      isLeapMonth: isLeap,
    );
    return monthData.startDate ?? '';
  }

  static String _initEndDateStr(
    Object? arg, {
    int? year,
    int? month,
    bool? isLeapMonth,
  }) {
    final y = year ?? _initYear(arg);
    final m = month ?? _initMonth(arg);
    final isLeap = isLeapMonth ?? _initIsLeapMonth(arg);
    final monthData = getMonthFromTibetan(
      year: y,
      month: m,
      isLeapMonth: isLeap,
    );
    return monthData.endDate ?? '';
  }

  /// Create from Tibetan date components
  factory TibetanMonth.fromTibetan({
    required int year,
    required int month,
    bool isLeapMonth = false,
  }) {
    return TibetanMonth(
      year: year,
      month: month,
      isLeapMonth: isLeapMonth,
    );
  }

  /// Get the year object for this month
  TibetanYear get yearObj => TibetanYear.fromTibetan(year);

  /// Get all days in this month
  /// Need to call this method at least once in order to calculate the dates.
  /// This is in order to reduce initial object size.
  List<TibetanDate> getDays() {
    if (_daysCalculated) {
      return _days;
    }

    // loop over the days, taking care of duplicate and missing days
    for (int d = 1; d <= 30; d++) {
      final day = TibetanDate.fromTibetan(
        year: year,
        month: month,
        isLeapMonth: isLeapMonth,
        day: d,
        isLeapDay: false,
      );

      if (day.isDoubledDay) {
        final main = TibetanDate.fromTibetan(
          year: year,
          month: month,
          isLeapMonth: isLeapMonth,
          day: d,
          isLeapDay: true,
        );
        _days.add(main);
      }

      if (!day.isSkippedDay) {
        _days.add(day);
      }
    }

    _daysCalculated = true;
    return _days;
  }

  @override
  String toString() {
    String double = '';
    if (isDoubledMonth) {
      double = isLeapMonth ? '-leap' : '-main';
    }
    return '${yearObj.toString()}-$month$double';
  }
}

/// A TibetanYear class
///
/// [arg] - undefined will return tibetan year for current year |
/// number will return tibetan year unless isWestern is true |
/// object will return tibetan year according to rabjung cycle
class TibetanYear {
  final int rabjungCycle;
  final int rabjungYear;
  final int tibYearNum;
  final int westernYear;
  final String animal;
  final String element;
  final String gender;
  final List<TibetanMonth> _months;

  bool _monthsCalculated = false;

  TibetanYear({
    Object? arg,
    bool isWestern = false,
  })  : rabjungCycle = _initRabjungCycle(arg, isWestern),
        rabjungYear = _initRabjungYear(arg, isWestern),
        tibYearNum = _initTibYearNum(arg, isWestern),
        westernYear = _initWesternYear(arg, isWestern),
        animal = _initAnimal(arg, isWestern),
        element = _initElement(arg, isWestern),
        gender = _initGender(arg, isWestern),
        _months = [];

  static int _initRabjungCycle(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.rabjungCycle;
  }

  static int _initRabjungYear(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.rabjungYear;
  }

  static int _initTibYearNum(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.tibYear;
  }

  static int _initWesternYear(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.westernYear;
  }

  static String _initAnimal(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.animal!;
  }

  static String _initElement(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.element!;
  }

  static String _initGender(Object? arg, bool isWestern) {
    Year yearInit;
    if (arg == null) {
      final tibDate = getDayFromWestern(DateTime.now());
      yearInit = getYearFromTibetan(tibDate.year);
    } else if (arg is int) {
      if (isWestern) {
        yearInit = getYearFromWestern(arg);
      } else {
        yearInit = getYearFromTibetan(arg);
      }
    } else if (arg is Map) {
      yearInit = getYearFromRabjung(
        rabjungCycle: arg['rabjungCycle'] as int,
        rabjungYear: arg['rabjungYear'] as int,
      );
    } else {
      throw ArgumentError('Invalid argument type');
    }
    return yearInit.gender!;
  }

  /// Create from Western year
  factory TibetanYear.fromWestern(int westernYear) {
    return TibetanYear(arg: westernYear, isWestern: true);
  }

  /// Create from Tibetan year
  factory TibetanYear.fromTibetan(int tibetanYear) {
    return TibetanYear(arg: tibetanYear, isWestern: false);
  }

  /// Create from Rabjung cycle
  factory TibetanYear.fromRabjung({
    required int rabjungCycle,
    required int rabjungYear,
  }) {
    return TibetanYear(arg: {
      'rabjungCycle': rabjungCycle,
      'rabjungYear': rabjungYear,
    });
  }

  /// Get all months in this year
  /// Need to call this method at least once in order to calculate the months.
  /// This is in order to reduce initial object size.
  List<TibetanMonth> getMonths() {
    if (_monthsCalculated) {
      return _months;
    }

    // loop over the month, taking care of duplicates
    for (int m = 1; m <= 12; m++) {
      final month = TibetanMonth(
        year: tibYearNum,
        month: m,
      );
      _months.add(month);
      if (isDoubledMonthFunc(tibYearNum, m)) {
        final leapMonth = TibetanMonth(
          year: tibYearNum,
          month: m,
          isLeapMonth: true,
        );
        _months.add(leapMonth);
      }
    }

    _monthsCalculated = true;
    return _months;
  }

  @override
  String toString() {
    return '$tibYearNum';
  }

  String toRabjungString() {
    return 'The $rabjungYear. year of the $rabjungCycle. rabjung cycle';
  }
}

// Helper function to avoid name collision
bool isDoubledMonthFunc(int tYear, int month) {
  return isDoubledMonth(tYear, month);
}
