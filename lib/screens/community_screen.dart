import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/fan_models.dart';
import '../providers/fan_provider.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = const [
    'All',
    'Inspiration',
    'Charity',
    'Events & Rallies',
    'Cultural Pride',
  ];

  void _showNewWishSheet(BuildContext context, FanProvider fan) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameCtrl = TextEditingController(text: fan.userCard.name);
    final msgCtrl = TextEditingController();
    String district = fan.userCard.district;
    String tag = 'Inspiration';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: EdgeInsets.fromLTRB(20, 24, 20, MediaQuery.of(ctx).viewInsets.bottom + 24),
          decoration: BoxDecoration(
            color: isDark ? RKTheme.surfaceDark : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Post to Community Wall',
                style: TextStyle(fontFamily: 'Outfit', fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Your Name', prefixIcon: Icon(Icons.person_outline)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: msgCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Your Wish / Inspirational Words', prefixIcon: Icon(Icons.edit_note_rounded)),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: tag,
                decoration: const InputDecoration(labelText: 'Category Tag', prefixIcon: Icon(Icons.tag)),
                dropdownColor: isDark ? RKTheme.cardDark : Colors.white,
                items: ['Inspiration', 'Charity', 'Events & Rallies', 'Cultural Pride']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setModalState(() => tag = v!),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty || msgCtrl.text.trim().isEmpty) return;
                    fan.addWish(
                      authorName: nameCtrl.text.trim(),
                      district: district,
                      message: msgCtrl.text.trim(),
                      categoryTag: tag,
                    );
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🎉 Your message was posted to the Fan Wall!'),
                        backgroundColor: RKTheme.emerald,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: RKTheme.primary),
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  label: const Text('Post Wish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fan = context.watch<FanProvider>();

    // Filter wishes
    var filtered = fan.wishes;
    if (_selectedCategory != 'All') {
      filtered = filtered.where((w) => w.categoryTag == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((w) =>
              w.authorName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              w.district.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              w.message.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Community Fan Wall'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewWishSheet(context, fan),
        backgroundColor: RKTheme.primary,
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Post Wish',
          style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Box
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: const InputDecoration(
                hintText: 'Search by volunteer name, district, keyword...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // Categories Horizontal List
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: RKTheme.primary,
                  backgroundColor: isDark ? RKTheme.cardDark : Colors.white,
                  labelStyle: TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Stream List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No community messages found.',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 80),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final w = filtered[index];
                      return Container(
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
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
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
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: isDark ? Colors.white : Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          w.district,
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 12,
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
                            const SizedBox(height: 12),
                            Text(
                              w.message,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black87,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () => fan.toggleLikeWish(w.id),
                              child: Row(
                                children: [
                                  Icon(
                                    w.hasLiked ? Icons.favorite : Icons.favorite_border,
                                    size: 18,
                                    color: w.hasLiked ? RKTheme.primary : (isDark ? Colors.white38 : Colors.black38),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${w.likesCount} Cheers',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 13,
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
