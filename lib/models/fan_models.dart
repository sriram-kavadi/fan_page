/// Data models for Rathnaveri Kavitha Official Fan Hub

enum MemberTier { silver, gold, royalVip }

class FanMemberCard {
  final String id;
  final String name;
  final String district;
  final String phone;
  final String bloodGroup;
  final MemberTier tier;
  final DateTime joinedDate;
  final String qrData;

  const FanMemberCard({
    required this.id,
    required this.name,
    required this.district,
    required this.phone,
    required this.bloodGroup,
    required this.tier,
    required this.joinedDate,
    required this.qrData,
  });

  String get tierName {
    switch (tier) {
      case MemberTier.royalVip:
        return 'Royal Patron VIP';
      case MemberTier.gold:
        return 'Gold Youth Leader';
      case MemberTier.silver:
        return 'Silver Volunteer';
    }
  }

  FanMemberCard copyWith({
    String? name,
    String? district,
    String? phone,
    String? bloodGroup,
    MemberTier? tier,
  }) {
    return FanMemberCard(
      id: id,
      name: name ?? this.name,
      district: district ?? this.district,
      phone: phone ?? this.phone,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      tier: tier ?? this.tier,
      joinedDate: joinedDate,
      qrData: qrData,
    );
  }
}

class CommunityWish {
  final String id;
  final String authorName;
  final String district;
  final String message;
  final String categoryTag;
  final DateTime createdAt;
  int likesCount;
  bool hasLiked;

  CommunityWish({
    required this.id,
    required this.authorName,
    required this.district,
    required this.message,
    required this.categoryTag,
    required this.createdAt,
    this.likesCount = 0,
    this.hasLiked = false,
  });
}

class FanEvent {
  final String id;
  final String title;
  final String date;
  final String time;
  final String venue;
  final String district;
  final String category;
  final String description;
  int attendingCount;
  bool isRegistered;

  FanEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.district,
    required this.category,
    required this.description,
    this.attendingCount = 0,
    this.isRegistered = false,
  });
}

class LifeMilestone {
  final String era;
  final String title;
  final String description;
  final String category;
  final String emoji;

  const LifeMilestone({
    required this.era,
    required this.title,
    required this.description,
    required this.category,
    required this.emoji,
  });
}

class MediaRecord {
  final String id;
  final String title;
  final String category;
  final String date;
  final String mediaType; // 'speech', 'rally', 'charity', 'cultural'
  final String durationOrCount;

  const MediaRecord({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.mediaType,
    required this.durationOrCount,
  });
}

class PollOption {
  final String id;
  final String title;
  int votes;

  PollOption({required this.id, required this.title, this.votes = 0});
}

class FanPoll {
  final String id;
  final String question;
  final List<PollOption> options;
  bool hasVoted;
  String? selectedOptionId;

  FanPoll({
    required this.id,
    required this.question,
    required this.options,
    this.hasVoted = false,
    this.selectedOptionId,
  });

  int get totalVotes => options.fold(0, (sum, opt) => sum + opt.votes);
}

class ChapterLead {
  final String district;
  final String leadName;
  final String phone;
  final int volunteerCount;

  const ChapterLead({
    required this.district,
    required this.leadName,
    required this.phone,
    required this.volunteerCount,
  });
}
