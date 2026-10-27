import 'package:flutter_test/flutter_test.dart';
import 'package:rathnaveri_kavitha_fan_page/models/fan_models.dart';
import 'package:rathnaveri_kavitha_fan_page/providers/fan_provider.dart';

void main() {
  group('FanProvider Unit Tests', () {
    late FanProvider provider;

    setUp(() {
      provider = FanProvider();
    });

    test('Initial provider state verification', () {
      expect(provider.totalCheers, greaterThan(100000));
      expect(provider.wishes.length, 5);
      expect(provider.events.length, 4);
      expect(provider.milestones.length, 5);
      expect(provider.mediaList.length, 5);
      expect(provider.chapters.length, 6);
      expect(provider.quotes.isNotEmpty, isTrue);
      expect(provider.userCard.tier, MemberTier.royalVip);
    });

    test('Cheer counter increments', () {
      final initial = provider.totalCheers;
      provider.addCheer();
      expect(provider.totalCheers, initial + 1);
    });

    test('Digital card update modifies user card state', () {
      provider.updateUserCard(
        name: 'Venkatesh Rao',
        district: 'Karimnagar',
        phone: '+91 94400 55667',
        bloodGroup: 'A+',
        tier: MemberTier.gold,
      );

      expect(provider.userCard.name, 'Venkatesh Rao');
      expect(provider.userCard.district, 'Karimnagar');
      expect(provider.userCard.tier, MemberTier.gold);
      expect(provider.userCard.bloodGroup, 'A+');
    });

    test('Adding and liking community wishes', () {
      final initialCount = provider.wishes.length;

      provider.addWish(
        authorName: 'Deepika',
        district: 'Nizamabad',
        message: 'Proud supporter of Rathnaveri Kavitha gari vision!',
        categoryTag: 'Inspiration',
      );

      expect(provider.wishes.length, initialCount + 1);
      final newWish = provider.wishes.first;
      expect(newWish.authorName, 'Deepika');
      expect(newWish.hasLiked, isTrue);

      // Toggle like
      provider.toggleLikeWish(newWish.id);
      expect(provider.wishes.first.hasLiked, isFalse);
      expect(provider.wishes.first.likesCount, 0);
    });

    test('Event registration toggle updates attending count', () {
      final event = provider.events.firstWhere((e) => !e.isRegistered);
      final initialCount = event.attendingCount;

      provider.toggleEventRegistration(event.id);
      expect(provider.events.firstWhere((e) => e.id == event.id).isRegistered, isTrue);
      expect(provider.events.firstWhere((e) => e.id == event.id).attendingCount, initialCount + 1);

      provider.toggleEventRegistration(event.id);
      expect(provider.events.firstWhere((e) => e.id == event.id).isRegistered, isFalse);
      expect(provider.events.firstWhere((e) => e.id == event.id).attendingCount, initialCount);
    });

    test('Live poll voting', () {
      expect(provider.poll.hasVoted, isFalse);
      final opt = provider.poll.options.first;
      final initialVotes = opt.votes;

      provider.votePoll(opt.id);
      expect(provider.poll.hasVoted, isTrue);
      expect(provider.poll.selectedOptionId, opt.id);
      expect(provider.poll.options.first.votes, initialVotes + 1);
    });
  });
}
