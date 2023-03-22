class Place {
  final String imageUrl;
  final String time;
  final String name;
  final String address;
  final String description;

  Place({
    required this.imageUrl,
    required this.time,
    required this.name,
    required this.address,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      imageUrl: json['imageUrl'],
      time: json['time'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
    );
  }
}
