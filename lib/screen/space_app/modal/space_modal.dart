class SpaceModal {
  final String id;
  final String name;
  final String lengthOfYear;
  final String temperature;
  final String gravity;
  final String velocity;
  final String distance;
  final String description;
  final String image;
  final String hero;

  SpaceModal({
    required this.id,
    required this.name,
    required this.lengthOfYear,
    required this.temperature,
    required this.gravity,
    required this.velocity,
    required this.distance,
    required this.description,
    required this.image,
    required this.hero,
  });

  factory SpaceModal.fromJson(Map<String, dynamic> json) {
    return SpaceModal(
      name: json['name'] ?? '',
      lengthOfYear: json['leanthOfYear'] ?? json['lengthOfYear'] ?? '',
      temperature: json['temperature'] ?? '',
      gravity: json['gravity'] ?? '',
      velocity: json['velocity'] ??'' ,
      distance: json['distance'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      hero: json['hero'] ?? '', id: '',
    );
  }
}
