import 'package:flutter_test/flutter_test.dart';
import 'package:rathnaveri_kavitha_fan_page/models/fan_models.dart';

void main() {
  group('Rathnaveri Kavitha Fan Models Unit Tests', () {
    test('FanMemberCard properties, tier names, and copyWith', () {
      final card = FanMemberCard(
        id: 'RK-VIP-001',
        name: 'K. Ramesh',
        district: 'Warangal',
        phone: '+91 98480 11223',
        bloodGroup: 'B+',
        tier: MemberTier.royalVip,
        joinedDate: DateTime(2026, 1, 1),
        qrData: 'QR-RK-VIP-001',
      );

      expect(card.name, 'K. Ramesh');
      expect(card.tierName, 'Royal Patron VIP');
      expect(card.bloodGroup, 'B+');
      expect(card.district, 'Warangal');

      final updated = card.copyWith(district: 'Hyderabad', tier: MemberTier.gold);
      expect(updated.district, 'Hyderabad');
      expect(updated.tierName, 'Gold Youth Leader');
      expect(updated.id, 'RK-VIP-001');
    });

    test('CommunityWish creation and like toggling', () {
      final wish = CommunityWish(
        id: 'w_test',
        authorName: 'Sunitha',
        district: 'Karimnagar',
        message: 'Inspiring social service by Rathnaveri Kavitha garu!',
        categoryTag: 'Inspiration',
        createdAt: DateTime.now(),
        likesCount: 10,
        hasLiked: false,
      );

      expect(wish.likesCount, 10);
      expect(wish.hasLiked, isFalse);
      wish.likesCount++;
      wish.hasLiked = true;
      expect(wish.likesCount, 11);
      expect(wish.hasLiked, isTrue);
    });

    test('FanEvent registration toggle', () {
      final event = FanEvent(
        id: 'e_101',
        title: 'State Youth Sammelanam',
        date: 'Nov 15, 2026',
        time: '10:00 AM',
        venue: 'Gachibowli Stadium',
        district: 'Hyderabad',
        category: 'Youth Summit',
        description: 'Keynote by Rathnaveri Kavitha garu.',
        attendingCount: 500,
        isRegistered: false,
      );

      expect(event.isRegistered, isFalse);
      event.isRegistered = true;
      event.attendingCount++;
      expect(event.isRegistered, isTrue);
      expect(event.attendingCount, 501);
    });

    test('FanPoll vote totaling', () {
      final poll = FanPoll(
        id: 'p1',
        question: 'Priority youth program?',
        options: [
          PollOption(id: 'o1', title: 'Workshops', votes: 100),
          PollOption(id: 'o2', title: 'Health Camps', votes: 250),
        ],
      );

      expect(poll.totalVotes, 350);
      poll.options.first.votes += 50;
      expect(poll.totalVotes, 400);
    });
  });
}
