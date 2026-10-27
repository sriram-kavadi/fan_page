import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/api_feed_provider.dart';

/// Experiment 9: REST API Live Feed Screen
class ApiFeedScreen extends StatelessWidget {
  const ApiFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final feed = context.watch<ApiFeedProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Live REST API Feed'),
        actions: [
          IconButton(
            tooltip: 'Refresh Feed',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => feed.fetchFeed(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: TextField(
              onChanged: (v) => feed.setSearchQuery(v),
              decoration: const InputDecoration(
                hintText: 'Filter live API dispatches by keyword...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          // Main Feed States
          Expanded(
            child: _buildBody(context, feed, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ApiFeedProvider feed, bool isDark) {
    // 1. Loading State
    if (feed.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: RKTheme.gold),
            const SizedBox(height: 16),
            Text(
              'Fetching live REST API dispatches...',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
          ],
        ),
      );
    }

    // 2. Error State
    if (feed.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_rounded, size: 56, color: RKTheme.coral),
              const SizedBox(height: 16),
              const Text(
                'Failed to load API feed',
                style: TextStyle(fontFamily: 'Outfit', fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                feed.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Outfit', fontSize: 13, color: isDark ? Colors.white54 : Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => feed.fetchFeed(),
                style: ElevatedButton.styleFrom(backgroundColor: RKTheme.primary),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Connection'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Success State with Pull-to-Refresh
    if (feed.posts.isEmpty) {
      return Center(
        child: Text(
          'No matching dispatches found.',
          style: TextStyle(fontFamily: 'Outfit', color: isDark ? Colors.white38 : Colors.black38),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => feed.refreshFeed(),
      color: RKTheme.gold,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        itemCount: feed.posts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final post = feed.posts[index];
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: RKTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        post.tag.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: RKTheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      'Post #${post.id}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  post.title,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0B0F19),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.body,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 13,
                    color: isDark ? Colors.white70 : Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'By ${post.authorName}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: RKTheme.gold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.favorite, size: 14, color: RKTheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          '${post.likes}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white54 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
