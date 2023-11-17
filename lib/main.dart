import 'package:flutter/material.dart';
import 'package:ringo/helpers/routes_helper.dart';
import 'package:ringo/screens/configuration_screen.dart';
import 'package:ringo/screens/extrato_screen.dart';
import 'package:ringo/screens/home_screen.dart';
import 'package:ringo/screens/reports_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ringo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.greenAccent),
      routes: {
        RingoRoutes.home: (ctx) => const HomeScreen(),
        RingoRoutes.extrato: (ctx) => const ExtratoScreen(),
        RingoRoutes.configuration: (ctx) => const ConfigurationScreen(),
        RingoRoutes.reports: (ctx) => const ReportsScreen()
      },
    );
  }
}
