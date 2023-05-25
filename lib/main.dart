// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
import "dart:async";
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  bool isRunning = false;
  starttimer() {
    repeatedFunction = Timer.periodic(Duration(milliseconds: 1), (e) {
      setState(() {
        int newseconds = duration.inSeconds - 1;
        duration = Duration(seconds: newseconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 14, 14, 14),
        title: Text(
          "Pomodoro",
          style: TextStyle(fontSize: 27, color: Colors.white),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularPercentIndicator(
            center: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    duration.inMinutes.remainder(60).toString().padLeft(2, "0"),
                    style: TextStyle(fontSize: 80, color: Colors.white)),
                Text(":", style: TextStyle(fontSize: 80, color: Colors.white)),
                Text(
                    duration.inSeconds.remainder(60).toString().padLeft(2, "0"),
                    style: TextStyle(fontSize: 80, color: Colors.white)),
              ],
            ),
            radius: 150,
            lineWidth: 8.0,
            percent: duration.inMinutes / 25,
            animation: true,
            animateFromLastPercent: true,
            animationDuration: 250,
            progressColor: Color.fromARGB(255, 255, 85, 113),
            backgroundColor: Colors.grey,
          ),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          starttimer();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      child: (repeatedFunction!.isActive)
                          ? Text("Stop")
                          : Text("Resume"),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          isRunning = false;
                          duration = Duration(minutes: 25);
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      child: Text("Cancel"),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    starttimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 57, 63, 241)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(17)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "Start Timer",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ]),
      ),
    );
  }
}
