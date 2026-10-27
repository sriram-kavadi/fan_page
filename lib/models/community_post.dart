/// Experiment 9: REST API Data Model with JSON serialization
class CommunityPost {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String authorName;
  final String tag;
  final int likes;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.authorName = 'RK Youth Volunteer',
    this.tag = 'Community',
    this.likes = 42,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    // Curated tags based on post ID
    final tags = ['Charity', 'Youth Leadership', 'Folk Culture', 'Social Work', 'Blood Drive'];
    final authors = [
      'Vikram Reddy (Warangal)',
      'Srinivas Rao (Karimnagar)',
      'Anitha Devi (Hyderabad)',
      'Kishore Kumar (Nizamabad)',
      'Rajeshwari (Khammam)'
    ];

    final id = json['id'] as int? ?? 1;

    return CommunityPost(
      id: id,
      userId: json['userId'] as int? ?? 1,
      title: json['title'] as String? ?? 'Community Notice',
      body: json['body'] as String? ?? '',
      authorName: authors[id % authors.length],
      tag: tags[id % tags.length],
      likes: (id * 17) % 350 + 25,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
