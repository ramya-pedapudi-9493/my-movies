import 'package:flutter/material.dart';
import 'package:assignment/features/home_screens/services/home_screen_service.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  List<Movie> _filteredMovies = [];
  List<Movie> get filteredMovies => _filteredMovies;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  MovieProvider() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      _isLoading = true;
      notifyListeners();
      final movies = await _movieService.fetchMovies();
      _movies = movies;
      _filteredMovies = movies;
    } catch (error) {
      debugPrint('Failed to load movies: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterMovies(String query) {
    _searchQuery = query;
    _filteredMovies = _movies
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
