# tibetan_calendar

Tibetan Calendar 

## Demo

Lunar calendar library for Dart Native.
Computing lunar calendar by timezone. Download app from [PlayStore](https://play.google.com/store/apps/details?id=com.codingwithtashi.tibetan_calender&hl=en_IN&gl=US).

| ![Image](https://github.com/CodingWithTashi/tibetan_calendar/blob/master/calendar.PNG?raw=true) | ![Image](https://github.com/CodingWithTashi/tibetan_calendar/blob/master/calendar.PNG?raw=true) |
| :------------: | :------------: |
| **Tibetan Calendar** | **Western Calendar** |

## Add package

```dart
tibetan_calendar: 0.0.6

```   
## Import the library:
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

If you have any questions, feedback or ideas, feel free to [create an
issue](https://github.com/CodingWithTashi/tibetan_calendar/issues/new). If you enjoy this
project, I'd appreciate your [🌟 on GitHub](https://github.com/CodingWithTashi/tibetan_calendar/).

## You can also buy me a cup of coffee
<a href="https://www.buymeacoffee.com/codingwithtashi"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width=200px></a>

