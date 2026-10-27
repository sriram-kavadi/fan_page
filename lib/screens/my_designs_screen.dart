import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/studio_provider.dart';
import '../models/studio_models.dart';
import '../widgets/studio_widgets.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  @override
  State<MyDesignsScreen> createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studio = context.watch<StudioProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📁 My Designs',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${studio.savedDesigns.length} saved · ${studio.favoriteDesigns.length} favorites',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDark ? StudioTheme.cardDark : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: StudioTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: StudioTheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: isDark ? Colors.white38 : Colors.black38,
                labelStyle: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'All Designs'),
                  Tab(text: '❤️ Favorites'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _DesignList(
                    designs: studio.savedDesigns,
                    studio: studio,
                    isDark: isDark,
                    emptyTitle: 'No designs saved',
                    emptySubtitle: 'Create designs in Studio and save them here',
                    emptyEmoji: '🎨',
                  ),
                  _DesignList(
                    designs: studio.favoriteDesigns,
                    studio: studio,
                    isDark: isDark,
                    emptyTitle: 'No favorites yet',
                    emptySubtitle: 'Tap ❤️ on any design to add it to favorites',
                    emptyEmoji: '💙',
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

class _DesignList extends StatelessWidget {
  final List<CreatedDesign> designs;
  final StudioProvider studio;
  final bool isDark;
  final String emptyTitle, emptySubtitle, emptyEmoji;

  const _DesignList({
    required this.designs,
    required this.studio,
    required this.isDark,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.emptyEmoji,
  });

  @override
  Widget build(BuildContext context) {
    if (designs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emptyEmoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                emptyTitle,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                emptySubtitle,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: designs.length,
      itemBuilder: (context, index) {
        final design = designs[index];
        return _DesignCard(
          design: design,
          studio: studio,
          isDark: isDark,
        );
      },
    );
  }
}

class _DesignCard extends StatelessWidget {
  final CreatedDesign design;
  final StudioProvider studio;
  final bool isDark;

  const _DesignCard({
    required this.design,
    required this.studio,
    required this.isDark,
  });

  LinearGradient _getBgGradient(String bg) {
    switch (bg) {
      case 'gradient_sunset':
        return StudioTheme.accentGradient;
      case 'gradient_ocean':
        return StudioTheme.mintGradient;
      case 'gradient_forest':
        return const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]);
      case 'gradient_purple':
        return StudioTheme.purpleGradient;
      case 'white_clean':
        return const LinearGradient(colors: [Color(0xFFEEEEEE), Color(0xFFFFFFFF)]);
      default:
        return StudioTheme.primaryGradient;
    }
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showOptions(context),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? StudioTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Design preview
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: _getBgGradient(design.canvasBackground),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Decorative sticker emojis
                    Positioned(
                      left: 14,
                      top: 14,
                      child: Text('✦', style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.2))),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 14,
                      child: Text('✦', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.15))),
                    ),
                    Text('🎨', style: const TextStyle(fontSize: 40)),
                  ],
                ),
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          design.name,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => studio.toggleDesignFavorite(design.id),
                        child: Icon(
                          design.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 18,
                          color: design.isFavorite ? StudioTheme.accent : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${design.stickerCount} stickers • ${_formatDate(design.lastModified)}',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 11,
                      color: isDark ? Colors.white38 : Colors.black38,
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

  void _showOptions(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? StudioTheme.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              design.name,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _OptionTile(
              icon: design.isFavorite ? Icons.heart_broken_outlined : Icons.favorite_outlined,
              label: design.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              color: StudioTheme.accent,
              onTap: () {
                studio.toggleDesignFavorite(design.id);
                Navigator.pop(ctx);
              },
            ),
            _OptionTile(
              icon: Icons.delete_outline_rounded,
              label: 'Delete Design',
              color: Colors.red,
              onTap: () {
                studio.deleteDesign(design.id);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${design.name} deleted'),
                    backgroundColor: Colors.red.shade600,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
