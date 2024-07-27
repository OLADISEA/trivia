import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/category_data.dart';
import '../../auth/widgets/submit_button.dart';
import '../quiz_page.dart';

class QuizParameterPage extends StatefulWidget {
  final String title;
  final int index;
  const QuizParameterPage({super.key, required this.title, required this.index});

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
    _selectedCategory = categories.where((category) => category.name == widget.title).first.id;
    //_selectedCategory = widget.title;
    if (kDebugMode) {
      print(_selectedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Parameters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Difficulty',
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                ),

              ),
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
            SizedBox(height: 20.h,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Type',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
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
            SizedBox(height: 20.h,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Number of Questions',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
              ),
              initialValue: '10',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _selectedAmount = int.tryParse(value) ?? 10;
                });
              },
            ),
            SizedBox(height: 15.h,),

            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                text: "Start Quiz",
                color: Color(0xff2e99e9),
                textColor: Colors.white,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizPage(
                              amount: _selectedAmount,
                              category: _selectedCategory,
                              difficulty: _selectedDifficulty,
                              type: _selectedType,
                            ),
                      ));
                }
               ))
          ],
        ),
      ),
    );
  }
}
