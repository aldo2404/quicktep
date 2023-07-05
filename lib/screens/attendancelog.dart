import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceLogScreen extends StatefulWidget {
  const AttendanceLogScreen({super.key});

  @override
  State<AttendanceLogScreen> createState() => _AttendanceLogScreenState();
}

class _AttendanceLogScreenState extends State<AttendanceLogScreen> {
  SharedPreferences? loadData;
  String currentDateTime =
      DateFormat('yMMMMd').format(DateTime.now()).toString();

  List<String> entryDateTime = [];
  List<String> exitDateTime = [];
  String previousDate = '';

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    loadData = await SharedPreferences.getInstance();
    setState(() {
      previousDate = loadData!.getString('currentDate') ?? '';
      entryDateTime = loadData!.getStringList('entryTime') ?? [];
      exitDateTime = loadData!.getStringList('exitTime') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text('Attendance Log'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                ListView.builder(
                    itemCount: entryDateTime.length,
                    itemBuilder: (context, index) {
                      return previousDate != currentDateTime
                          ? logCard(entryDateTime.first, exitDateTime.last)
                          : null;
                    }),
                //logCard()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logCard(String checkIn, String checkOut) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          multipleLog();
        },
        child: Card(
          color: Colors.purpleAccent,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 95,
            // decoration: const BoxDecoration(
            //     color: Color.fromARGB(255, 238, 7, 65),
            //     borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      currentDateTime,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          const Text(
                            'Check-In',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(checkIn)
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          const Text(
                            'Check-Out',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(checkOut)
                        ],
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  multipleLog() {}
}
