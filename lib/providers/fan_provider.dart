import 'package:flutter/foundation.dart';
import '../models/fan_models.dart';

class FanProvider extends ChangeNotifier {
  // === FAN STATS ===
  int _totalCheers = 142850;
  int get totalCheers => _totalCheers;

  void addCheer() {
    _totalCheers += 1;
    notifyListeners();
  }

  // === USER DIGITAL MEMBERSHIP CARD ===
  FanMemberCard _userCard = FanMemberCard(
    id: 'RK-VIP-2026-7841',
    name: 'Suresh Reddy',
    district: 'Hyderabad',
    phone: '+91 98480 22338',
    bloodGroup: 'O+',
    tier: MemberTier.royalVip,
    joinedDate: DateTime(2026, 1, 15),
    qrData: 'RATHNAVERI-KAVITHA-MEMBER-RK-VIP-2026-7841',
  );

  FanMemberCard get userCard => _userCard;

  void updateUserCard({
    required String name,
    required String district,
    required String phone,
    required String bloodGroup,
    required MemberTier tier,
  }) {
    _userCard = _userCard.copyWith(
      name: name,
      district: district,
      phone: phone,
      bloodGroup: bloodGroup,
      tier: tier,
    );
    notifyListeners();
  }

  // === COMMUNITY WISHES & FAN WALL ===
  final List<CommunityWish> _wishes = [
    CommunityWish(
      id: 'w1',
      authorName: 'Ramesh Goud',
      district: 'Warangal',
      message: 'Rathnaveri Kavitha gari dedication to empowering youth and preserving our cultural roots inspires every volunteer in our district! Proud to stand by her vision! Jai Ho! 🔥❤️',
      categoryTag: 'Inspiration',
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
      likesCount: 184,
    ),
    CommunityWish(
      id: 'w2',
      authorName: 'Anitha Devi',
      district: 'Karimnagar',
      message: 'The free educational material and scholarship camp conducted last week helped over 400 underprivileged girls in our constituency. Truly a compassionate leader!',
      categoryTag: 'Charity',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likesCount: 236,
    ),
    CommunityWish(
      id: 'w3',
      authorName: 'Prashanth Varma',
      district: 'Hyderabad',
      message: 'Extremely excited for the upcoming Statewide Youth Sammelanam! Hyderabad Central Chapter is ready with 1500+ active volunteers! Let us make it memorable.',
      categoryTag: 'Events & Rallies',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likesCount: 312,
    ),
    CommunityWish(
      id: 'w4',
      authorName: 'Sunitha Rao',
      district: 'Khammam',
      message: 'Celebrating the timeless traditions of our soil with Rathnaveri Kavitha garu. Her speeches echo the heartbeat of rural Telangana with immense dignity.',
      categoryTag: 'Cultural Pride',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      likesCount: 198,
    ),
    CommunityWish(
      id: 'w5',
      authorName: 'Kishore Kumar',
      district: 'Nizamabad',
      message: 'Every health camp and blood drive organized by RK Youth Association has directly saved lives in our town. Immense gratitude to Rathnaveri Kavitha garu!',
      categoryTag: 'Charity',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      likesCount: 145,
    ),
  ];

  List<CommunityWish> get wishes => List.unmodifiable(_wishes);

  void addWish({
    required String authorName,
    required String district,
    required String message,
    required String categoryTag,
  }) {
    _wishes.insert(
      0,
      CommunityWish(
        id: 'w_${DateTime.now().millisecondsSinceEpoch}',
        authorName: authorName,
        district: district,
        message: message,
        categoryTag: categoryTag,
        createdAt: DateTime.now(),
        likesCount: 1,
        hasLiked: true,
      ),
    );
    notifyListeners();
  }

  void toggleLikeWish(String id) {
    final index = _wishes.indexWhere((w) => w.id == id);
    if (index != -1) {
      if (_wishes[index].hasLiked) {
        _wishes[index].likesCount--;
        _wishes[index].hasLiked = false;
      } else {
        _wishes[index].likesCount++;
        _wishes[index].hasLiked = true;
      }
      notifyListeners();
    }
  }

  // === EVENTS & RALLIES ===
  final List<FanEvent> _events = [
    FanEvent(
      id: 'e1',
      title: 'Statewide Youth Sammelanam 2026',
      date: 'November 15, 2026',
      time: '10:00 AM - 4:00 PM',
      venue: 'Gachibowli Indoor Stadium',
      district: 'Hyderabad',
      category: 'Youth Summit',
      description: 'The mega annual youth convention featuring keynote address by Rathnaveri Kavitha garu, youth leadership awards, career mentorship, and cultural folk showcases.',
      attendingCount: 8420,
      isRegistered: true,
    ),
    FanEvent(
      id: 'e2',
      title: 'Mega Health & Blood Donation Camp',
      date: 'November 28, 2026',
      time: '8:30 AM - 2:00 PM',
      venue: 'Arts & Science College Grounds',
      district: 'Warangal',
      category: 'Charity Drive',
      description: 'Join hands with Red Cross and RK Volunteer Corps for a state-record blood donation drive and free medical health consultations for 2,000+ citizens.',
      attendingCount: 2310,
    ),
    FanEvent(
      id: 'e3',
      title: 'Bathukamma & Cultural Folk Heritage Gala',
      date: 'December 12, 2026',
      time: '4:00 PM - 9:30 PM',
      venue: 'Circus Grounds',
      district: 'Karimnagar',
      category: 'Cultural Festival',
      description: 'Grand cultural celebration showcasing traditional folk performances, women artisans exhibition, and festive musical honors under Rathnaveri Kavitha gari auspices.',
      attendingCount: 6540,
    ),
    FanEvent(
      id: 'e4',
      title: 'Rural Education Scholarship Distribution',
      date: 'December 24, 2026',
      time: '11:00 AM - 2:30 PM',
      venue: 'Town Hall Auditorium',
      district: 'Nizamabad',
      category: 'Education Aid',
      description: 'Distributing higher education scholarships, laptops, and study kits to 500 meritorious rural students.',
      attendingCount: 1480,
    ),
  ];

  List<FanEvent> get events => List.unmodifiable(_events);

  void toggleEventRegistration(String id) {
    final index = _events.indexWhere((e) => e.id == id);
    if (index != -1) {
      if (_events[index].isRegistered) {
        _events[index].isRegistered = false;
        _events[index].attendingCount--;
      } else {
        _events[index].isRegistered = true;
        _events[index].attendingCount++;
      }
      notifyListeners();
    }
  }

  // === BIOGRAPHY & MILESTONES ===
  final List<LifeMilestone> milestones = const [
    LifeMilestone(
      era: 'Grassroots & Heritage',
      title: 'Cultural Awakening & Folk Revival',
      description: 'Began community initiatives focused on celebrating indigenous arts, preserving rural traditions, and fostering regional pride across grassroots communities.',
      category: 'Heritage',
      emoji: '🌸',
    ),
    LifeMilestone(
      era: 'Youth Leadership',
      title: 'Formation of RK Youth Association',
      description: 'Mobilized thousands of dedicated youngsters into a disciplined social volunteer network across 30+ districts dedicated to community welfare and education.',
      category: 'Youth Empowerment',
      emoji: '⚡',
    ),
    LifeMilestone(
      era: 'Service & Compassion',
      title: 'Statewide Health & Food Relief Networks',
      description: 'Spearheaded record-breaking mega blood donation drives, free diagnostic clinics, and extensive community food distribution during critical crises.',
      category: 'Social Service',
      emoji: '❤️',
    ),
    LifeMilestone(
      era: 'Empowerment Era',
      title: 'Women Skill & Self-Reliance Centers',
      description: 'Established micro-enterprise training institutes and educational scholarship trusts empowering thousands of rural women and youth to become self-reliant.',
      category: 'Empowerment',
      emoji: '🏛️',
    ),
    LifeMilestone(
      era: '2026 & Beyond',
      title: 'The Digital Renaissance Vision',
      description: 'Championing modern technology, progressive leadership, and equitable welfare programs to prepare the next generation for global opportunities.',
      category: 'Future Vision',
      emoji: '🌟',
    ),
  ];

  // === MEDIA VAULT ===
  final List<MediaRecord> mediaList = const [
    MediaRecord(
      id: 'm1',
      title: 'Keynote Address on Youth Social Leadership',
      category: 'Speeches',
      date: 'Oct 2026',
      mediaType: 'speech',
      durationOrCount: '24 mins',
    ),
    MediaRecord(
      id: 'm2',
      title: 'Grand Cultural Sammelanam Highlights',
      category: 'Cultural',
      date: 'Sep 2026',
      mediaType: 'cultural',
      durationOrCount: '48 Photos',
    ),
    MediaRecord(
      id: 'm3',
      title: 'Mega Health Drive & Hospital Visit',
      category: 'Charity',
      date: 'Aug 2026',
      mediaType: 'charity',
      durationOrCount: '32 Photos',
    ),
    MediaRecord(
      id: 'm4',
      title: 'Rural Girls Education Aid Ceremony',
      category: 'Charity',
      date: 'Jul 2026',
      mediaType: 'charity',
      durationOrCount: '18 Photos',
    ),
    MediaRecord(
      id: 'm5',
      title: 'Historic Public Rally at Warangal',
      category: 'Rallies',
      date: 'Jun 2026',
      mediaType: 'rally',
      durationOrCount: '64 Photos',
    ),
  ];

  // === LIVE POLL ===
  final FanPoll _poll = FanPoll(
    id: 'poll_2026_1',
    question: 'Which social impact initiative should the RK Youth Wing prioritize for next month?',
    options: [
      PollOption(id: 'opt1', title: 'Youth Technology & AI Skill Workshops', votes: 3420),
      PollOption(id: 'opt2', title: 'Mega Rural Eye & Health Screening Camps', votes: 4180),
      PollOption(id: 'opt3', title: 'Clean Water & Tree Plantation Drives', votes: 1950),
      PollOption(id: 'opt4', title: 'Girl Child Higher Education Scholarships', votes: 5210),
    ],
  );

  FanPoll get poll => _poll;

  void votePoll(String optionId) {
    if (_poll.hasVoted) return;
    final opt = _poll.options.firstWhere((o) => o.id == optionId);
    opt.votes++;
    _poll.hasVoted = true;
    _poll.selectedOptionId = optionId;
    notifyListeners();
  }

  // === CHAPTER LEADS ===
  final List<ChapterLead> chapters = const [
    ChapterLead(district: 'Hyderabad Central', leadName: 'K. Vikram Reddy', phone: '+91 94401 11223', volunteerCount: 3800),
    ChapterLead(district: 'Warangal Urban', leadName: 'M. Sridhar Goud', phone: '+91 98481 22334', volunteerCount: 2900),
    ChapterLead(district: 'Karimnagar City', leadName: 'B. Srinivas Rao', phone: '+91 99890 33445', volunteerCount: 2450),
    ChapterLead(district: 'Nizamabad', leadName: 'G. Naveen Kumar', phone: '+91 97000 44556', volunteerCount: 2100),
    ChapterLead(district: 'Khammam', leadName: 'P. Rajeshwari', phone: '+91 98660 55667', volunteerCount: 1950),
    ChapterLead(district: 'Bengaluru Chapter', leadName: 'T. Arvind Sharma', phone: '+91 99001 66778', volunteerCount: 1200),
  ];

  // === QUOTES ===
  final List<String> quotes = const [
    '“True leadership does not seek power; it seeks to awaken courage, dignity, and self-belief in every ordinary citizen.”',
    '“Our culture is our roots; our youth are our wings. When both unite, nothing can stop the progress of our society.”',
    '“Service is not a one-day charity; it is a lifelong commitment to standing beside those whose voices have been unheard.”',
  ];
}
