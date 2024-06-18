import 'package:flutter/material.dart';
import 'package:trivia/features/quiz/presentation/quiz_page.dart';

import '../data/category_data.dart';

class QuizParameterPage extends StatefulWidget {
  final String title;
  const QuizParameterPage({super.key, required this.title});

  @override
  _QuizParameterPageState createState() => _QuizParameterPageState();
}

class _QuizParameterPageState extends State<QuizParameterPage> {
  String? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedType;
  int _selectedAmount = 10;

  final List<String> _difficulties = ['easy', 'medium', 'hard'];
  final List<String> _types = ['multiple', 'boolean'];

  @override
  void initState() {
    super.initState();
    // Initialize _selectedCategory with widget.title
    _selectedCategory = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Parameters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              value: _selectedCategory, // Set initial value here
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Difficulty'),
              items: _difficulties.map((difficulty) {
                return DropdownMenuItem<String>(
                  value: difficulty,
                  child: Text(difficulty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDifficulty = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              items: _types.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Number of Questions'),
              initialValue: '10',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _selectedAmount = int.tryParse(value) ?? 10;
                });
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        amount: _selectedAmount,
                        category: _selectedCategory,
                        difficulty: _selectedDifficulty,
                        type: _selectedType,
                      ),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
