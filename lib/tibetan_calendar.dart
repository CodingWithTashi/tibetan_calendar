library tibetan_calendar;

// Types
export 'src/types.dart' show Year, Month, Day, DayMonth, DayBefore, YearAttribute;

// Classes
export 'src/classes.dart' show TibetanDate, TibetanMonth, TibetanYear;

// Generator functions
export 'src/generators.dart'
    show
        getDayFromTibetan,
        getDayFromWestern,
        getMonthFromMonthCount,
        getMonthFromTibetan,
        getLosarForYear,
        getYearFromWestern,
        getYearFromTibetan,
        getYearFromRabjung;

// Helper functions
export 'src/helpers.dart'
    show
        frac,
        amod,
        meanDate,
        moonAnomaly,
        moonEqu,
        moonTabInt,
        moonTabValue,
        meanSun,
        sunAnomaly,
        sunEqu,
        sunTabInt,
        sunTabValue,
        isDoubledMonth,
        getDayBefore,
        getDateStr,
        yearAttributes;

// Conversion functions
export 'src/conversions.dart'
    show
        monthCountFromTibetan,
        trueDateFromMonthCountDay,
        julianFromTrueDate,
        julianFromTibetan,
        julianFromUnix,
        unixFromJulian;

// Constants
export 'src/constants.dart'
    show
        rabjungBeginning,
        rabjungCycleLength,
        yearDiff,
        julianToUnix,
        msInYear,
        minInDay,
        year0,
        month0,
        betaStar,
        beta,
        m0,
        m1,
        m2,
        s0,
        s1,
        s2,
        a0,
        a1,
        a2,
        moonTab,
        sunTab,
        yearElements,
        yearAnimals,
        yearGender;

// Legacy compatibility - keep old API working
// Backward compatible TibetanCalendar class for existing code
import 'package:tibetan_calendar/src/classes.dart';
import 'package:tibetan_calendar/src/generators.dart';
import 'package:tibetan_calendar/src/types.dart';

/// @Deprecated: Use [TibetanDate] instead. Kept for backward compatibility.
class TibetanCalendar {
  final int year;
  final int month;
  final int day;
  final bool isLeapMonth;
  final bool isLeapDay;

  TibetanCalendar({
    required this.year,
    required this.month,
    required this.day,
    required this.isLeapDay,
    required this.isLeapMonth,
  });

  /// @Deprecated: Use [TibetanDate.fromWestern] instead.
  static TibetanCalendar getTibetanDate(DateTime arg) {
    final tibDate = getDayFromWestern(arg);
    return TibetanCalendar(
      year: tibDate.year,
      month: tibDate.month.month,
      day: tibDate.day,
      isLeapDay: tibDate.isLeapDay,
      isLeapMonth: tibDate.month.isLeapMonth,
    );
  }

  /// @Deprecated: Use [TibetanDate.fromTibetan] instead.
  static TibetanCalendar getDayFromTibetanLegacy({
    required int year,
    required int month,
    bool? isLeapMonth,
    required int day,
    bool? isLeapDay,
  }) {
    final tibDate = getDayFromTibetan(
      year: year,
      month: month,
      isLeapMonth: isLeapMonth ?? false,
      day: day,
      isLeapDay: isLeapDay ?? false,
    );
    return TibetanCalendar(
      year: tibDate.year,
      month: tibDate.month.month,
      day: tibDate.day,
      isLeapDay: tibDate.isLeapDay,
      isLeapMonth: tibDate.month.isLeapMonth,
    );
  }

  /// @Deprecated: Use [getYearAttributes] helper function instead.
  static YearAttribute getYearAttributes({required int tibetanYear}) {
    final yearVal = getYearFromTibetan(tibetanYear);
    return YearAttribute(
      animal: yearVal.animal!,
      element: yearVal.element!,
      gender: yearVal.gender!,
    );
  }

  /// @Deprecated: Use [getYearFromTibetan] and then calculate offset manually.
  static YearAttribute getAnimalAndElementByYear({
    required int tibetanYear,
    required int westernBirthYear,
  }) {
    // subtract western current year to year of birth
    final yearOffset = DateTime.now().year - westernBirthYear;
    // get tibetan birth year by subtracting current tibetan year and yearOffset
    final birthTibetanYear = tibetanYear - yearOffset;
    return getYearAttributes(tibetanYear: birthTibetanYear);
  }
}
