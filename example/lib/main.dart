import 'package:flutter/material.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TibetanCalendar? tibDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Get Today Date'),
                onPressed: () {
                  var now = DateTime.now();
                  tibDate = TibetanCalendar.getTibetanDate(
                      DateTime(now.year, now.month, now.day));
                  setState(() {});
                },
              ),
              SizedBox(
                height: 20,
              ),
              tibDate != null
                  ? Text('${tibDate!.day}/${tibDate!.month}/${tibDate!.year}'+' ')
                  : Text('Click button')
            ],
          ),
        ),
      ),
    );
  }
}
