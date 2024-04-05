import 'package:flutter/material.dart';
import 'package:todo/Screen/Splash_Screen.dart';
import 'package:todo/widget/BottomBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff8687E7),
          onPrimary: Colors.white,
          secondary: Color(0xff363636),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        checkboxTheme: const CheckboxThemeData(
          side: BorderSide(
            color: Color.fromARGB(255, 233, 213, 213),
            width: 1,
          ),
          shape: CircleBorder(),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff8687E7),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xffafafaf),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Color(0xffafafaf),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
          bodyLarge: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
