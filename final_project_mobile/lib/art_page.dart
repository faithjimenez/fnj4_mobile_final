import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'flashcard_page.dart';

class ArtPage extends StatefulWidget {
  const ArtPage({super.key});

  @override
  State<ArtPage> createState() => _ArtPageState();
}

class _ArtPageState extends State<ArtPage> {
  final List<String> words = ["Expressionism", "Chiaroscuro", "Surrealism", "Impressionism", "Cubism",];
  final List<Map<String, String>> definitions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDefinitions();
  }

  Future<void> fetchDefinitions() async {
    for (var word in words) {
      final response =
          await http.get(Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meaning = data[0]["meanings"][0]["definitions"][0]["definition"];
        definitions.add({"word": word, "definition": meaning});
      } else {
        definitions.add({"word": word, "definition": "Definition not found."});
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StudyRight"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Art Hist.",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 40, 160, 216)),
                  ),
                  const SizedBox(height: 16),
                   Center(
                    child: ActionChip(
                      label: Text("Start", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      backgroundColor:  Color.fromARGB(255, 40, 160, 216),
                      onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=> FlashcardPage(topic: 'Art',)),
                  );
                }
                      
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("Terms", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: definitions.length,
                      itemBuilder: (context, index) {
                        final item = definitions[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                           color: const Color.fromARGB(255, 216, 228, 238),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["word"]!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(item["definition"]!),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}