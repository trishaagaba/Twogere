import 'dart:convert';
import 'package:http/http.dart' as http;

class LearnService {
  final String _baseUrl = 'https://api.cognospheredynamics.com/api/auth/getallTrainings';

  Future<List<Training>> fetchTrainings() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['Learnings'];
      return data.map((json) => Training.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trainings');
    }
  }

  Future<Training> fetchSingleTraining(int topicId) async {
    final response = await http.get(
      Uri.parse('https://api.cognospheredynamics.com/api/auth/getSingleTraining/$topicId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Training.fromJson(data);
    } else {
      throw Exception('Failed to load training');
    }
  }

}

class Training {
  final int topicId;
  final String title;
  final String description;
  final String organisationId;
  final String image; // Add this field for the image


  Training({
    required this.topicId,
    required this.title,
    required this.description,
    required this.organisationId,
    required this.image,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      topicId: json['id'],
      title: json['title'],
      description: json['description'],
      organisationId: json['organisation_id'],
      image:'https://api.cognospheredynamics.com/storage/${json['image']}',
    );
  }

}
