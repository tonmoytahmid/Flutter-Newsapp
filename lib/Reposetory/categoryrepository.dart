import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newspaperapp/Models/categorymodel.dart';


class Categoryrepository {

Future<Categorymodel?> newsCategory(String name) async {
    String Url =
        'https://newsapi.org/v2/top-headlines?category=$name&apiKey=24ec1e6573184801957f80d5e68fd27b';
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Categorymodel.fromJson(body);
    }
    throw Exception("error");
  }
  
}