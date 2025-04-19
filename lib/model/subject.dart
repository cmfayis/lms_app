class Subject {
  final int id;
  final String title;
  final String? description;
  final String? image;

  Subject({
    required this.id,
    required this.title,
    this.description,
    this.image,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}