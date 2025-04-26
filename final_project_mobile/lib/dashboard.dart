import 'package:flutter/material.dart';
import 'vocab_page.dart';
import 'art_page.dart';
import 'science_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  void navigateToDeck(BuildContext context, String deckName) {
    print("Tapped on $deckName");
    // You can use Navigator.push to go to another screen if needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 24),
              const Text(
                "Flashcards",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color:Color.fromARGB(255, 40, 160, 216)),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pick a deck to start learning!",
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 24),
              FlashcardDeckTile(
                title: "Vocab",
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=> const VocabPage()),
                  );
                }
              ),
              FlashcardDeckTile(
                title: "Science",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SciencePage(),),
                  );
                },
              ),
              FlashcardDeckTile(
                title: "Art Hist.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const ArtPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlashcardDeckTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const FlashcardDeckTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 166, 223, 249), Color.fromARGB(255, 40, 160, 216),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
