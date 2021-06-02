library tibetan_calendar;

import 'package:intl/intl.dart';

const RABJUNG_BEGINNING = 1027;
// length of rabjung cycle in years
const RABJUNG_CYCLE_LENGTH = 60;
// difference between Western and Tibetan year count
const YEAR_DIFF = 127;
// difference between Unix and Julian date starts
const JULIAN_TO_UNIX = 2440587.5;
// number of milliseconds in a year
const MS_IN_YEAR = 86400000;
// number of minutes in day
const MIN_IN_DAY = 1440;
// calendrical constants: month calculations
// beginning of epoch based on Kalachakra. Used as 0 for month counts since this time
const YEAR0 = 806;
const MONTH0 = 3;
// constants given in Svante's article
const BETA_STAR = 61;
const BETA = 123;
// const P1 = 77 / 90;
// const P0 = 139 / 180;
// const ALPHA = 1 + 827 / 1005;
// calendrical constants: day calculations
// mean date
const M0 = 2015501 + 4783 / 5656;
const M1 = 167025 / 5656;
const M2 = M1 / 30;
// mean sun
const S0 = 743 / 804;
const S1 = 65 / 804;
const S2 = S1 / 30;
// anomaly moon
const A0 = 475 / 3528;
const A1 = 253 / 3528;
const A2 = 1 / 28;
// fixed tables
const MOON_TAB = [0, 5, 10, 15, 19, 22, 24, 25];
const SUN_TAB = [0, 6, 10, 11];
// year elements & animals
const YEAR_ELEMENTS = ['Wood', 'Fire', 'Earth', 'Iron', 'Water'];
const YEAR_ANIMALS = [
  'Mouse',
  'Ox',
  'Tiger',
  'Rabbit',
  'Dragon',
  'Snake',
  'Horse',
  'Sheep',
  'Monkey',
  'Bird',
  'Dog',
  'Pig'
];
const YEAR_GENDER = ['Male', 'Female'];

/// A Calculator.
///
class Calendar {
  final year;
  final month;
  final day;
  final isLeapMonth;
  final isLeapDay;
  Calendar({this.year, this.month, this.day, this.isLeapDay, this.isLeapMonth});
}

class TibetanCalendar {
  static DateTime westernDate = DateTime.now();

  /// Returns [value] plus 1.
  static Calendar getTibetanDate(DateTime arg) {
    westernDate = arg;
    return getDayFromWestern(westernDate);
  }

  static Calendar getDayFromWestern(DateTime date) {
    // const date = new Date(wYear, wMonth - 1, wDay);
    var wYear = date.year;
    var jd = julianFromUnix(date);
    var tibYears = [wYear + YEAR_DIFF - 1, wYear + YEAR_DIFF + 1];

    var monthCounts = [];
    tibYears.forEach((y) {
      monthCounts.add(
          monthCountFromTibetan({'year': y, 'month': 1, 'isLeapMonth': true}));
    });

    /* var monthCounts = tibYears.map((y) {
      return monthCountFromTibetan(
          {'year': y, 'month': 1, 'isLeapMonth': true});
    });*/
    //todo chect list or map
    var trueDate = [];
    monthCounts.forEach((element) {
      trueDate.add((1 + 30 * element));
    });
    var jds = [];
    trueDate.forEach((element) {
      jds.add(julianFromTrueDate(element));
    });
    //   croak "Binary search algorithm is wrong" unless $jd1 <= $jd && $jd <= $jd2;
    while (trueDate[0] < trueDate[1] - 1 && jds[0] < jds[1]) {
      var nTrueDate = ((trueDate[0] + trueDate[1]) / 2).floor();
      var njd = julianFromTrueDate(nTrueDate);
      if (njd < jd) {
        trueDate[0] = nTrueDate;
        jds[0] = njd;
      } else {
        trueDate[1] = nTrueDate;
        jds[1] = njd;
      }
    }
    // so we found it;
    var winnerJd;
    var winnerTrueDate;
    // if the western date is the 1st of a doubled tib. day, then jd[0] == jd - 1 and
    // jd[1] == jd + 1, and the corresponding tib. day number is the one from jd[1].
    if (jds[0] == jd) {
      winnerJd = jds[0]; // eslint-disable-line prefer-destructuring
      winnerTrueDate = trueDate[0]; // eslint-disable-line prefer-destructuring
    } else {
      winnerJd = jds[1]; // eslint-disable-line prefer-destructuring
      winnerTrueDate = trueDate[1]; // eslint-disable-line prefer-destructuring
    }
    // figure out the real tib. date: year, month, leap month, day number, leap day.
    var isLeapDay = winnerJd > jd;
    var monthCount = ((winnerTrueDate - 1) / 30).floor();
    var day;
    if (winnerTrueDate % 30 == 0) {
      day = 30;
    } else {
      day = winnerTrueDate % 30;
    }

    var _a = getMonthFromMonthCount(monthCount);
    var year = _a['year'];
    var month = _a['month'];
    var isLeapMonth = _a['isLeapMonth'];
    return getDayFromTibetan({
      'year': year,
      'month': month,
      'isLeapMonth': isLeapMonth,
      'day': day,
      'isLeapDay': isLeapDay,
    });
    print(jd);
  }

  static julianFromUnix(DateTime unixDate) {
    var date = '${unixDate.year}/${unixDate.month}/${unixDate.day}';
    var dartDate = DateFormat("yyyy/MM/dd HH:mm:ss").parse('$date 18:00:00');
    var unixTime =
        ((dartDate.millisecondsSinceEpoch / 86400000) + 2440587.5).floor();
    return unixTime;
  }

  static monthCountFromTibetan(Map<String, Object> _a) {
    int year = _a['year'];
    int month = _a['month'];
    bool isLeapMonth = _a['isLeapMonth'];
    // the formulas on Svante's paper use western year numbers
    var wYear = year - YEAR_DIFF;
    var solarMonth = 12 * (wYear - YEAR0) + month - MONTH0;
    var hasLeap = isDoubledMonth(year, month);
    var isLeap = hasLeap && isLeapMonth ? 1 : 0;
    return ((67 * solarMonth + BETA_STAR + 17) / 65).floor() - isLeap;
    // return Math.floor((12 * (year - Y0) + monthObject.month - ALPHA - (1 - 12 * S1) * isLeap) / (12 * S1));
  }

  static isDoubledMonth(int tYear, int month) {
    var mp = 12 * (tYear - YEAR_DIFF - YEAR0) + month;
    return (2 * mp) % 65 == BETA % 65 || (2 * mp) % 65 == (BETA + 1) % 65;
  }

  static julianFromTrueDate(num dayCount) {
    var monthCount = ((dayCount - 1) / 30).floor();
    //todo
    var calculatedDay = (dayCount % 30) == 0 ? 30 : (dayCount % 30);
    return (trueDateFromMonthCountDay(calculatedDay, monthCount)).floor();
  }

  static trueDateFromMonthCountDay(num day, int monthCount) {
    return (meanDate(day, monthCount) +
        moonEqu(day, monthCount) / 60 -
        sunEqu(day, monthCount) / 60);
  }

  static meanDate(num day, int monthCount) {
    return monthCount * M1 + day * M2 + M0;
  }

  static moonEqu(num day, int monthCount) {
    return moonTab(28 * moonAnomaly(day, monthCount));
  }

  static sunEqu(num day, int monthCount) {
    return sunTab(12 * sunAnomaly(day, monthCount));
  }

  static moonTab(num i) {
    var a = moonTabInt(i.floor());
    var x = frac(i);
    //todo check not null,0,false
    if (x != null) {
      var b = moonTabInt(i.floor() + 1);
      a += (b - a) * x;
    }
    return a;
  }

  static moonTabInt(int i) {
    var iMod = i % 28;
    if (iMod <= 7) {
      return MOON_TAB[iMod];
    }
    if (iMod <= 14) {
      return MOON_TAB[14 - iMod];
    }
    if (iMod <= 21) {
      return -MOON_TAB[iMod - 14];
    }
    return -MOON_TAB[28 - iMod];
  }

  static num moonAnomaly(num day, int monthCount) {
    return monthCount * A1 + day * A2 + A0;
  }

  static num sunAnomaly(num day, int monthCount) {
    return meanSun(day, monthCount) - 1 / 4;
  }

  static meanSun(num day, int monthCount) {
    return monthCount * S1 + day * S2 + S0;
  }

  static sunTab(num i) {
    var a = sunTabInt(i.floor());
    var x = frac(i);
    //todo check not null,0,false
    if (x != null) {
      var b = sunTabInt(i.floor() + 1);
      a += (b - a) * x;
    }
    return a;
  }

  static sunTabInt(int i) {
    var iMod = i % 12;
    if (iMod <= 3) {
      return SUN_TAB[iMod];
    }
    if (iMod <= 6) {
      return SUN_TAB[6 - iMod];
    }
    if (iMod <= 9) {
      return -SUN_TAB[iMod - 6];
    }
    return -SUN_TAB[12 - iMod];
  }

  static frac(num a) {
    return a % 1;
  }

  static getMonthFromMonthCount(monthCount) {
    var x = ((65 * monthCount + BETA) / 67).ceil();
    var tMonth = amod(x, 12);
    var tYear = (x / 12).ceil() - 1 + YEAR0 + YEAR_DIFF;
    var isLeapMonth = ((65 * (monthCount + 1) + BETA) / 67).ceil() == x;
    return {'year': tYear, 'month': tMonth, 'isLeapMonth': isLeapMonth};
  }

  static amod(a, b) {
    return (a % b) == 0 ? b : (a % b);
  }

  static Calendar getDayFromTibetan(Map<String, dynamic> _a) {
    var year = _a['year'],
        month = _a['month'],
        _b = _a['isLeapMonth'],
        //todo checek leap
        isLeapMonth = _b == null ? false : _b,
        day = _a['day'],
        _c = _a['isLeapDay'],
        //todo checek leap
        isLeapDay = _c == null ? false : _c;
    var julianDate = julianFromTibetan(year, month, isLeapMonth, day);
    // also calculate the Julian date of the previous Tib. day
    var monthCount = monthCountFromTibetan({
      'year': year,
      'month': month,
      'isLeapMonth': isLeapMonth,
    });
    var dayBefore = getDayBefore(day, monthCount);
    var julianDatePrevious =
        (trueDateFromMonthCountDay(dayBefore['day'], dayBefore['monthCount']))
            .floor();
    var twoDaysBefore = getDayBefore(dayBefore['day'], dayBefore['monthCount']);
    var julianDate2DaysBefore = (trueDateFromMonthCountDay(
            twoDaysBefore['day'], twoDaysBefore['monthCount']))
        .floor();
    // figure out leap months, leap days & skipped days
    var isDoubledMonthThis = isDoubledMonth(year, month);
    var hasLeapDayThis = julianDate == julianDatePrevious + 2;
    var skippedDay = julianDate == julianDatePrevious;
    var isPreviousSkipped = julianDatePrevious == julianDate2DaysBefore;
    var isLeapDayChecked = isLeapDay && hasLeapDayThis;
    // figure out western date info for the main or leap day
    if (isLeapDayChecked) {
      julianDate--;
    }
    //get nixdate from julian
    //var westernDate = unixFromJulian(julianDate);
    return Calendar(
        year: year,
        month: month,
        day: day,
        isLeapDay: isLeapDayChecked,
        isLeapMonth: isLeapMonth);
    /*return {
      'year': year,
      'month': {
        'month': month,
        'isLeapMonth': isLeapMonth && isDoubledMonthThis,
        'isDoubledMonth': isDoubledMonthThis,
      },
      'day': day,
      'skippedDay': skippedDay,
      'isPreviousSkipped': isPreviousSkipped,
      'isLeapDay': isLeapDayChecked,
      'isDoubledDay': hasLeapDayThis,
      'westernDate': 'westernDate',
    };*/
  }

  static julianFromTibetan(year, month, isLeapMonth, day) {
    var monthCount = monthCountFromTibetan({
      'year': year,
      'month': month,
      'isLeapMonth': isLeapMonth,
    });
    return (trueDateFromMonthCountDay(day, monthCount)).floor();
  }

  static getDayBefore(day, monthCount) {
    return day == 1
        ? {'day': 30, 'monthCount': monthCount - 1}
        : {'day': day - 1, 'monthCount': monthCount};
  }

  static unixFromJulian(julianDate) {
    var localTimezoneOffset = julianDate.timeZoneOffset.inMilliseconds;
    var unixDate =
        (julianDate - JULIAN_TO_UNIX + localTimezoneOffset / MIN_IN_DAY) *
            MS_IN_YEAR;
    var unix = new DateTime.fromMicrosecondsSinceEpoch(unixDate);
    return unix;
  }
}
