import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/studio_provider.dart';
import '../widgets/studio_widgets.dart';

class TemplateLibraryScreen extends StatefulWidget {
  const TemplateLibraryScreen({super.key});

  @override
  State<TemplateLibraryScreen> createState() => _TemplateLibraryScreenState();
}

class _TemplateLibraryScreenState extends State<TemplateLibraryScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
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
            // === HEADER ===
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🎨 Templates',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF0A0E1A),
                        ),
                      ),
                      Row(
                        children: [
                          // Favorites toggle
                          _FilterChip(
                            label: '❤️ Favorites',
                            isActive: studio.selectedCategory == '_favorites',
                            onTap: () {
                              if (studio.selectedCategory == '_favorites') {
                                studio.setCategory('All');
                              } else {
                                studio.setCategory('_favorites');
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${studio.totalTemplates} premium sticker templates',
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

            // === SEARCH BAR ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (v) => studio.setSearchQuery(v),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: isDark ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'Search templates...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  suffixIcon: studio.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchCtrl.clear();
                            studio.setSearchQuery('');
                          },
                        )
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // === CATEGORY CHIPS ===
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: studio.categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CategoryChip(
                      label: _categoryEmoji(cat) + cat,
                      isSelected: studio.selectedCategory == cat,
                      onTap: () => studio.setCategory(cat),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // === GRID ===
            Expanded(
              child: _buildGrid(context, studio, isDark),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryEmoji(String cat) {
    switch (cat) {
      case 'All': return '✨ ';
      case 'Cosmic': return '🌌 ';
      case 'Nature': return '🌿 ';
      case 'Fantasy': return '🐉 ';
      case 'Tech': return '💻 ';
      case 'Vibes': return '🔥 ';
      default: return '';
    }
  }

  Widget _buildGrid(BuildContext context, StudioProvider studio, bool isDark) {
    final templates = studio.selectedCategory == '_favorites'
        ? studio.favoriteTemplates
        : studio.filteredTemplates;

    if (templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              studio.selectedCategory == '_favorites'
                  ? 'No favorites yet'
                  : 'No templates found',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              studio.selectedCategory == '_favorites'
                  ? 'Tap ❤️ on any template to favorite it'
                  : 'Try a different search or category',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _TemplateGridCard(template: template);
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive
              ? StudioTheme.accent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? StudioTheme.accent : Colors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? StudioTheme.accent : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _TemplateGridCard extends StatelessWidget {
  final dynamic template;
  const _TemplateGridCard({required this.template});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studio = context.read<StudioProvider>();

    return GestureDetector(
      onTap: () => _showTemplateOptions(context, studio, template),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? StudioTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Sticker preview centered
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: StickerPreviewWidget(
                  template: template,
                  size: 80,
                  showLabel: false,
                ),
              ),
            ),

            // Name at bottom
            Positioned(
              bottom: 10,
              left: 8,
              right: 8,
              child: Text(
                template.name as String,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black70,
                ),
              ),
            ),

            // Premium badge
            if (template.isPremium as bool)
              Positioned(
                top: 8,
                left: 8,
                child: const PremiumBadge(),
              ),

            // Favorite button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => studio.toggleTemplateFavorite(template.id as String),
                child: Icon(
                  (template.isFavorite as bool)
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 18,
                  color: (template.isFavorite as bool)
                      ? StudioTheme.accent
                      : (isDark ? Colors.white30 : Colors.black26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTemplateOptions(BuildContext context, StudioProvider studio, dynamic template) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
                color: isDark ? Colors.white20 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Preview
            StickerPreviewWidget(template: template, size: 120, showLabel: false),
            const SizedBox(height: 16),

            Text(
              template.name as String,
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0A0E1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${template.category} • ${template.shape} shape',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),

            const SizedBox(height: 28),

            // Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Add to Studio Canvas'),
                onPressed: () {
                  studio.addStickerToCanvas(template);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${template.name} added to canvas!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: StudioTheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: Icon(
                  (template.isFavorite as bool) ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: StudioTheme.accent,
                ),
                label: Text(
                  (template.isFavorite as bool) ? 'Remove from Favorites' : 'Add to Favorites',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: StudioTheme.accent,
                  side: const BorderSide(color: StudioTheme.accent),
                ),
                onPressed: () {
                  studio.toggleTemplateFavorite(template.id as String);
                  Navigator.pop(ctx);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
