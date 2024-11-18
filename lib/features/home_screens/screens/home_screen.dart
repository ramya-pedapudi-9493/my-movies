import 'package:assignment/features/home_screens/services/home_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:assignment/features/provider/home_screen_provider.dart';
import 'package:assignment/features/movie_details_screen/screens/movie_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch movies when the HomeScreen initializes
    _fetchMovies();
    Future.microtask(
        () => Provider.of<MovieProvider>(context, listen: false).fetchMovies());
  }

  void _fetchMovies() async {
    try {
      await Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    } catch (e) {
      // Display an error message in the UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to load movies. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('My Movies'),
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: movieProvider.filterMovies,
                    decoration: const InputDecoration(
                      hintText: 'Search movies by title...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                if (movieProvider.movies.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Latest Releases:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (movieProvider.movies.isNotEmpty)
                  _buildCarousel(movieProvider),
                Expanded(
                  child: movieProvider.filteredMovies.isEmpty
                      ? const Center(child: Text('No movies found'))
                      : ListView.builder(
                          itemCount: movieProvider.filteredMovies.length,
                          itemBuilder: (context, index) {
                            final movie = movieProvider.filteredMovies[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              leading: GestureDetector(
                                onTap: () {
                                  _navigateToDetails(context, movie);
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 75,
                                  child: Image.network(
                                    movie.posterUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image,
                                          size: 50);
                                    },
                                  ),
                                ),
                              ),
                              title: GestureDetector(
                                onTap: () {
                                  _navigateToDetails(context, movie);
                                },
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              subtitle: GestureDetector(
                                onTap: () {
                                  _navigateToDetails(context, movie);
                                },
                                child: Text(
                                  'IMDb ID: ${movie.imdbId}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildCarousel(MovieProvider movieProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: movieProvider.movies.take(5).map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => _navigateToDetails(context, movie),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            movie.posterUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 50);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
          title: movie.title,
          posterUrl: movie.posterUrl,
          imdbId: movie.imdbId,
        ),
      ),
    );
  }
}
