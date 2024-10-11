import 'dart:convert';
import 'package:http/http.dart' as http;

class JobService {
  final String url = 'https://api.cognospheredynamics.com/api/auth/getallJobs';

  Future<List<dynamic>> fetchJobs() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['jobs'];
    } else {
      throw Exception('Failed to load jobs');
    }
  }


  final String baseUrl2 = 'https://api.cognospheredynamics.com/api/auth/getSingleJob/';

  Future<Job> fetchJobDetails(int jobId) async {
  final response = await http.get(Uri.parse('$baseUrl2$jobId'));

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  return Job.fromJson(data['job']);
  } else {
  throw Exception('Failed to load job details');
  }
  }
  }

  class Job {
  final int id;
  final String title;
  final String description;
  final List<Description> descriptions;

  final String location;
  final String amount;
  final String jobStatus;
  final String jobNature;
  final String image;

  Job({
  required this.id,
  required this.title,
  required this.description,
    required this.descriptions,

  required this.location,
  required this.amount,
  required this.jobStatus,
  required this.jobNature,
  required this.image,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
  return Job(
  id: json['id'],
  title: json['title'] ?? 'No title provided',
  description: json['description'] ?? 'No description available',
  location: json['location'] ?? 'No location specified',
  amount: json['amount'] ?? 'No amount provided',
    descriptions:(json['descriptions'] as List)
        .map((desc) => Description.fromJson(desc))
        .toList(),
  jobStatus: json['job_status'] ?? 'Status unavailable',
  jobNature: json['job_nature'] ?? 'Nature unspecified',
  image: 'https://api.cognospheredynamics.com/storage/${json['image']}',
  );
  }}


class Description {
  final String name;

  Description({required this.name});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      name: json['name'] ??
          'No name available', // Provide a default value if 'name' is null
    );
  }
}


