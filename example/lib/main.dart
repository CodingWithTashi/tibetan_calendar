import 'package:flutter/material.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tibetan Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TibetanDate? tibDate;
  TibetanMonth? tibMonth;
  TibetanYear? tibYear;
  late YearAttribute yearAttribute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tibetan Calendar Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final now = DateTime.now();
                  tibDate = TibetanDate.fromWestern(DateTime(now.year, now.month, now.day));
                  tibMonth = TibetanMonth.fromTibetan(
                    year: tibDate!.year,
                    month: tibDate!.month,
                    isLeapMonth: tibDate!.monthObj.isLeapMonth,
                  );
                  tibYear = TibetanYear.fromTibetan(tibDate!.year);
                  yearAttribute = YearAttribute(
                    animal: tibYear!.animal,
                    element: tibYear!.element,
                    gender: tibYear!.gender,
                  );
                  setState(() {});
                },
                child: const Text('Get Today\'s Tibetan Date'),
              ),
              const SizedBox(height: 20),
              if (tibDate != null && tibYear != null) ...[
                // Date Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tibetan Date',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Year: ${tibDate!.year}'),
                        Text('Month: ${tibDate!.month}'),
                        Text('Day: ${tibDate!.date}'),
                        if (tibDate!.isLeapDay) const Text('Leap Day: Yes'),
                        if (tibDate!.isDoubledDay) const Text('Doubled Day: Yes'),
                        if (tibDate!.isSkippedDay) const Text('Skipped Day: Yes'),
                        const SizedBox(height: 8),
                        Text('Western Date: ${tibDate!.westernDateStr}'),
                        Text('Tibetan Format: ${tibDate!.toString()}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Month Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tibetan Month',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Month: ${tibMonth!.month}'),
                        Text('Is Leap Month: ${tibMonth!.isLeapMonth ? "Yes" : "No"}'),
                        Text('Is Doubled Month: ${tibMonth!.isDoubledMonth ? "Yes" : "No"}'),
                        if (tibMonth!.startDateStr.isNotEmpty)
                          Text('Start Date: ${tibMonth!.startDateStr}'),
                        if (tibMonth!.endDateStr.isNotEmpty)
                          Text('End Date: ${tibMonth!.endDateStr}'),
                        const SizedBox(height: 8),
                        Text('Format: ${tibMonth!.toString()}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Year Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tibetan Year',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Tibetan Year: ${tibYear!.tibYearNum}'),
                        Text('Western Year: ${tibYear!.westernYear}'),
                        Text('Animal: ${tibYear!.animal}'),
                        Text('Element: ${tibYear!.element}'),
                        Text('Gender: ${tibYear!.gender}'),
                        Text('Rabjung Cycle: ${tibYear!.rabjungCycle}'),
                        Text('Rabjung Year: ${tibYear!.rabjungYear}'),
                        const SizedBox(height: 8),
                        Text('Rabjung String: ${tibYear!.toRabjungString()}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Losar Date
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Losar (Tibetan New Year)',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Losar for year ${tibYear!.tibYearNum}:'),
                        Text(
                          getLosarForYear(tibYear!.tibYearNum),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                const Text('Click button to get Tibetan date'),
            ],
          ),
        ),
      ),
    );
  }
}
