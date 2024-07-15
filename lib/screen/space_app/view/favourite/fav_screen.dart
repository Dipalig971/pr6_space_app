
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr6_space_app/screen/space_app/modal/space_modal.dart';
import 'package:pr6_space_app/screen/space_app/provider/fav_provider.dart';
import 'package:provider/provider.dart';
import '../../provider/space_provider.dart';
import '../detail/detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    List<SpaceModal> allPlanets = Provider.of<SpaceProvider>(context).jsonData;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Favourite',
          style:TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, likeProvider, child) {
          List<SpaceModal> likedPlanets = allPlanets
              .where((planet) => likeProvider.favoritePlanets.contains(planet.name))
              .toList();

          return Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/image/background.jpg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              likedPlanets.isEmpty
                  ? const Center(
                child: Text('No Liked...', style: TextStyle(color: Colors.white)),
              )
                  : ListView.builder(
                itemCount: likedPlanets.length,
                itemBuilder: (context, index) {
                  SpaceModal space = likedPlanets[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(space: space)),
                      );
                    },
                    leading: Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(space.image),
                    ),
                    title: Text(
                      space.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    subtitle: Text(space.name,
                        style: const TextStyle(color: Colors.grey)),
                    trailing: IconButton(
                      onPressed: () {
                        Provider.of<FavoriteProvider>(context, listen: false)
                            .removeFavoritePlanet(space.name);
                      },
                      icon: const Icon(CupertinoIcons.delete_solid, color: Colors.white),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
