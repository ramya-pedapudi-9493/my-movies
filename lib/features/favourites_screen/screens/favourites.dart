import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  final List<Map<String, String>> favouriteMovies;

  const FavouritesScreen({Key? key, required this.favouriteMovies})
      : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late List<Map<String, String>> _favouriteMovies;

  @override
  void initState() {
    super.initState();
    _favouriteMovies = widget.favouriteMovies;
  }

  void _removeFromFavourites(String imdbId) {
    setState(() {
      _favouriteMovies.removeWhere((movie) => movie['imdbId'] == imdbId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Movie removed from favourites!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Favourites'),
      ),
      body: _favouriteMovies.isEmpty
          ? const Center(
              child: Text(
                'No favourite movies yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _favouriteMovies.length,
              itemBuilder: (context, index) {
                final movie = _favouriteMovies[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 75,
                    child: Image.network(
                      movie['posterUrl'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                  title: Text(movie['title'] ?? ''),
                  subtitle: Text('IMDb ID: ${movie['imdbId'] ?? ''}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _removeFromFavourites(movie['imdbId'] ?? '');
                    },
                  ),
                );
              },
            ),
    );
  }
}
