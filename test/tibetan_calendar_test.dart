import 'package:flutter_test/flutter_test.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';

void main() {
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
}
