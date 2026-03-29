## [2.0.0]

### Breaking Changes
- **Major refactoring** - Package restructured to match TypeScript source (https://gitlab.com/TibetanCalendar/TibetanDateCalcualtor)
- Removed `intl` dependency - no longer required
- `lib/model.dart` removed - replaced by `lib/src/types.dart` with enhanced type classes

### New Features
- **New API Classes**:
  - `TibetanDate` - Represents a Tibetan date with full conversion support
  - `TibetanMonth` - Represents a Tibetan month with start/end dates and day listing
  - `TibetanYear` - Represents a Tibetan year with Rabjung cycle support
- **New Generator Functions**:
  - `getLosarForYear()` - Calculate Losar (Tibetan New Year) for any Tibetan year
  - `getMonthFromTibetan()` - Get full month information including start/end dates
  - `getYearFromWestern()` / `getYearFromTibetan()` / `getYearFromRabjung()` - Year info with attributes
- **New Day Properties**: `skippedDay`, `isPreviousSkipped`, `isDoubledDay`, `westernDate`
- **New Month Properties**: `isDoubledMonth`, `startDate`, `endDate`
- **Rabjung Cycle Support**: Full support for Rabjung calendrical cycles

### Bug Fixes
- Fixed `moonTab`/`sunTab`: Changed `if (x != null)` to `if (x != 0)` to match JavaScript truthiness
- Fixed `unixFromJulian`: Was calling `.timeZoneOffset` on `num`, now correctly uses `DateTime.timeZoneOffset`
- Fixed `julianFromUnix`: Added proper timezone normalization for UTC DateTime inputs
- Fixed `getDayFromTibetan`: Restored commented-out logic for skipped/doubled day detection
- Fixed timezone offset sign difference between JavaScript and Dart (Dart returns opposite sign)
- Fixed UTC DateTime handling - now correctly converts to local time before date extraction

### Architecture Improvements
- Modular file structure:
  - `lib/src/constants.dart` - All calendar and astronomical constants
  - `lib/src/types.dart` - Data classes (Year, Month, Day, DayMonth, DayBefore, YearAttribute)
  - `lib/src/helpers.dart` - Math and helper functions
  - `lib/src/conversions.dart` - Date conversion functions
  - `lib/src/generators.dart` - High-level generator functions
  - `lib/src/classes.dart` - User-facing classes
- All methods now have explicit return types (no implicit `dynamic`)
- All parameters properly typed
- Replaced Map-based data passing with typed model classes
- Eliminated mutable static `westernDate` shared state

### Backward Compatibility
- Legacy `TibetanCalendar` class maintained for existing code
- All existing tests continue to pass

### Test Coverage
- Expanded from 6 to 43 test cases
- 100% match rate with TypeScript reference implementation (tested over 5 years / 1825 days)

## [0.0.1]

* Tibetan Calendar package can be used to convert normal date to tibetan calendar   

## [0.0.4] 

* Null safety   
* Documentation   
* Version update

## [0.0.5]
* Update code for pub.dev score
* Github Action deployment
* Documentation
* Version update

## [0.0.6] 
* Remove flutter sdk from package
* updated test cases with dart

## [1.0.0] 
* Updated intl version
* Added animal and element scope
* Calculate animal and element for any birth year
* Updated documentation
* Added test cases

## [1.0.1]
* Downgrade intl version because of incompatible with flutter_localizations

## [1.0.2]
* Updated Calendar to TibetanCalendar class
## [1.1.0]
* Updated intl packages
* Fix lints


## [1.1.1]
* Updated intl packages
