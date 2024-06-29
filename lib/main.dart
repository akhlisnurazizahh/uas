import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(KalenderApp());
}

class KalenderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalender Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: SplashScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('id', 'ID'), // Indonesian
        const Locale('en', 'US'), // English
        // Add other supported locales
      ],
    );
  }
}
