import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/fan_models.dart';
import '../providers/fan_provider.dart';
import '../widgets/rk_widgets.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  void _showEventPassModal(BuildContext context, FanEvent event, FanProvider fan) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? RKTheme.surfaceDark : Colors.white,
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
            const SizedBox(height: 18),
            const Text(
              'Official Event Entry Pass',
              style: TextStyle(fontFamily: 'Outfit', fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              'Show this pass at the gate for priority entry.',
              style: TextStyle(fontFamily: 'Outfit', fontSize: 13, color: isDark ? Colors.white60 : Colors.black54),
            ),
            const SizedBox(height: 20),
            DigitalMemberCardWidget(card: fan.userCard, isLarge: false),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? RKTheme.cardDark : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Event', style: TextStyle(fontWeight: FontWeight.w700)),
                      Flexible(child: Text(event.title, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w800, color: RKTheme.primary))),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Date & Time', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text('${event.date} (${event.time.split(" - ").first})', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Venue', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(event.venue, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(backgroundColor: RKTheme.primary),
                child: const Text('Close Pass'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fan = context.watch<FanProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Events & Rallies'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        itemCount: fan.events.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final e = fan.events[index];
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? RKTheme.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
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
                        e.category.toUpperCase(),
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
                          '${e.attendingCount} Confirmed',
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: RKTheme.gold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  e.title,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0B0F19),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  e.description,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 13,
                    color: isDark ? Colors.white60 : Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 14, color: isDark ? Colors.white38 : Colors.black38),
                    const SizedBox(width: 6),
                    Text(
                      e.date,
                      style: TextStyle(fontFamily: 'Outfit', fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black87),
                    ),
                    const SizedBox(width: 14),
                    Icon(Icons.schedule_rounded, size: 14, color: isDark ? Colors.white38 : Colors.black38),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        e.time,
                        style: TextStyle(fontFamily: 'Outfit', fontSize: 12, color: isDark ? Colors.white70 : Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.pin_drop_rounded, size: 14, color: isDark ? Colors.white38 : Colors.black38),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '${e.venue}, ${e.district}',
                        style: TextStyle(fontFamily: 'Outfit', fontSize: 12, color: isDark ? Colors.white60 : Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => fan.toggleEventRegistration(e.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: e.isRegistered ? RKTheme.emerald : RKTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: Icon(e.isRegistered ? Icons.check_circle : Icons.how_to_reg_outlined, size: 18),
                        label: Text(e.isRegistered ? 'RSVP ACTIVE' : 'RSVP ATTEND'),
                      ),
                    ),
                    if (e.isRegistered) ...[
                      const SizedBox(width: 10),
                      IconButton(
                        tooltip: 'View Entry Pass',
                        icon: const Icon(Icons.qr_code_2, color: RKTheme.gold, size: 28),
                        onPressed: () => _showEventPassModal(context, e, fan),
                      ),
                    ],
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
