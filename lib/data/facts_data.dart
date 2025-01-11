

import 'dart:convert';
import 'package:http/http.dart' as http;

class FactService {
  static const String _url = 'https://uselessfacts.jsph.pl/random.json?language=en';

  Future<String> getRandomFact() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['text'];
    } else {
      throw Exception('Failed to load fact');
    }
  }
}

// final List<String> facts = [
//   "Did you know? Honey never spoils.",
//   "Did you know? A day on Venus is longer than a year on Venus.",
//   "Did you know? Bananas are berries, but strawberries aren't.",
//   // Add more facts here
// ];
//
// String getRandomFact() {
//   final random = Random();
//   return facts[random.nextInt(facts.length)];
// }
