import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/fan_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/rk_widgets.dart';
import '../widgets/responsive_layout.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fan = context.watch<FanProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          // === HERO APP BAR ===
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: isDark
                ? RKTheme.bgDark.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.95),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroBanner(fan: fan, isDark: isDark),
            ),
            actions: [
              IconButton(
                tooltip: 'Flutter Lab Experiments Hub (1-10)',
                icon: const Icon(
                  Icons.science_outlined,
                  color: RKTheme.gold,
                ),
                onPressed: () => Navigator.pushNamed(context, '/experiments'),
              ),
              IconButton(
                tooltip: 'Live REST API Feed (Exp 9)',
                icon: const Icon(
                  Icons.cloud_sync_outlined,
                  color: RKTheme.gold,
                ),
                onPressed: () => Navigator.pushNamed(context, '/api-feed'),
              ),
              IconButton(
                tooltip: 'Toggle Theme',
                icon: Icon(
                  theme.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: RKTheme.gold,
                ),
                onPressed: () => theme.toggleTheme(),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // === MAIN CONTENT LIST ===
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 24),

                // Live Impact Statistics
                _ImpactStatsRow(isDark: isDark),

                const SizedBox(height: 28),

                // Inspirational Quote of the Day
                _QuoteBanner(quote: fan.quotes.first, isDark: isDark),

                const SizedBox(height: 28),

                // Quick Action Hub
                _SectionTitle(title: 'Quick Access', emoji: '⚡', isDark: isDark),
                const SizedBox(height: 14),
                _QuickActionGrid(onNavigate: onNavigate, isDark: isDark),

                const SizedBox(height: 28),

                // Digital ID Pass Banner Callout
                _DigitalCardCTA(fan: fan, onNavigate: onNavigate),

                const SizedBox(height: 28),

                // Upcoming Featured Event
                _SectionTitle(
                  title: 'Featured Event',
                  emoji: '📅',
                  isDark: isDark,
                  actionText: 'View All (4)',
                  onAction: () => onNavigate(3), // Events tab
                ),
                const SizedBox(height: 14),
                _FeaturedEventCard(
                  event: fan.events.first,
                  onRegister: () => fan.toggleEventRegistration(fan.events.first.id),
                  isDark: isDark,
                ),

                const SizedBox(height: 28),

                // Live Fan Wall Preview
                _SectionTitle(
                  title: 'Community Fan Wall',
                  emoji: '💬',
                  isDark: isDark,
                  actionText: 'Join Wall',
                  onAction: () => onNavigate(2), // Fan wall tab
                ),
                const SizedBox(height: 14),
                _RecentWishesList(fan: fan, isDark: isDark),

                const SizedBox(height: 28),

                // District Chapters Snapshot
                _SectionTitle(title: 'Active District Chapters', emoji: '🏛️', isDark: isDark),
                const SizedBox(height: 14),
                _ChapterNetworkRow(chapters: fan.chapters, isDark: isDark),

                const SizedBox(height: 36),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// HERO BANNER
// ============================================================================

class _HeroBanner extends StatelessWidget {
  final FanProvider fan;
  final bool isDark;

  const _HeroBanner({required this.fan, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? RKTheme.royalHeroGradient
            : const LinearGradient(
                colors: [Color(0xFFFFF0F2), Color(0xFFFDFBF7), Color(0xFFFFF8E7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RKEmblemCrest(size: 72, showGlow: true),
              const SizedBox(height: 12),
              Text(
                'RATHNAVERI KAVITHA',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: isDark ? Colors.white : const Color(0xFF0B0F19),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: RKTheme.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'OFFICIAL YOUTH & CULTURAL FAN HUB',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: RKTheme.gold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: RKTheme.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PulseCheerButton(
                count: fan.totalCheers,
                onTap: () => fan.addCheer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// IMPACT STATISTICS ROW
// ============================================================================

class _ImpactStatsRow extends StatelessWidget {
  final bool isDark;
  const _ImpactStatsRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: isDark ? RKTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatCol(number: '33', label: 'Districts', isDark: isDark),
          _Divider(isDark: isDark),
          _StatCol(number: '25K+', label: 'Volunteers', isDark: isDark),
          _Divider(isDark: isDark),
          _StatCol(number: '142+', label: 'Events Held', isDark: isDark),
          _Divider(isDark: isDark),
          _StatCol(number: '58', label: 'Blood Drives', isDark: isDark),
        ],
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  final String number, label;
  final bool isDark;
  const _StatCol({required this.number, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: RKTheme.gold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 26,
      color: isDark ? Colors.white12 : Colors.black12,
    );
  }
}

// ============================================================================
// QUOTE OF THE DAY BANNER
// ============================================================================

class _QuoteBanner extends StatelessWidget {
  final String quote;
  final bool isDark;
  const _QuoteBanner({required this.quote, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF2E0914), const Color(0xFF161E2E)]
              : [const Color(0xFFFFF2F4), const Color(0xFFFFF8EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: RKTheme.gold.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_quote_rounded, color: RKTheme.gold, size: 24),
              const SizedBox(width: 8),
              Text(
                'INSPIRATION OF THE DAY',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: RKTheme.gold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            quote,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.45,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF0B0F19),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— Rathnaveri Kavitha',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isDark ? RKTheme.goldLight : RKTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// QUICK ACTION GRID
// ============================================================================

class _QuickActionGrid extends StatelessWidget {
  final Function(int) onNavigate;
  final bool isDark;
  const _QuickActionGrid({required this.onNavigate, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final crossAxisCount = isDesktop ? 3 : (isTablet ? 3 : 2);
    final aspectRatio = isDesktop ? 2.1 : (isTablet ? 1.7 : 1.45);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: aspectRatio,
      children: [
        _ActionTile(
          icon: Icons.badge_outlined,
          title: 'Digital Fan ID',
          subtitle: 'Generate Member Card',
          gradient: RKTheme.rubyGradient,
          onTap: () => onNavigate(1),
        ),
        _ActionTile(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'Fan Wall',
          subtitle: 'Post Wishes & Cheers',
          gradient: const LinearGradient(
            colors: [Color(0xFF2A9D8F), Color(0xFF1E6F66)],
          ),
          onTap: () => onNavigate(2),
        ),
        _ActionTile(
          icon: Icons.event_available_outlined,
          title: 'Events & Rallies',
          subtitle: 'Passes & Schedule',
          gradient: RKTheme.goldGradient,
          onTap: () => onNavigate(3),
        ),
        _ActionTile(
          icon: Icons.timeline_rounded,
          title: 'Journey & Life',
          subtitle: 'Milestones & Impact',
          gradient: const LinearGradient(
            colors: [Color(0xFF5A1224), Color(0xFF2E0914)],
          ),
          onTap: () => onNavigate(4),
        ),
        _ActionTile(
          icon: Icons.science_outlined,
          title: 'Lab Experiments',
          subtitle: 'Experiments 1 - 10 Hub',
          gradient: const LinearGradient(
            colors: [Color(0xFF7B2CBF), Color(0xFF5A189A)],
          ),
          onTap: () => Navigator.pushNamed(context, '/experiments'),
        ),
        _ActionTile(
          icon: Icons.cloud_sync_outlined,
          title: 'Live REST API',
          subtitle: 'HTTP Dispatches (Exp 9)',
          gradient: const LinearGradient(
            colors: [Color(0xFF0077B6), Color(0xFF023E8A)],
          ),
          onTap: () => Navigator.pushNamed(context, '/api-feed'),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DIGITAL CARD CTA CALLOUT
// ============================================================================

class _DigitalCardCTA extends StatelessWidget {
  final FanProvider fan;
  final Function(int) onNavigate;

  const _DigitalCardCTA({required this.fan, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNavigate(1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: RKTheme.cardVipGradient,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RKTheme.gold.withValues(alpha: 0.6)),
          boxShadow: [
            BoxShadow(
              color: RKTheme.gold.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const RKEmblemCrest(size: 60, showGlow: false),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Your Official Fan Pass',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Exclusive verified QR ID card with state member number.',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: RKTheme.gold,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.black, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// FEATURED EVENT CARD
// ============================================================================

class _FeaturedEventCard extends StatelessWidget {
  final dynamic event;
  final VoidCallback onRegister;
  final bool isDark;

  const _FeaturedEventCard({
    required this.event,
    required this.onRegister,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? RKTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: RKTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  event.category.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: RKTheme.primary,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.people_alt_outlined, size: 14, color: RKTheme.gold),
                  const SizedBox(width: 4),
                  Text(
                    '${event.attendingCount} Attending',
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: RKTheme.gold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            event.title,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0B0F19),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              color: isDark ? Colors.white60 : Colors.black54,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 16, color: isDark ? Colors.white38 : Colors.black38),
              const SizedBox(width: 6),
              Text(
                '${event.date} • ${event.venue}',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: event.isRegistered ? RKTheme.emerald : RKTheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              icon: Icon(event.isRegistered ? Icons.check_circle : Icons.confirmation_number_outlined, size: 18),
              label: Text(event.isRegistered ? 'PASS CONFIRMED (Tap to Cancel)' : 'GET FREE ENTRY PASS'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RECENT WISHES LIST
// ============================================================================

class _RecentWishesList extends StatelessWidget {
  final FanProvider fan;
  final bool isDark;
  const _RecentWishesList({required this.fan, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fan.wishes.take(2).map((w) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? RKTheme.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: RKTheme.primary.withValues(alpha: 0.15),
                        child: Text(
                          w.authorName[0],
                          style: const TextStyle(fontWeight: FontWeight.w800, color: RKTheme.primary),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            w.authorName,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            w.district,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 11,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: RKTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      w.categoryTag,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: RKTheme.goldDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                w.message,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => fan.toggleLikeWish(w.id),
                child: Row(
                  children: [
                    Icon(
                      w.hasLiked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: w.hasLiked ? RKTheme.primary : (isDark ? Colors.white38 : Colors.black38),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${w.likesCount} Cheers',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// CHAPTER NETWORK ROW
// ============================================================================

class _ChapterNetworkRow extends StatelessWidget {
  final List<dynamic> chapters;
  final bool isDark;
  const _ChapterNetworkRow({required this.chapters, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chapters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final c = chapters[index];
          return Container(
            width: 160,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? RKTheme.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  c.district,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Lead: ${c.leadName}',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 11,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${c.volunteerCount} Volunteers',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: RKTheme.gold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE HEADER
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title, emoji;
  final bool isDark;
  final String? actionText;
  final VoidCallback? onAction;

  const _SectionTitle({
    required this.title,
    required this.emoji,
    required this.isDark,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0B0F19),
              ),
            ),
          ],
        ),
        if (actionText != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText!,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: RKTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
