import 'package:flutter/material.dart';
import 'package:assignment/features/favourites_screen/screens/favourites.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final String posterUrl;
  final String imdbId;

  const MovieDetailsScreen({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFavourite = false;
  final List<Map<String, String>> favouriteMovies = [];

  final String year = "2023";
  final String description =
      "This is a heartwarming and adventurous animated movie that takes the audience "
      "on an unforgettable journey. With stunning visuals and a gripping storyline, "
      "it captures the essence of courage, love, and determination. The characters "
      "are beautifully crafted, bringing emotions to life in a way that resonates "
      "with viewers of all ages.";
  final String cast = "Cast: John Doe, Jane Smith, Bob Brown";

  void _toggleFavourite() {
    setState(() {
      if (isFavourite) {
        favouriteMovies
            .removeWhere((movie) => movie['imdbId'] == widget.imdbId);
      } else {
        favouriteMovies.add({
          'title': widget.title,
          'posterUrl': widget.posterUrl,
          'imdbId': widget.imdbId,
        });
      }
      isFavourite = !isFavourite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavourite
              ? '${widget.title} added to favourites!'
              : '${widget.title} removed from favourites!',
        ),
      ),
    );
  }

  void _playMovie() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Play button clicked!')),
    );
  }

  void _downloadContent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download button clicked!')),
    );
  }

  void _navigateToFavourites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FavouritesScreen(favouriteMovies: favouriteMovies),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Movie Details'),
        actions: [
          IconButton(
            onPressed: _toggleFavourite,
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            tooltip:
                isFavourite ? 'Remove from Favourites' : 'Add to Favourites',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _navigateToFavourites,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.green),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Your Favourites',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.posterUrl.isNotEmpty
                    ? Image.network(
                        widget.posterUrl,
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            size: 100,
                          );
                        },
                      )
                    : const Icon(
                        Icons.movie,
                        size: 100,
                      ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'IMDb ID: ${widget.imdbId}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Year: $year',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            '4.0',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < 4 ? Icons.star : Icons.star_border,
                                color: index < 4 ? Colors.yellow : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Dolby Atmos',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _playMovie,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Play',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _downloadContent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'S1: E1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              cast,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
