import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier{
  static const String favKey = 'favoritePlanets';
  List<String> favPlanet= [];

  Future<void> loadFavorite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favPlanet = sharedPreferences.getStringList(favKey) ?? [];
    notifyListeners();
  }

  Future<void> addFavPlanet(String name) async {
    if(!favPlanet.contains(name)){
      favPlanet.add(name);
      await updatePlanet();
      notifyListeners();
    }
  }

  Future<void> removeFavPlanet(String name) async {
    if(favPlanet.contains(name)){
      favPlanet.remove(name);
     await updatePlanet();
      notifyListeners();
    }
  }

  Future<void> updatePlanet() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList(favKey, favPlanet);
  }
}



// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FavoriteProvider extends ChangeNotifier {
//   static const String favoritePlanetsKey = 'favoritePlanets';
//   List<String> favoritePlanets = [];
//
//   FavoriteProvider() {
//     _loadFavoritePlanets();
//   }
//
//   void _loadFavoritePlanets() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     favoritePlanets = prefs.getStringList(favoritePlanetsKey) ?? [];
//     notifyListeners();
//   }
//
//   Future<void> addFavoritePlanet(String planetName) async {
//     if (!favoritePlanets.contains(planetName)) {
//       favoritePlanets.add(planetName);
//       await _updateFavoritePlanets();
//       notifyListeners();
//     }
//   }
//
//   Future<void> removeFavoritePlanet(String planetName) async {
//     if (favoritePlanets.contains(planetName)) {
//       favoritePlanets.remove(planetName);
//       await _updateFavoritePlanets();
//       notifyListeners();
//     }
//   }
//
//   Future<void> _updateFavoritePlanets() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(favoritePlanetsKey, favoritePlanets);
//   }
// }
