class Cars {
  final String image;
  final String title;
  final int production;

  Cars({
    required this.image,
    required this.title,
    required this.production
  });

  factory Cars.fromJson(Map<String, dynamic> json) {
    return Cars(
        image: json['image'] ?? '',
        title: json['title'] ?? '',
        production: json['start_production'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'start_production': production
    };
  }
}