import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr6_space_app/screen/space_app/modal/space_modal.dart';
import 'package:pr6_space_app/screen/space_app/provider/space_provider.dart';
import 'package:pr6_space_app/screen/space_app/view/detail/detail_screen.dart';
import 'package:provider/provider.dart';

import '../favourite/fav_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late AnimationController animationController;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    SpaceProvider spaceProviderT = Provider.of(context, listen: true);
    SpaceProvider spaceProviderF = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Solar System',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Space App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ));
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/json/json_data.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data!);
            spaceProviderF.convert(data);
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: spaceProviderT.jsonData.length,
                    itemBuilder: (context, index) {
                      SpaceModal space = spaceProviderT.jsonData[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailScreen(space: space),
                          ));
                        },
                        child: Hero(
                          tag: space.hero,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50, left: 20),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 230,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff323232),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 80,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(
                                          space.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          'Velocity: ${space.velocity}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: animationController,
                                builder: (context, child) {
                                  return RotationTransition(
                                    turns: animationController,
                                    child: child,
                                  );
                                },
                                child: Positioned(
                                  left: 20,
                                  bottom: 90,
                                  child: Container(
                                    height: 120,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(space.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
