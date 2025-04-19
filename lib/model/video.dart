class Video {
  final int id;
  final String title;
  final String description;
  final String url;
  final String videoType;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.videoType,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['video_url'],
      videoType: json['video_type'].toLowerCase(), // to make it easier to match 'youtube', 'vimeo'
    );
  }
}
