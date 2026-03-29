import 'package:tibetan_calendar/src/constants.dart';
import 'package:tibetan_calendar/src/types.dart';

/// Fraction part of a number
double frac(num a) {
  return a % 1;
}

/// Modulo of a number (a % b), but from 1..b instead of 0..b-1.
/// This means that amod(a, b) = a % b unless a is a multiple of b.
/// In that case: a % b = 0 but amod(a, b) = b.
int amod(int a, int b) {
  return (a % b) == 0 ? b : (a % b);
}

/// meanDate(day, monthCount) - corresponding to the linear mean motion of the moon
double meanDate(num day, int monthCount) {
  return monthCount * m1 + day * m2 + m0;
}

/// The anomaly of the moon
double moonAnomaly(num day, int monthCount) {
  return monthCount * a1 + day * a2 + a0;
}

/// Moon tab for integer values
int moonTabInt(int i) {
  final iMod = i % 28;
  if (iMod <= 7) {
    return moonTab[iMod];
  }
  if (iMod <= 14) {
    return moonTab[14 - iMod];
  }
  if (iMod <= 21) {
    return -moonTab[iMod - 14];
  }
  return -moonTab[28 - iMod];
}

/// Moon tab, with linear interpolation
/// Fixed bug: changed from `if (x != null)` to `if (x != 0)` to match JS truthiness
double moonTabValue(num i) {
  double a = moonTabInt(i.floor()).toDouble();
  final x = frac(i);
  if (x != 0) {
    // In JS, the check was `if (x)` which checks truthiness
    // In Dart, we need to explicitly check if x is not zero
    final b = moonTabInt(i.floor() + 1).toDouble();
    a += (b - a) * x;
  }
  return a;
}

/// Equation of the moon
double moonEqu(num day, int monthCount) {
  return moonTabValue(28 * moonAnomaly(day, monthCount));
}

/// The mean longitude of the sun
double meanSun(num day, int monthCount) {
  return monthCount * s1 + day * s2 + s0;
}

/// Sun anomaly
double sunAnomaly(num day, int monthCount) {
  return meanSun(day, monthCount) - 1 / 4;
}

/// Sun tab for integer values
int sunTabInt(int i) {
  final iMod = i % 12;
  if (iMod <= 3) {
    return sunTab[iMod];
  }
  if (iMod <= 6) {
    return sunTab[6 - iMod];
  }
  if (iMod <= 9) {
    return -sunTab[iMod - 6];
  }
  return -sunTab[12 - iMod];
}

/// Sun tab, with linear interpolation
/// Fixed bug: changed from `if (x != null)` to `if (x != 0)` to match JS truthiness
double sunTabValue(num i) {
  double a = sunTabInt(i.floor()).toDouble();
  final x = frac(i);
  if (x != 0) {
    // In JS, the check was `if (x)` which checks truthiness
    // In Dart, we need to explicitly check if x is not zero
    final b = sunTabInt(i.floor() + 1).toDouble();
    a += (b - a) * x;
  }
  return a;
}

/// Equation of the sun
double sunEqu(num day, int monthCount) {
  return sunTabValue(12 * sunAnomaly(day, monthCount));
}

/// Calculates whether a given Tibetan year and month number is doubled,
/// i.e. is preceded by a leap month.
bool isDoubledMonth(int tYear, int month) {
  final mp = 12 * (tYear - yearDiff - year0) + month;
  return (2 * mp) % 65 == beta % 65 || (2 * mp) % 65 == (beta + 1) % 65;
}

/// Subtract 1 day from a date
DayBefore getDayBefore(int day, int monthCount) {
  return day == 1
      ? DayBefore(day: 30, monthCount: monthCount - 1)
      : DayBefore(day: day - 1, monthCount: monthCount);
}

/// Get date string in YYYY-MM-DD format
String getDateStr(DateTime date) {
  final year = date.year;
  final month = date.month;
  final dayNr = date.day;
  return '$year-${month.toString().padLeft(2, '0')}-${dayNr.toString().padLeft(2, '0')}';
}

/// Figure out the animal and element for a tibetan year
Year yearAttributes(Year year) {
  final y = year.tibYear;

  return year.copyWith(
    animal: yearAnimals[(y + 1) % 12],
    element: yearElements[((y - 1) ~/ 2) % 5],
    gender: yearGender[(y + 1) % 2],
  );
}
