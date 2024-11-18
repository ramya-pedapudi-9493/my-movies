import 'package:flutter/material.dart';
import 'package:assignment/features/home_screens/screens/home_screen.dart';
import 'package:assignment/features/profile_screen/screens/profile.dart';
import 'package:assignment/features/favourites_screen/screens/favourites.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Tracks the currently selected tab index
  final List<Map<String, String>> favouriteMovies = [];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      FavouritesScreen(favouriteMovies: favouriteMovies),
      const ProfileScreen(),
    ];
  }

  void _updateFavourites(List<Map<String, String>> updatedFavourites) {
    setState(() {
      favouriteMovies.clear();
      favouriteMovies.addAll(updatedFavourites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red, // Color for the selected item
        unselectedItemColor: Colors.black, // Color for unselected items
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}
