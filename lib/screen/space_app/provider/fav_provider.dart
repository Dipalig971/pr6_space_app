import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  static const String favoritePlanetsKey = 'favoritePlanets';
  List<String> favoritePlanets = [];

  FavoriteProvider() {
    _loadFavoritePlanets();
  }

  void _loadFavoritePlanets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoritePlanets = prefs.getStringList(favoritePlanetsKey) ?? [];
    notifyListeners();
  }

  Future<void> addFavoritePlanet(String planetName) async {
    if (!favoritePlanets.contains(planetName)) {
      favoritePlanets.add(planetName);
      await _updateFavoritePlanets();
      notifyListeners();
    }
  }

  Future<void> removeFavoritePlanet(String planetName) async {
    if (favoritePlanets.contains(planetName)) {
      favoritePlanets.remove(planetName);
      await _updateFavoritePlanets();
      notifyListeners();
    }
  }

  Future<void> _updateFavoritePlanets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoritePlanetsKey, favoritePlanets);
  }
}
