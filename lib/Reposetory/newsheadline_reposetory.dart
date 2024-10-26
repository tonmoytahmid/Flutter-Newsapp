import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/newsheadline_model.dart';

class Newsheadline_reposetory {
  Future<Newsheadline_model?> newsheadlinerepo() async {
    String Url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=24ec1e6573184801957f80d5e68fd27b';
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Newsheadline_model.fromJson(body);
    }
    throw Exception("error");
  }
}
