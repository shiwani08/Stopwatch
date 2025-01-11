import 'package:flutter/material.dart';
import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  late Timer _timer;
  int _elapsedMilliseconds = 0; // Changed from seconds to milliseconds
  bool _isRunning = false;

  // Start the stopwatch
  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          _elapsedMilliseconds += 10;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  // Stop the stopwatch
  void _stopTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  // Reset the stopwatch
  void _resetTimer() {
    if (_isRunning) {
      _timer.cancel();
    }
    setState(() {
      _elapsedMilliseconds = 0; // Reset to 0
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int hours = _elapsedMilliseconds ~/ (3600 * 1000);
    final int minutes = (_elapsedMilliseconds % (3600 * 1000)) ~/ (60 * 1000);
    final int seconds = (_elapsedMilliseconds % (60 * 1000)) ~/ 1000;
    final int milliseconds = _elapsedMilliseconds % 1000;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Stopwatch",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0), // Height of the border
          child: Container(
            color: Colors.grey, // Border color
            height: 2.0,        // Border thickness
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display time with milliseconds
            Text(
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    "Stop",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}