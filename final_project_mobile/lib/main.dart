import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyRight',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 40, 160, 216), foregroundColor: Colors.white,
        toolbarHeight: 80,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.white))
      ) ,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StudyRight", style: TextStyle(fontWeight: FontWeight.w900),),
      ),
      body: const Dashboard(), 
    );
  }
}
