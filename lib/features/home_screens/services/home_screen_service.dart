import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String apiUrl = 'https://api.sampleapis.com/movies/animation';

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final List movies = jsonDecode(response.body);
        return movies.map((e) => Movie.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error occurred while fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }
}

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String imdbId;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      posterUrl: json['posterURL'] ?? '',
      imdbId: json['imdbId'] ?? '',
    );
  }
}
