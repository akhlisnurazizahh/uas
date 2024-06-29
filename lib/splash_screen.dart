import 'package:flutter/material.dart';
import 'dart:async';
import 'kalender_home_page.dart'; // Import your main screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    const duration = Duration(milliseconds: 500);
    Timer.periodic(duration, (Timer timer) {
      setState(() {
        if (_progressValue >= 1.0) {
          timer.cancel();
          _navigateToMainScreen();
        } else {
          _progressValue += 0.2;
        }
      });
    });
  }

  void _navigateToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KalenderHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'images/b.jpg',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          
            SizedBox(height: 10),
            CircularProgressIndicator(
              value: _progressValue,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),
            ),
              SizedBox(height: 20),
            Text(
              'Kalender',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
