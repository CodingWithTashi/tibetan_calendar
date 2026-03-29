import 'package:test/test.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';

void main() {
  group('Legacy TibetanCalendar API - Backward Compatibility', () {
    test('Check Tibetan date by western date (2022, 11, 7)', () {
      final tibetanDate = TibetanCalendar.getTibetanDate(DateTime(2022, 11, 7));
      expect(tibetanDate.day, 14);
      expect(tibetanDate.month, 9);
      expect(tibetanDate.year, 2149);
    });

    test('Check Tibetan date by western date (2021, 12, 12)', () {
      final tibetanDate = TibetanCalendar.getTibetanDate(DateTime(2021, 12, 12));
      expect(tibetanDate.day, 9);
      expect(tibetanDate.month, 10);
      expect(tibetanDate.year, 2148);
    });

    test('Check Tibetan date by western date (2020, 10, 10)', () {
      final tibetanDate = TibetanCalendar.getTibetanDate(DateTime(2020, 10, 10));
      expect(tibetanDate.day, 23);
      expect(tibetanDate.month, 8);
      expect(tibetanDate.year, 2147);
    });

    test('Check Tibetan year attribute are correct or not (2150-2023)', () {
      final yearAttribute =
          TibetanCalendar.getYearAttributes(tibetanYear: 2150);
      expect(yearAttribute.animal, 'Rabbit');
      expect(yearAttribute.element, 'Water');
    });

    test('Check Tibetan year attribute are correct or not (2151-2024)', () {
      final yearAttribute =
          TibetanCalendar.getYearAttributes(tibetanYear: 2151);
      expect(yearAttribute.animal, 'Dragon');
      expect(yearAttribute.element, 'Wood');
    });

    test('Check Tibetan year attribute are correct or not (2152-2025)', () {
      final yearAttribute =
          TibetanCalendar.getYearAttributes(tibetanYear: 2152);
      expect(yearAttribute.animal, 'Snake');
      expect(yearAttribute.element, 'Wood');
    });
  });

  group('New API - Generator Functions', () {
    test('getDayFromWestern should return correct Day object', () {
      final day = getDayFromWestern(DateTime(2022, 11, 7));
      expect(day.year, 2149);
      expect(day.month.month, 9);
      expect(day.month.isLeapMonth, false);
      expect(day.day, 14);
      // Compare date components only due to timezone handling
      expect(day.westernDate.year, 2022);
      expect(day.westernDate.month, 11);
      expect(day.westernDate.day, 7);
    });

    test('getDayFromTibetan should return correct Day object', () {
      final day = getDayFromTibetan(
        year: 2149,
        month: 9,
        isLeapMonth: false,
        day: 14,
        isLeapDay: false,
      );
      expect(day.year, 2149);
      expect(day.month.month, 9);
      expect(day.day, 14);
      // Compare date components only due to timezone handling
      expect(day.westernDate.year, 2022);
      expect(day.westernDate.month, 11);
      expect(day.westernDate.day, 7);
    });

    test('getMonthFromTibetan should return month with dates', () {
      final month = getMonthFromTibetan(year: 2149, month: 9);
      expect(month.year, 2149);
      expect(month.month, 9);
      expect(month.isLeapMonth, false);
      expect(month.startDate, isNotNull);
      expect(month.endDate, isNotNull);
    });

    test('getLosarForYear should return Losar date', () {
      final losar = getLosarForYear(2149);
      expect(losar, isNotNull);
      expect(losar.contains('-'), true);
      // Losar for year 2149 should be in Feb 2022
      expect(losar.startsWith('2022-'), true);
    });

    test('getYearFromWestern should return year with attributes', () {
      final year = getYearFromWestern(2023);
      expect(year.westernYear, 2023);
      expect(year.tibYear, 2150);
      expect(year.animal, 'Rabbit');
      expect(year.element, 'Water');
      expect(year.gender, isNotNull);
    });

    test('getYearFromTibetan should return year with attributes', () {
      final year = getYearFromTibetan(2150);
      expect(year.westernYear, 2023);
      expect(year.tibYear, 2150);
      expect(year.animal, 'Rabbit');
      expect(year.element, 'Water');
    });

    test('getYearFromRabjung should return year for cycle', () {
      final year = getYearFromRabjung(rabjungCycle: 17, rabjungYear: 23);
      expect(year.rabjungCycle, 17);
      expect(year.rabjungYear, 23);
      expect(year.tibYear, isNotNull);
      expect(year.westernYear, isNotNull);
    });

    test('getMonthFromMonthCount should return correct month', () {
      final month = getMonthFromMonthCount(16116);
      expect(month.year, isNotNull);
      expect(month.month, isNotNull);
      expect(month.isLeapMonth, isNotNull);
    });
  });

  group('New API - Classes', () {
    test('TibetanDate.fromWestern should create date from Western date', () {
      final tibDate = TibetanDate.fromWestern(DateTime(2022, 11, 7));
      expect(tibDate.year, 2149);
      expect(tibDate.month, 9);
      expect(tibDate.date, 14);
    });

    test('TibetanDate.fromTibetan should create date from Tibetan components',
        () {
      final tibDate = TibetanDate.fromTibetan(
        year: 2149,
        month: 9,
        day: 14,
      );
      expect(tibDate.year, 2149);
      expect(tibDate.month, 9);
      expect(tibDate.date, 14);
    });

    test('TibetanDate.now should return today\'s Tibetan date', () {
      final tibDate = TibetanDate.now();
      expect(tibDate.year, isNotNull);
      expect(tibDate.month, isInInclusiveRange(1, 12));
      expect(tibDate.date, isInInclusiveRange(1, 30));
    });

    test('TibetanMonth.fromTibetan should create month', () {
      final tibMonth = TibetanMonth.fromTibetan(year: 2149, month: 9);
      expect(tibMonth.year, 2149);
      expect(tibMonth.month, 9);
      expect(tibMonth.isLeapMonth, false);
    });

    test('TibetanMonth.getDays should return list of days', () {
      final tibMonth = TibetanMonth.fromTibetan(year: 2149, month: 9);
      final days = tibMonth.getDays();
      expect(days, isNotEmpty);
      // Tibetan months typically have 29-30 days, but may have skipped/doubled days
      expect(days.length, greaterThan(25));
    });

    test('TibetanYear.fromWestern should create year from Western year', () {
      final tibYear = TibetanYear.fromWestern(2023);
      expect(tibYear.westernYear, 2023);
      expect(tibYear.tibYearNum, 2150);
      expect(tibYear.animal, 'Rabbit');
      expect(tibYear.element, 'Water');
    });

    test('TibetanYear.fromTibetan should create year from Tibetan year', () {
      final tibYear = TibetanYear.fromTibetan(2150);
      expect(tibYear.westernYear, 2023);
      expect(tibYear.tibYearNum, 2150);
      expect(tibYear.animal, 'Rabbit');
    });

    test('TibetanYear.fromRabjung should create year from Rabjung cycle', () {
      final tibYear = TibetanYear.fromRabjung(
        rabjungCycle: 17,
        rabjungYear: 23,
      );
      expect(tibYear.rabjungCycle, 17);
      expect(tibYear.rabjungYear, 23);
    });

    test('TibetanYear.getMonths should return list of months', () {
      final tibYear = TibetanYear.fromTibetan(2149);
      final months = tibYear.getMonths();
      expect(months, isNotEmpty);
      // Tibetan year has 12 months, some may have doubled months
      expect(months.length, greaterThanOrEqualTo(12));
    });

    test('TibetanDate toString should format correctly', () {
      final tibDate = TibetanDate.fromTibetan(
        year: 2149,
        month: 9,
        day: 14,
      );
      final str = tibDate.toString();
      expect(str, contains('2149'));
      expect(str, contains('9'));
      expect(str, contains('14'));
    });

    test('TibetanMonth toString should format correctly', () {
      final tibMonth = TibetanMonth.fromTibetan(year: 2149, month: 9);
      final str = tibMonth.toString();
      expect(str, contains('2149'));
      expect(str, contains('9'));
    });

    test('TibetanYear toString should return year number', () {
      final tibYear = TibetanYear.fromTibetan(2150);
      expect(tibYear.toString(), '2150');
    });

    test('TibetanYear toRabjungString should format correctly', () {
      final tibYear = TibetanYear.fromTibetan(2150);
      final str = tibYear.toRabjungString();
      expect(str, contains('rabjung'));
    });
  });

  group('Helper Functions', () {
    test('isDoubledMonth should check if month is doubled', () {
      // Test a known doubled month if available
      final result = isDoubledMonth(2149, 9);
      expect(result, isA<bool>());
    });

    test('getDateStr should format date correctly', () {
      final date = DateTime(2023, 5, 15);
      final str = getDateStr(date);
      expect(str, '2023-05-15');
    });

    test('frac should return fractional part', () {
      expect(frac(3.14), 3.14 % 1);
      expect(frac(5.0), 0.0);
    });

    test('amod should return correct modulo', () {
      expect(amod(12, 12), 12); // Multiple of b returns b
      expect(amod(13, 12), 1); // Not multiple returns a % b
    });

    test('yearAttributes should add animal, element, gender', () {
      final year = Year(
        tibYear: 2150,
        westernYear: 2023,
        rabjungCycle: 17,
        rabjungYear: 23,
      );
      final result = yearAttributes(year);
      expect(result.animal, 'Rabbit');
      expect(result.element, 'Water');
      expect(result.gender, isNotNull);
    });

    test('getDayBefore should return previous day', () {
      final result = getDayBefore(5, 100);
      expect(result.day, 4);
      expect(result.monthCount, 100);

      final resultMonthStart = getDayBefore(1, 100);
      expect(resultMonthStart.day, 30);
      expect(resultMonthStart.monthCount, 99);
    });
  });

  group('Conversion Functions', () {
    test('julianFromUnix should convert DateTime to Julian', () {
      final julian = julianFromUnix(DateTime(2023, 1, 1));
      expect(julian, isNotNull);
      expect(julian, greaterThan(2459945)); // Approx Julian date for 2023-01-01
    });

    test('unixFromJulian should convert Julian to DateTime', () {
      final dateTime = unixFromJulian(2459946);
      expect(dateTime, isA<DateTime>());
      // Julian date 2459946 is approximately 2023-01-01
      expect(dateTime.year, greaterThanOrEqualTo(2022));
      expect(dateTime.year, lessThanOrEqualTo(2023));
    });

    test('julianFromTibetan should convert Tibetan date to Julian', () {
      final julian = julianFromTibetan(2149, 9, false, 14);
      expect(julian, isNotNull);
    });

    test('monthCountFromTibetan should convert Tibetan month to count', () {
      final month = Month(year: 2149, month: 9, isLeapMonth: false);
      final count = monthCountFromTibetan(month);
      expect(count, isA<int>());
      expect(count, greaterThan(0));
    });

    test('trueDateFromMonthCountDay should calculate true date', () {
      final trueDate = trueDateFromMonthCountDay(15, 16116);
      expect(trueDate, isNotNull);
    });

    test('julianFromTrueDate should convert true date to Julian', () {
      final julian = julianFromTrueDate(483480);
      expect(julian, isA<int>());
    });
  });

  group('Type Classes', () {
    test('Year equality should work correctly', () {
      final year1 = Year(
        tibYear: 2150,
        westernYear: 2023,
        rabjungCycle: 17,
        rabjungYear: 23,
        animal: 'Rabbit',
        element: 'Water',
      );
      final year2 = Year(
        tibYear: 2150,
        westernYear: 2023,
        rabjungCycle: 17,
        rabjungYear: 23,
        animal: 'Rabbit',
        element: 'Water',
      );
      expect(year1, equals(year2));
      expect(year1.hashCode, equals(year2.hashCode));
    });

    test('Month equality should work correctly', () {
      final month1 = Month(year: 2149, month: 9, isLeapMonth: false);
      final month2 = Month(year: 2149, month: 9, isLeapMonth: false);
      expect(month1, equals(month2));
    });

    test('Day equality should work correctly', () {
      final testDate = DateTime.utc(2022, 11, 7); // Use UTC to avoid timezone issues
      final day1 = Day(
        year: 2149,
        month: DayMonth(month: 9, isLeapMonth: false, isDoubledMonth: false),
        day: 14,
        skippedDay: false,
        isPreviousSkipped: false,
        isLeapDay: false,
        isDoubledDay: false,
        westernDate: testDate,
      );
      final day2 = Day(
        year: 2149,
        month: DayMonth(month: 9, isLeapMonth: false, isDoubledMonth: false),
        day: 14,
        skippedDay: false,
        isPreviousSkipped: false,
        isLeapDay: false,
        isDoubledDay: false,
        westernDate: testDate,
      );
      expect(day1, equals(day2));
    });

    test('YearAttribute equality should work correctly', () {
      final attr1 = YearAttribute(
        animal: 'Rabbit',
        element: 'Water',
        gender: 'Male',
      );
      final attr2 = YearAttribute(
        animal: 'Rabbit',
        element: 'Water',
        gender: 'Male',
      );
      expect(attr1, equals(attr2));
    });
  });
}

// Custom matcher for inclusive range
Matcher isInInclusiveRange(int low, int high) {
  return _InRangeMatcher(low, high);
}

class _InRangeMatcher extends Matcher {
  final int low;
  final int high;

  _InRangeMatcher(this.low, this.high);

  @override
  bool matches(covariant int item, Map matchState) {
    return item >= low && item <= high;
  }

  @override
  Description describe(Description description) {
    return description.add('a value between $low and $high (inclusive)');
  }
}
