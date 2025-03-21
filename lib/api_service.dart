import 'dart:convert';
import 'package:http/http.dart' as http;
import "api_model.dart";
class GetResult {
  Future<GetModel?> getResult(String prompt) async {
  const String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDvK9fR-M-rANIbdTyV7eC4B3hU4jxFZms";
  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      return GetModel.fromJson(json.decode(response.body));
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Exception: ${e.toString()}");
  }
  return null;
}
}