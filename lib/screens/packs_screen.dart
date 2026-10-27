import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/studio_provider.dart';
import '../models/studio_models.dart';
import '../providers/theme_provider.dart';
import '../widgets/studio_widgets.dart';

class PacksScreen extends StatelessWidget {
  const PacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studio = context.watch<StudioProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: isDark ? StudioTheme.bgDark : StudioTheme.bgLight,
            floating: true,
            title: Text(
              '📦 Sticker Packs',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0A0E1A),
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Toggle Theme',
                icon: Icon(
                  themeProvider.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: StudioTheme.primary,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats banner
                _StatsBanner(studio: studio, isDark: isDark),

                const SizedBox(height: 28),

                // Section title
                Text(
                  'All Packs',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                  ),
                ),

                const SizedBox(height: 16),
              ]),
            ),
          ),

          // Packs list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pack = studio.packs[index];
                  return _PackCard(
                    pack: pack,
                    studio: studio,
                    isDark: isDark,
                  );
                },
                childCount: studio.packs.length,
              ),
            ),
          ),

          // Settings section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  '⚙️ Studio Settings',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                  ),
                ),
                const SizedBox(height: 16),
                _SettingsPanel(isDark: isDark, themeProvider: themeProvider, studio: studio),
                const SizedBox(height: 32),

                // About
                _AboutSection(isDark: isDark),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBanner extends StatelessWidget {
  final StudioProvider studio;
  final bool isDark;
  const _StatsBanner({required this.studio, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🏆 Studio Stats', style: TextStyle(color: Colors.white70, fontFamily: 'Outfit', fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _MiniStat(value: '${studio.packs.where((p) => p.isDownloaded).length}/${studio.packs.length}', label: 'Packs Owned'),
                    const SizedBox(width: 24),
                    _MiniStat(value: '${studio.totalTemplates}', label: 'Templates'),
                    const SizedBox(width: 24),
                    _MiniStat(value: '${studio.savedDesigns.length}', label: 'Designs'),
                  ],
                ),
              ],
            ),
          ),
          const Text('🎨', style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value, label;
  const _MiniStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _PackCard extends StatelessWidget {
  final StickerPack pack;
  final StudioProvider studio;
  final bool isDark;
  const _PackCard({required this.pack, required this.studio, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final colors = pack.gradientColors.map((c) => Color(c)).toList();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? StudioTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Pack header with gradient
          Container(
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Stack(
              children: [
                // Background decorative elements
                Positioned(
                  right: -15,
                  top: -15,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.07),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      if (pack.id == 'pack_2')
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: Image.asset(
                            'assets/illustrations/sticker_dragon.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Text(pack.previewEmoji, style: const TextStyle(fontSize: 56)),
                          ),
                        )
                      else if (pack.id == 'pack_5')
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: Image.asset(
                            'assets/illustrations/sticker_phoenix.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Text(pack.previewEmoji, style: const TextStyle(fontSize: 56)),
                          ),
                        )
                      else
                        Text(pack.previewEmoji, style: const TextStyle(fontSize: 56)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (pack.isDownloaded)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  '✓ Owned',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 6),
                            Text(
                              pack.name,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${pack.stickerCount} stickers • ${pack.category}',
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pack info + CTA
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pack.description,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: pack.isDownloaded
                      ? OutlinedButton.icon(
                          icon: const Icon(Icons.check_circle_rounded, color: StudioTheme.secondary),
                          label: const Text('Pack Installed'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: StudioTheme.secondary,
                            side: const BorderSide(color: StudioTheme.secondary),
                          ),
                          onPressed: () {},
                        )
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Get Pack Free'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(pack.gradientColors.first),
                          ),
                          onPressed: () {
                            studio.downloadPack(pack.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${pack.name} installed! 🎉'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(pack.gradientColors.first),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  final bool isDark;
  final ThemeProvider themeProvider;
  final StudioProvider studio;

  const _SettingsPanel({
    required this.isDark,
    required this.themeProvider,
    required this.studio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? StudioTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
      ),
      child: Column(
        children: [
          SwitchListTile(
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
            secondary: Icon(
              themeProvider.isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: StudioTheme.primary,
            ),
            title: Text(
              'Dark Mode',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              themeProvider.isDark ? 'Dark studio environment' : 'Light studio environment',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
            activeColor: StudioTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          Divider(height: 1, color: isDark ? Colors.white12 : Colors.black12),
          ListTile(
            leading: const Icon(Icons.palette_outlined, color: StudioTheme.secondary),
            title: Text(
              'My Canvas Designs',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              '${studio.savedDesigns.length} designs saved',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: isDark ? Colors.white30 : Colors.black26),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          Divider(height: 1, color: isDark ? Colors.white12 : Colors.black12),
          ListTile(
            leading: const Icon(Icons.favorite_rounded, color: StudioTheme.accent),
            title: Text(
              'Favorite Templates',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            subtitle: Text(
              '${studio.favoriteTemplates.length} templates saved',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final bool isDark;
  const _AboutSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0D2548)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: StudioTheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: StudioTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('✦', style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Nikhil's Fantasy Studio",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Version 2.0.0 • Creative Edition',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'A premium digital sticker creation studio with 30+ templates, 5 themed packs, interactive canvas editing, and beautiful design tools.',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.6),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip('🎨 30+ Templates'),
              _TagChip('📦 5 Packs'),
              _TagChip('✏️ Canvas Editor'),
              _TagChip('↩️ Undo/Redo'),
              _TagChip('❤️ Favorites'),
              _TagChip('🌙 Dark Mode'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 11,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
