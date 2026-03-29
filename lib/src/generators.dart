import 'package:tibetan_calendar/src/constants.dart';
import 'package:tibetan_calendar/src/conversions.dart';
import 'package:tibetan_calendar/src/helpers.dart';
import 'package:tibetan_calendar/src/types.dart';

/// Calculates full information for a given Tibetan date
///
/// For doubled days, just as with doubled months, the "main" day or month is
/// the second, and the "leap" day or month is the first.
Day getDayFromTibetan({
  required int year,
  required int month,
  bool isLeapMonth = false,
  required int day,
  bool isLeapDay = false,
}) {
  int julianDate = julianFromTibetan(year, month, isLeapMonth, day);

  // also calculate the Julian date of the previous Tib. day
  final monthCountVal = monthCountFromTibetan(
    Month(year: year, month: month, isLeapMonth: isLeapMonth),
  );
  final dayBefore = getDayBefore(day, monthCountVal);
  final julianDatePrevious =
      trueDateFromMonthCountDay(dayBefore.day, dayBefore.monthCount).floor();
  final twoDaysBefore = getDayBefore(dayBefore.day, dayBefore.monthCount);
  final julianDate2DaysBefore =
      trueDateFromMonthCountDay(twoDaysBefore.day, twoDaysBefore.monthCount)
          .floor();

  // figure out leap months, leap days & skipped days
  final isDoubledMonthThis = isDoubledMonth(year, month);
  final hasLeapDayThis = julianDate == julianDatePrevious + 2;
  final skippedDay = julianDate == julianDatePrevious;
  final isPreviousSkipped = julianDatePrevious == julianDate2DaysBefore;
  final isLeapDayChecked = isLeapDay && hasLeapDayThis;

  // figure out western date info for the main or leap day
  if (isLeapDayChecked) {
    julianDate--;
  }
  final westernDate = unixFromJulian(julianDate);

  return Day(
    year: year,
    month: DayMonth(
      month: month,
      isLeapMonth: isLeapMonth && isDoubledMonthThis,
      isDoubledMonth: isDoubledMonthThis,
    ),
    day: day,
    skippedDay: skippedDay,
    isPreviousSkipped: isPreviousSkipped,
    isLeapDay: isLeapDayChecked,
    isDoubledDay: hasLeapDayThis,
    westernDate: westernDate,
  );
}

/// Calculates a Tibetan date for a given western date.
/// This does a binary search, and is therefore much slower than tibToWestern().
///
/// The algorithm could be much improved by using the reverse of meanDate() to start with,
/// and then using the fact that julian dates and "tibetan day numbers" have a quasi-linear relation.
Day getDayFromWestern(DateTime date) {
  final wYear = date.year;
  final jd = julianFromUnix(date);
  final tibYears = [wYear + yearDiff - 1, wYear + yearDiff + 1];

  final monthCounts = tibYears
      .map((y) => monthCountFromTibetan(
            Month(year: y, month: 1, isLeapMonth: true),
          ))
      .toList();
  final trueDate = monthCounts.map((m) => 1 + 30 * m).toList();
  final jds = trueDate.map((n) => julianFromTrueDate(n)).toList();

  // Binary search
  while (trueDate[0] < trueDate[1] - 1 && jds[0] < jds[1]) {
    final nTrueDate = ((trueDate[0] + trueDate[1]) / 2).floor();
    final njd = julianFromTrueDate(nTrueDate);

    if (njd < jd) {
      trueDate[0] = nTrueDate;
      jds[0] = njd;
    } else {
      trueDate[1] = nTrueDate;
      jds[1] = njd;
    }
  }

  // so we found it
  late num winnerJd;
  late num winnerTrueDate;

  // if the western date is the 1st of a doubled tib. day, then jd[0] == jd - 1 and
  // jd[1] == jd + 1, and the corresponding tib. day number is the one from jd[1].
  if (jds[0] == jd) {
    winnerJd = jds[0];
    winnerTrueDate = trueDate[0];
  } else {
    winnerJd = jds[1];
    winnerTrueDate = trueDate[1];
  }

  // figure out the real tib. date: year, month, leap month, day number, leap day.
  final isLeapDayVal = winnerJd > jd;
  final monthCountVal = ((winnerTrueDate - 1) / 30).floor();
  final dayVal = winnerTrueDate % 30 == 0 ? 30 : (winnerTrueDate % 30);
  final monthData = getMonthFromMonthCount(monthCountVal);

  return getDayFromTibetan(
    year: monthData.year,
    month: monthData.month,
    isLeapMonth: monthData.isLeapMonth,
    day: dayVal.toInt(),
    isLeapDay: isLeapDayVal,
  );
}

/// Figures out the Tibetan year number, month number within the year, and whether
/// this is a leap month, from a "month count" number. See Svante Janson,
/// "Tibetan Calendar Mathematics", p.8 ff.
Month getMonthFromMonthCount(int monthCount) {
  final x = ((65 * monthCount + beta) / 67).ceil();
  final tMonth = amod(x, 12);
  final tYear = (x / 12).ceil() - 1 + year0 + yearDiff;
  final isLeapMonth =
      ((65 * (monthCount + 1) + beta) / 67).ceil() == x;

  return Month(
    year: tYear,
    month: tMonth,
    isLeapMonth: isLeapMonth,
  );
}

/// Calculates full information about a Tibetan month: whether it is doubled or not,
/// and the western start and end date for it.
/// The startDate and endDate correspond to the leap month if isLeapMonth is true,
/// otherwise to the main month (i.e the second of the two).
Month getMonthFromTibetan({
  required int year,
  required int month,
  bool isLeapMonth = false,
}) {
  final hasLeap = isDoubledMonth(year, month);
  final isLeap = isLeapMonth && hasLeap;

  // calculate the Julian date 1st and last of the month
  final monthCountVal = monthCountFromTibetan(
    Month(year: year, month: month, isLeapMonth: isLeap),
  );
  final jdFirst =
      1 + trueDateFromMonthCountDay(30, monthCountVal - 1).floor();
  final jdLast = trueDateFromMonthCountDay(30, monthCountVal).floor();
  final startDate = getDateStr(unixFromJulian(jdFirst));
  final endDate = getDateStr(unixFromJulian(jdLast));

  return Month(
    year: year,
    month: month,
    isLeapMonth: isLeap,
    isDoubledMonth: hasLeap,
    startDate: startDate,
    endDate: endDate,
  );
}

/// Calculates the Western date for Losar (Tibetan new year) of a given Tibetan
/// year number (ex. 2137).
String getLosarForYear(int year, {bool isTibetan = true}) {
  final tibYear = isTibetan ? year : year + yearDiff;
  final julianDay = 1 + julianFromTibetan(tibYear - 1, 12, false, 30);

  return getDateStr(unixFromJulian(julianDay));
}

/// Figures out a year's info from a Western calendar year number, ex. 2008.
Year getYearFromWestern(int wYear) {
  final rabjungCycleVal =
      ((wYear - rabjungBeginning + 1) / rabjungCycleLength).ceil();
  final rabjungYearVal =
      amod(wYear - rabjungBeginning + 1, rabjungCycleLength);

  return yearAttributes(
    Year(
      rabjungCycle: rabjungCycleVal,
      rabjungYear: rabjungYearVal,
      tibYear: wYear + yearDiff,
      westernYear: wYear,
    ),
  );
}

/// Figures out a year's info from a Tibetan calendar year number, ex. 2135.
Year getYearFromTibetan(int tYear) {
  return getYearFromWestern(tYear - yearDiff);
}

/// Figures out a year's info based on the Tibetan calendar, ex. the 3rd year of the 15th Rabjung calendrical cycle.
Year getYearFromRabjung({
  required int rabjungCycle,
  required int rabjungYear,
}) {
  if (rabjungCycle < 1 || rabjungYear > rabjungCycleLength) {
    throw ArgumentError('Year number must be between 1 and $rabjungCycleLength');
  }

  final wYear = rabjungBeginning +
      (rabjungCycle - 1) * rabjungCycleLength +
      (rabjungYear - 1);

  return yearAttributes(
    Year(
      rabjungCycle: rabjungCycle,
      rabjungYear: rabjungYear,
      tibYear: wYear + yearDiff,
      westernYear: wYear,
    ),
  );
}
