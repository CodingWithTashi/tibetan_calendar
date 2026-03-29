import 'package:tibetan_calendar/src/constants.dart';
import 'package:tibetan_calendar/src/helpers.dart';
import 'package:tibetan_calendar/src/types.dart';

/// This is the reverse of fromMonthCount(n): from a Tibetan year, month number
/// and leap month indicator, calculates the "month count" based on the epoch.
int monthCountFromTibetan(Month monthObject) {
  // the formulas on Svante's paper use western year numbers
  final wYear = monthObject.year - yearDiff;
  final solarMonth = 12 * (wYear - year0) + monthObject.month - month0;
  final hasLeap = isDoubledMonth(monthObject.year, monthObject.month);
  final isLeap = (hasLeap && monthObject.isLeapMonth) ? 1 : 0;

  return ((67 * solarMonth + betaStar + 17) / 65).floor() - isLeap;
}

/// The date at the end of the lunar day (similar to month count since beginning of epoch, but for days)
/// It is calculated by first calculating a simpler mean date, corresponding to the linear mean motion of
/// the moon, and then adjusting it by the equations of the moon and sun, which are determined by the
/// anomalies of the moon and sun together with tables.
double trueDateFromMonthCountDay(num day, int monthCount) {
  return meanDate(day, monthCount) +
      moonEqu(day, monthCount) / 60 -
      sunEqu(day, monthCount) / 60;
}

/// Calculates the julian date from the day count a variant of true_date
/// @param dayCount - the day count since beginning of epoch defined as dayNo + 30 * monthCount
/// @return julian date
int julianFromTrueDate(num dayCount) {
  final monthCount = ((dayCount - 1) / 30).floor();
  final calculatedDay = dayCount % 30 == 0 ? 30 : (dayCount % 30);
  return trueDateFromMonthCountDay(calculatedDay, monthCount).floor();
}

/// Gives the Julian date for a Tibetan year, month number (leap or not) and Tibetan day.
///
/// Does not check that the tibetan day actually exists:
///  - If given the date of a skipped day, will return the same Julian date as the day before.
///  - If given the date of a duplicate day, returns the Julian date of the second of the two.
int julianFromTibetan(int year, int month, bool isLeapMonth, int day) {
  final monthCountVal = monthCountFromTibetan(
    Month(year: year, month: month, isLeapMonth: isLeapMonth),
  );
  return trueDateFromMonthCountDay(day, monthCountVal).floor();
}

/// Get Julian date from UNIX date
/// Fixed bug: now correctly handles timezone normalization
/// See explanation: https://stackoverflow.com/questions/11759992/calculating-jdayjulian-day-in-javascript
int julianFromUnix(DateTime unixTime) {
  final dateOnly = getDateStr(unixTime);
  // Parse at 18:00:00 (noon UTC in Tibetan calendar calculation)
  final parts = dateOnly.split('-');
  final timeAfterNoon = DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
    18,
  );

  final localTimezoneOffset = DateTime.now().timeZoneOffset.inMinutes;
  return ((timeAfterNoon.millisecondsSinceEpoch / msInYear) -
          (localTimezoneOffset / minInDay) +
          julianToUnix)
      .floor();
}

/// Get Unix date from Julian date
/// Fixed bug: was calling .timeZoneOffset on num, now uses DateTime.now().timeZoneOffset
/// Since we use only date calculations here, there is no need to correct for timezone differences
/// See explanation: https://stackoverflow.com/questions/11759992/calculating-jdayjulian-day-in-javascript
DateTime unixFromJulian(num julianDate) {
  final localTimezoneOffset = DateTime.now().timeZoneOffset.inMinutes;
  final unixDate = (julianDate - julianToUnix + localTimezoneOffset / minInDay) *
      msInYear;
  return DateTime.fromMillisecondsSinceEpoch(unixDate.toInt(), isUtc: false);
}
