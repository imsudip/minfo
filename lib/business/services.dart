import 'dart:convert';

import 'model.dart';
import 'package:http/http.dart' as http;

class NewsServices {
  static Future<List<Article>> getNewsFromKeyword(String keyword) async {
    NewsResponse newsResponse;
   

    var response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=${keyword}'));
    print(response);
    var convertDataToJson = json.decode(response.body);
    newsResponse = NewsResponse.fromJson(convertDataToJson);
    return newsResponse.data;
  }
}
