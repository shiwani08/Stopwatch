import 'package:flutter/material.dart';
import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {

  late Timer _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;

  // to start
  void _startTimer() {
    if(!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedSeconds++;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  // to stop
  void _stopTimer() {
    if(_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  // to reset
  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _elapsedSeconds = 0;
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    if(_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
