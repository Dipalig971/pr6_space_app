import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:pr6_space_app/screen/space_app/modal/space_modal.dart';
import 'package:pr6_space_app/screen/space_app/provider/fav_provider.dart';
import 'package:pr6_space_app/screen/space_app/provider/space_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final SpaceModal space;

  const DetailScreen({Key? key, required this.space}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000))
      ..repeat();

    FavoriteProvider likeProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    isLiked = likeProvider.favPlanet.contains(widget.space.name);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SpaceProvider spaceProvider = Provider.of<SpaceProvider>(context);

    return Hero(
      tag: widget.space.hero,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.space.name,
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background image
              SizedBox(
                height: 1300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/image/background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                height: 1300,
                width: MediaQuery.of(context).size.width,
              ),
              // Foreground content
              Column(
                children: [
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return RotationTransition(
                        turns: animationController,
                        child: child,
                      );
                    },
                    child: Container(
                      height: 160,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(widget.space.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.space.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Temperature : ${widget.space.temperature}°C',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: 850, // Increased height
                        width: 500,
                        decoration: BoxDecoration(
                          color: const Color(0xff70695F).withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Year : ${widget.space.lengthOfYear}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isLiked = !isLiked;
                                      });
                                      Provider.of<FavoriteProvider>(context,
                                              listen: false)
                                          .addFavPlanet(widget.space.name);
                                    },
                                    icon: Icon(
                                      isLiked
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color:
                                          isLiked ? Colors.red : Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Distance : ${widget.space.distance}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Velocity : ${widget.space.velocity}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Gravity : ${widget.space.gravity}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'About',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.space.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Video',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            // See more action
                                          },
                                          child: const Text('See more'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        widget.space.image))),
                                            child: const Icon(Icons.play_arrow,
                                                size: 50),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        widget.space.image))),
                                            child: const Icon(Icons.play_arrow,
                                                size: 50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
