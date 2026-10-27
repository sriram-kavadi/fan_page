import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/fan_models.dart';
import '../providers/fan_provider.dart';
import '../widgets/rk_widgets.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fan = context.watch<FanProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Journey & Media Vault'),
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: RKTheme.gold,
          indicatorWeight: 3,
          labelColor: isDark ? Colors.white : Colors.black87,
          labelStyle: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w800, fontSize: 13),
          unselectedLabelColor: isDark ? Colors.white38 : Colors.black38,
          tabs: const [
            Tab(text: '🌟 Milestones'),
            Tab(text: '🎙️ Speeches & Media'),
            Tab(text: '🗳️ Live Poll'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          // 1. Milestones Timeline
          _MilestonesTimeline(milestones: fan.milestones, isDark: isDark),

          // 2. Media & Speeches Vault
          _MediaVaultList(mediaList: fan.mediaList, isDark: isDark),

          // 3. Live Poll View
          _LivePollView(poll: fan.poll, onVote: fan.votePoll, isDark: isDark),
        ],
      ),
    );
  }
}

// ============================================================================
// 1. MILESTONES TIMELINE
// ============================================================================

class _MilestonesTimeline extends StatelessWidget {
  final List<LifeMilestone> milestones;
  final bool isDark;

  const _MilestonesTimeline({required this.milestones, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: milestones.length,
      itemBuilder: (context, index) {
        final m = milestones[index];
        final isLast = index == milestones.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Pillar
              Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: RKTheme.rubyGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: RKTheme.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(m.emoji, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: RKTheme.gold.withValues(alpha: 0.4),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),

              // Content Card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? RKTheme.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: RKTheme.gold.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              m.era.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: RKTheme.goldDark,
                              ),
                            ),
                          ),
                          Text(
                            m.category,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        m.title,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF0B0F19),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        m.description,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 13,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 2. MEDIA VAULT LIST
// ============================================================================

class _MediaVaultList extends StatelessWidget {
  final List<MediaRecord> mediaList;
  final bool isDark;

  const _MediaVaultList({required this.mediaList, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: mediaList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final m = mediaList[index];
        IconData icon;
        Color color;

        switch (m.mediaType) {
          case 'speech':
            icon = Icons.mic_external_on_rounded;
            color = RKTheme.primary;
            break;
          case 'cultural':
            icon = Icons.festival_rounded;
            color = RKTheme.gold;
            break;
          case 'charity':
            icon = Icons.volunteer_activism_rounded;
            color = RKTheme.emerald;
            break;
          default:
            icon = Icons.campaign_rounded;
            color = RKTheme.goldDark;
        }

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? RKTheme.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.title,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${m.category} • ${m.date} • ${m.durationOrCount}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.play_circle_fill_rounded, color: RKTheme.gold, size: 32),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Playing audio preview: ${m.title}'),
                      backgroundColor: RKTheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================================
// 3. LIVE FAN POLL
// ============================================================================

class _LivePollView extends StatelessWidget {
  final FanPoll poll;
  final Function(String) onVote;
  final bool isDark;

  const _LivePollView({
    required this.poll,
    required this.onVote,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final total = poll.totalVotes;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark ? RKTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RKTheme.gold.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.poll_rounded, color: RKTheme.gold, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'ACTIVE COMMUNITY POLL',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: RKTheme.gold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              poll.question,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0B0F19),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${poll.totalVotes} total verified fan votes recorded',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: poll.options.map((opt) {
                final pct = total == 0 ? 0 : (opt.votes / total * 100).round();
                final isSelected = poll.selectedOptionId == opt.id;

                return GestureDetector(
                  onTap: () => onVote(opt.id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? RKTheme.primary.withValues(alpha: 0.15)
                          : (isDark ? const Color(0xFF161E2E) : const Color(0xFFF6F4EE)),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? RKTheme.primary : (isDark ? Colors.white12 : Colors.black12),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                opt.title,
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            Text(
                              '$pct%',
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: RKTheme.gold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: total == 0 ? 0 : opt.votes / total,
                            minHeight: 6,
                            backgroundColor: isDark ? Colors.white12 : Colors.black12,
                            valueColor: AlwaysStoppedAnimation(isSelected ? RKTheme.primary : RKTheme.gold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            if (poll.hasVoted)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_circle, color: RKTheme.emerald, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Your vote has been counted!',
                        style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w700, color: RKTheme.emerald),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
