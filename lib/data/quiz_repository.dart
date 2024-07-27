import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/question.dart';





class QuizRepository {
  final String baseUrl = 'https://opentdb.com/api.php';

  Future<List<Question>> fetchQuestions({
    int amount = 10,
    String? category,
    String? difficulty,
    String? type,
    String? encoding,
  }) async {
    final Map<String, String> queryParameters = {
      'amount': amount.toString(),
    };

    if (category != null && category != 'Any Category') queryParameters['category'] = category;
    if (difficulty != null) queryParameters['difficulty'] = difficulty;
    if (type != null) queryParameters['type'] = type;
    if (encoding != null) queryParameters['encoding'] = encoding;

    final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    print('uri is $uri');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        print("success generating the questions");
        final data = jsonDecode(response.body);

        final List<Question> questions = (data['results'] as List)
            .map((json) => Question.fromJson(json))
            .toList();

        print('the entire questions');
        print(questions);

        if (questions.isEmpty) {
          print(true);
          throw Exception('No questions available.');
        }

        return questions;
      } else {
        throw Exception('Failed to load questions');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request to fetch questions timed out.',);
    }
  }
}




// class QuizRepository {
//   final String baseUrl = 'https://opentdb.com/api.php';
//
//   Future<List<Question>> fetchQuestions({
//     int amount = 10,
//     String? category,
//     String? difficulty,
//     String? type,
//     String? encoding,
//   }) async {
//     final Map<String, String> queryParameters = {
//       'amount': amount.toString(),
//     };
//
//     if (category != null && category != 'Any Category') queryParameters['category'] = category;
//     if (difficulty != null) queryParameters['difficulty'] = difficulty;
//     if (type != null) queryParameters['type'] = type;
//     if (encoding != null) queryParameters['encoding'] = encoding;
//
//     final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
//     print('uri is $uri');
//     final response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       print("success generating the questions");
//       final data = jsonDecode(response.body);
//
//       final List<Question> questions = (data['results'] as List)
//           .map((json) => Question.fromJson(json))
//           .toList();
//       print('the entire questions');
//       print(questions);
//       return questions;
//     } else {
//       print(false);
//       throw Exception('Failed to load questions');
//     }
//   }
// }
