class GetModel {
  final String responseText;

  GetModel({required this.responseText});

  factory GetModel.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null && json['candidates'].isNotEmpty) {
      var candidate = json['candidates'][0];
      if (candidate['content'] != null && candidate['content']['parts'] != null && candidate['content']['parts'].isNotEmpty) {
        return GetModel(
          responseText: candidate['content']['parts'][0]['text'],
        );
      }
    }
    throw Exception("Invalid response format");
  }
}
