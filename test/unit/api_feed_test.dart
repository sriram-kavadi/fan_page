import 'package:flutter_test/flutter_test.dart';
import 'package:rathnaveri_kavitha_fan_page/models/community_post.dart';
import 'package:rathnaveri_kavitha_fan_page/services/api_service.dart';
import 'package:rathnaveri_kavitha_fan_page/providers/api_feed_provider.dart';

void main() {
  group('Experiment 9: REST API Unit Tests', () {
    test('CommunityPost json serialization and tags', () {
      final json = {
        'id': 1,
        'userId': 10,
        'title': 'Youth rally organization',
        'body': 'Meeting held in Hyderabad chapter.',
      };

      final post = CommunityPost.fromJson(json);
      expect(post.id, 1);
      expect(post.userId, 10);
      expect(post.title, 'Youth rally organization');
      expect(post.body, 'Meeting held in Hyderabad chapter.');
      expect(post.tag, isNotEmpty);
      expect(post.authorName, isNotEmpty);
      expect(post.likes, greaterThan(0));

      final serialized = post.toJson();
      expect(serialized['id'], 1);
      expect(serialized['title'], 'Youth rally organization');
    });

    test('ApiService provides fallback posts reliably', () async {
      final service = ApiService();
      final posts = await service.fetchCommunityPosts();
      expect(posts, isNotEmpty);
      expect(posts.first.title, isNotEmpty);
    });

    test('ApiFeedProvider search filter works correctly', () async {
      final provider = ApiFeedProvider();
      await Future.delayed(const Duration(milliseconds: 200));

      provider.setSearchQuery('Warangal');
      expect(provider.searchQuery, 'Warangal');

      final filtered = provider.posts;
      for (final post in filtered) {
        final matches = post.title.contains('Warangal') ||
            post.body.contains('Warangal') ||
            post.authorName.contains('Warangal') ||
            post.tag.contains('Warangal');
        expect(matches, isTrue);
      }

      provider.setSearchQuery('');
      expect(provider.posts.length, greaterThanOrEqualTo(filtered.length));
    });
  });
}
