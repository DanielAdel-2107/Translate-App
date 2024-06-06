import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String inputLanguage = 'ar';
  String outputLanguage = 'en';
  String inputText = '';
  List<String> language = ['en', 'ar', 'fr', 'es', 'de', 'ur', 'hi'];
  final outputController = TextEditingController(text: 'Result here...');
  final translator = GoogleTranslator();
  Future<void> traslateText() async {
    final translated = await translator.translate(inputText,
        from: inputLanguage, to: outputLanguage);
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    outputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
                TextField(
                  onChanged: (value) {
                    inputText = value;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter text to translate'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        items: language
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: inputLanguage,
                        onChanged: (value) {
                          setState(() {
                            inputLanguage = value!;
                          });
                        },
                      ),
                      const Icon(Icons.arrow_forward_sharp),
                      DropdownButton<String>(
                        items: language
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: outputLanguage,
                        onChanged: (value) {
                          setState(() {
                            outputLanguage = value!;
                          });
                        },
                      )
                    ]),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  readOnly: true,
                  controller: outputController,
                  onChanged: (value) {
                    inputText = value;
                    setState(() {});
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55)),
                    onPressed: traslateText,
                    child: const Text('Translate'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
