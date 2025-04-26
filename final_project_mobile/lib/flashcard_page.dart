import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'after_page.dart';

class FlashcardPage extends StatefulWidget {
  final String topic;

  FlashcardPage({required this.topic});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Map<String, String>> flashcards = [];
  int currentIndex = 0;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    fetchWords(widget.topic);
  }

  void fetchWords(String topic) async {
    final words = _getWordsForTopic(topic);

    for (String word in words) {
      final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final definition = data[0]["meanings"][0]["definitions"][0]["definition"];
        flashcards.add({'word': word, 'definition': definition});
      }
    }

    setState(() {});
  }

  List<String> _getWordsForTopic(String topic) {
    switch (topic.toLowerCase()) {
      case 'vocab':
        return ['Exciting', 'Uncertainty', 'Benevolence', 'Assuage', 'Hesitation',];
      case 'art':
        return ['Chiaroscuro', 'Surrealism', 'Impressionism', 'Cubism'];
      case 'science':
        return ['Cytokinesis', 'Mitosis', 'Metaphase', 'Anaphase', 'Interphase'];
      default:
        return [];
    }
  }

  void _nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
      isFlipped = false;
    });
  }

  void _previousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + flashcards.length) % flashcards.length;
      isFlipped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (flashcards.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final currentCard = flashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('StudyRight')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Click to flip!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color:  Color.fromARGB(255, 40, 160, 216))),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFlipped = !isFlipped;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: 350,
                height: 270,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 228, 238),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  isFlipped ? currentCard['definition']! : currentCard['word']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.arrow_left), onPressed: _previousCard),
                IconButton(icon: Icon(Icons.arrow_right), onPressed: nextCard),
              ],
            )
          ],
        ),
      ),
    );
  }

 void nextCard() {
  if (currentIndex == flashcards.length - 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AfterPage(topic: widget.topic)),
    );
  } else {
    setState(() {
      currentIndex++;
      isFlipped = false;
    });
  }
}




}
