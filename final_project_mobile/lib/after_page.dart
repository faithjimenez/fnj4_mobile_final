import 'package:final_project_mobile/dashboard.dart';
import 'package:flutter/material.dart';
import 'flashcard_page.dart';

class AfterPage extends StatefulWidget {
  final String topic;
  const AfterPage({super.key, required this.topic}); // Accept topic

  @override
  State<AfterPage> createState() => _AfterPageState();
}

class _AfterPageState extends State<AfterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("StudyRight"),
      ),
      body:Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "All Done! Want to Study Again?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => FlashcardPage(topic: widget.topic),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 40, 160, 216),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                "Study Again",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                 Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: FilledButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 40, 160, 216),
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              ),
              child: const Text(
                "Home",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )
      )
    );
  }
}
