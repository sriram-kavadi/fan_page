import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/studio_provider.dart';
import '../providers/theme_provider.dart';
import '../models/studio_models.dart';
import '../widgets/studio_widgets.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studio = context.watch<StudioProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          // === HERO APP BAR ===
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: isDark
                ? StudioTheme.bgDark.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.95),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(isDark: isDark),
            ),
            actions: [
              IconButton(
                tooltip: 'Toggle Theme',
                icon: Icon(
                  theme.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: StudioTheme.primary,
                ),
                onPressed: () => theme.toggleTheme(),
              ),
              const SizedBox(width: 8),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 28),

                // === QUICK STATS ROW ===
                _StatsRow(studio: studio),

                const SizedBox(height: 32),

                // === QUICK ACTIONS ===
                _SectionHeader(
                  title: 'Quick Start',
                  emoji: '⚡',
                  onSeeAll: null,
                ),
                const SizedBox(height: 16),
                _QuickActionsGrid(onNavigate: onNavigate),

                const SizedBox(height: 32),

                // === TRENDING TEMPLATES ===
                _SectionHeader(
                  title: 'Trending Templates',
                  emoji: '🔥',
                  onSeeAll: () => onNavigate(1),
                ),
                const SizedBox(height: 16),
                _TrendingTemplatesRow(studio: studio, onNavigate: onNavigate),

                const SizedBox(height: 32),

                // === MY RECENT DESIGNS ===
                _SectionHeader(
                  title: 'Recent Designs',
                  emoji: '🎨',
                  onSeeAll: () => onNavigate(3),
                ),
                const SizedBox(height: 16),
                _RecentDesignsList(studio: studio),

                const SizedBox(height: 32),

                // === STICKER PACKS ===
                _SectionHeader(
                  title: 'Featured Packs',
                  emoji: '📦',
                  onSeeAll: () => onNavigate(4),
                ),
                const SizedBox(height: 16),
                _FeaturedPacksRow(studio: studio, onNavigate: onNavigate),

                const SizedBox(height: 32),

                // === START CREATING CTA ===
                _CreateCTA(onTap: () => onNavigate(2)),

                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ========================== HERO HEADER ==========================

class _HeroHeader extends StatefulWidget {
  final bool isDark;
  const _HeroHeader({required this.isDark});

  @override
  State<_HeroHeader> createState() => _HeroHeaderState();
}

class _HeroHeaderState extends State<_HeroHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.isDark
            ? const LinearGradient(
                colors: [Color(0xFF0A0E1A), Color(0xFF0D1E3D), Color(0xFF0A0E1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFFE8F4FD), Color(0xFFF0E8FF), Color(0xFFE8F4FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Animated floating orbs
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned(
                      left: 20 + 30 * math.sin(_controller.value * 2 * math.pi),
                      top: 30 + 15 * math.cos(_controller.value * 2 * math.pi),
                      child: _FloatingOrb(
                        size: 80,
                        color: StudioTheme.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    Positioned(
                      right: 30 + 20 * math.cos(_controller.value * 2 * math.pi),
                      top: 10 + 20 * math.sin(_controller.value * 2 * math.pi * 0.7),
                      child: _FloatingOrb(
                        size: 60,
                        color: StudioTheme.secondary.withValues(alpha: 0.12),
                      ),
                    ),
                    Positioned(
                      right: 80,
                      bottom: 20 + 10 * math.sin(_controller.value * 2 * math.pi * 1.3),
                      child: _FloatingOrb(
                        size: 40,
                        color: StudioTheme.accent.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo row
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: StudioTheme.primary.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: const BoxDecoration(gradient: StudioTheme.primaryGradient),
                            child: const Center(
                              child: Text('✦', style: TextStyle(fontSize: 20, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nikhil's Fantasy Studio",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: widget.isDark ? Colors.white : const Color(0xFF0A0E1A),
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Create • Design • Inspire',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: StudioTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Hero tagline
                  Text(
                    'Craft stunning\nsticker art ✨',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: widget.isDark ? Colors.white : const Color(0xFF0A0E1A),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '30+ premium templates · 5 themed packs',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      color: widget.isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingOrb extends StatelessWidget {
  final double size;
  final Color color;
  const _FloatingOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: size * 0.5,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
    );
  }
}

// ========================== STATS ROW ==========================

class _StatsRow extends StatelessWidget {
  final StudioProvider studio;
  const _StatsRow({required this.studio});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = [
      _StatItem('${studio.totalTemplates}', 'Templates', '🎨', StudioTheme.primary),
      _StatItem('${studio.totalPacks}', 'Packs', '📦', StudioTheme.secondary),
      _StatItem('${studio.savedDesigns.length}', 'My Designs', '✏️', StudioTheme.purple),
      _StatItem('${(studio.totalDownloads / 1000).toStringAsFixed(1)}K', 'Downloads', '⬇️', StudioTheme.accent),
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? StudioTheme.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: stat.color.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: stat.color.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(stat.emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 6),
                Text(
                  stat.value,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: stat.color,
                  ),
                ),
                Text(
                  stat.label,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatItem {
  final String value, label, emoji;
  final Color color;
  _StatItem(this.value, this.label, this.emoji, this.color);
}

// ========================== SECTION HEADER ==========================

class _SectionHeader extends StatelessWidget {
  final String title, emoji;
  final VoidCallback? onSeeAll;
  const _SectionHeader({required this.title, required this.emoji, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0A0E1A),
              ),
            ),
          ],
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'See all →',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: StudioTheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

// ========================== QUICK ACTIONS GRID ==========================

class _QuickActionsGrid extends StatelessWidget {
  final Function(int) onNavigate;
  const _QuickActionsGrid({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionCard(
        label: 'Browse Templates',
        emoji: '🎨',
        gradient: StudioTheme.primaryGradient,
        onTap: () => onNavigate(1),
      ),
      _ActionCard(
        label: 'Open Studio',
        emoji: '✏️',
        gradient: StudioTheme.mintGradient,
        onTap: () => onNavigate(2),
      ),
      _ActionCard(
        label: 'My Designs',
        emoji: '📁',
        gradient: StudioTheme.purpleGradient,
        onTap: () => onNavigate(3),
      ),
      _ActionCard(
        label: 'Get Packs',
        emoji: '📦',
        gradient: StudioTheme.accentGradient,
        onTap: () => onNavigate(4),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: actions,
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label, emoji;
  final LinearGradient gradient;
  final VoidCallback onTap;
  const _ActionCard({
    required this.label,
    required this.emoji,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========================== TRENDING TEMPLATES ==========================

class _TrendingTemplatesRow extends StatelessWidget {
  final StudioProvider studio;
  final Function(int) onNavigate;
  const _TrendingTemplatesRow({required this.studio, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final trending = studio.allTemplates.take(6).toList();

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trending.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final template = trending[index];
          return GestureDetector(
            onTap: () {
              studio.addStickerToCanvas(template);
              onNavigate(2);
            },
            child: StickerPreviewWidget(template: template, size: 110),
          );
        },
      ),
    );
  }
}

// ========================== RECENT DESIGNS ==========================

class _RecentDesignsList extends StatelessWidget {
  final StudioProvider studio;
  const _RecentDesignsList({required this.studio});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (studio.savedDesigns.isEmpty) {
      return _EmptyState(
        emoji: '🎨',
        title: 'No designs yet',
        subtitle: 'Create your first sticker design in Studio',
      );
    }

    return Column(
      children: studio.savedDesigns.take(3).map((design) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? StudioTheme.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Design preview placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: _getBgGradient(design.canvasBackground),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    '🎨',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      design.name,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${design.stickerCount} stickers · ${_formatDate(design.lastModified)}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              if (design.isFavorite)
                const Icon(Icons.favorite_rounded, color: StudioTheme.accent, size: 18),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? Colors.white30 : Colors.black26),
            ],
          ),
        );
      }).toList(),
    );
  }

  LinearGradient _getBgGradient(String bg) {
    switch (bg) {
      case 'gradient_sunset':
        return StudioTheme.accentGradient;
      case 'gradient_ocean':
        return StudioTheme.mintGradient;
      case 'gradient_purple':
        return StudioTheme.purpleGradient;
      default:
        return StudioTheme.primaryGradient;
    }
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }
}

// ========================== FEATURED PACKS ==========================

class _FeaturedPacksRow extends StatelessWidget {
  final StudioProvider studio;
  final Function(int) onNavigate;
  const _FeaturedPacksRow({required this.studio, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: studio.packs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final pack = studio.packs[index];
          return GestureDetector(
            onTap: () => onNavigate(4),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: pack.gradientColors.map((c) => Color(c)).toList(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Color(pack.gradientColors.first).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pack.previewEmoji, style: const TextStyle(fontSize: 34)),
                  const Spacer(),
                  Text(
                    pack.name,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (pack.isDownloaded)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '✓ Owned',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        Text(
                          '${pack.stickerCount} stickers',
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ========================== CTA BANNER ==========================

class _CreateCTA extends StatelessWidget {
  final VoidCallback onTap;
  const _CreateCTA({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A84FF), Color(0xFF00C896)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: StudioTheme.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🚀 Start Creating',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Launch Studio to craft your first sticker art masterpiece',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Open Studio  →',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 72,
              height: 72,
              child: Image.asset(
                'assets/illustrations/sticker_dragon.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Text('✦', style: TextStyle(fontSize: 60, color: Colors.white24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========================== EMPTY STATE ==========================

class _EmptyState extends StatelessWidget {
  final String emoji, title, subtitle;
  const _EmptyState({required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? StudioTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
