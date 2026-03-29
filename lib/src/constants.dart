// CONSTANTS

// conversion constants

/// The beginning of the Rabjung count according to Western calendar, A.D. 1027
const int rabjungBeginning = 1027;

/// length of rabjung cycle in years
const int rabjungCycleLength = 60;

/// difference between Western and Tibetan year count
const int yearDiff = 127;

/// difference between Unix and Julian date starts
const double julianToUnix = 2440587.5;

/// number of milliseconds in a year
const int msInYear = 86400000;

/// number of minutes in day
const int minInDay = 1440;

// calendrical constants: month calculations

// beginning of epoch based on Kalachakra. Used as 0 for month counts since this time
const int year0 = 806;
const int month0 = 3;

// constants given in Svante's article
const int betaStar = 61;
const int beta = 123;

// calendrical constants: day calculations
// mean date
const double m0 = 2015501 + 4783 / 5656;
const double m1 = 167025 / 5656;
const double m2 = m1 / 30;

// mean sun
const double s0 = 743 / 804;
const double s1 = 65 / 804;
const double s2 = s1 / 30;

// anomaly moon
const double a0 = 475 / 3528;
const double a1 = 253 / 3528;
const double a2 = 1 / 28;

// fixed tables
const List<int> moonTab = [0, 5, 10, 15, 19, 22, 24, 25];
const List<int> sunTab = [0, 6, 10, 11];

// year elements & animals
const List<String> yearElements = ['Wood', 'Fire', 'Earth', 'Iron', 'Water'];
const List<String> yearAnimals = [
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
const List<String> yearGender = ['Male', 'Female'];
