import 'package:flutter/material.dart';
import 'package:flutter_futurama/ui/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.black,
            textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.black), titleMedium: TextStyle(color: Colors.black))),
        darkTheme: ThemeData(
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: Colors.black,
            primaryColor: Colors.white,
            unselectedWidgetColor: Colors.grey,
            textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.white), titleMedium: TextStyle(color: Colors.white))),
        home: const HomeScreen());
  }
}
