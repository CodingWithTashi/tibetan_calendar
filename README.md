# tibetan_calendar

Tibetan Calendar 

## Getting Started

Lunar calendar library for Dart Native.
Computing lunar calendar by timezone.

| ![Image](https://github.com/CodingWithTashi/tibetan_calendar/blob/master/calendar.PNG?raw=true) | ![Image](https://github.com/CodingWithTashi/tibetan_calendar/blob/master/calendar.PNG?raw=true) |
| :------------: | :------------: |
| **Tibetan Calendar** | **Western Calendar** |

## Using

Import the library:
```dart
import 'package:tibetan_calendar/tibetan_calendar.dart';

```

<br>
Convert calendar from from western calendar to tibetan calendar.
<br>
For example:

```dart
var now = DateTime.now();
tibDate = TibetanCalendar.getTibetanDate(DateTime(now.year, now.month, now.day));
print(tibDate.year);  // 2148
print(tibDate.month); // 4
print(tibDate.day);   // 25
```
