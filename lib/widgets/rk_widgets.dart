import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/fan_models.dart';

// ============================================================================
// 1. ROYAL EMBLEM CREST (Custom Vector Painter)
// ============================================================================

class RKEmblemCrest extends StatelessWidget {
  final double size;
  final bool showGlow;
  const RKEmblemCrest({super.key, this.size = 80, this.showGlow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: RKTheme.gold.withValues(alpha: 0.4),
                  blurRadius: size * 0.35,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: RKTheme.primary.withValues(alpha: 0.3),
                  blurRadius: size * 0.2,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _EmblemPainter(),
      ),
    );
  }
}

class _EmblemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer Ruby Rim
    final outerRimPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFEF233C), Color(0xFF8D0801)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, outerRimPaint);

    // Golden Laurel Outer Ring
    final goldRingPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFFFFB703),
          Color(0xFFFFF3B0),
          Color(0xFFFB8500),
          Color(0xFFFFB703),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055;
    canvas.drawCircle(center, radius * 0.9, goldRingPaint);

    // Inner Midnight Core
    final innerCorePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFF2E0914), Color(0xFF0B0F19)],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.8));
    canvas.drawCircle(center, radius * 0.82, innerCorePaint);

    // 8 Golden Radiating Star Points
    final starPaint = Paint()
      ..color = const Color(0xFFFFB703).withValues(alpha: 0.35)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 8; i++) {
      final angle = i * (math.pi / 4);
      final p1 = Offset(center.dx + radius * 0.55 * math.cos(angle), center.dy + radius * 0.55 * math.sin(angle));
      final p2 = Offset(center.dx + radius * 0.78 * math.cos(angle), center.dy + radius * 0.78 * math.sin(angle));
      canvas.drawLine(p1, p2, starPaint);
    }

    // Monogram 'RK' Text
    final tp = TextPainter(
      text: TextSpan(
        text: 'RK',
        style: TextStyle(
          fontFamily: 'Outfit',
          fontSize: size.width * 0.38,
          fontWeight: FontWeight.w900,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: [Color(0xFFFFF275), Color(0xFFFFB703), Color(0xFFFB8500)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(Rect.fromCircle(center: center, radius: radius * 0.4)),
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// 2. DIGITAL MEMBERSHIP CARD WIDGET
// ============================================================================

class DigitalMemberCardWidget extends StatelessWidget {
  final FanMemberCard card;
  final bool isLarge;

  const DigitalMemberCardWidget({
    super.key,
    required this.card,
    this.isLarge = true,
  });

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient;
    Color accentColor;

    switch (card.tier) {
      case MemberTier.royalVip:
        gradient = RKTheme.cardVipGradient;
        accentColor = RKTheme.gold;
        break;
      case MemberTier.gold:
        gradient = RKTheme.cardGoldGradient;
        accentColor = const Color(0xFFFFD166);
        break;
      case MemberTier.silver:
        gradient = RKTheme.cardSilverGradient;
        accentColor = Colors.white;
        break;
    }

    return Container(
      width: double.infinity,
      height: isLarge ? 220 : 180,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.6),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Watermark Crest
          Positioned(
            right: -25,
            bottom: -25,
            child: Opacity(
              opacity: 0.12,
              child: RKEmblemCrest(size: 200, showGlow: false),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Row: Association Brand & Tier Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const RKEmblemCrest(size: 34, showGlow: false),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RATHNAVERI KAVITHA',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              'OFFICIAL YOUTH ASSOCIATION',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 8.5,
                                fontWeight: FontWeight.w700,
                                color: accentColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentColor.withValues(alpha: 0.6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, size: 12, color: accentColor),
                          const SizedBox(width: 4),
                          Text(
                            card.tierName.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: accentColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Middle Row: Member Name & ID
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.name.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      card.id,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.7),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                // Bottom Row: District, Blood Group, QR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DISTRICT: ${card.district.toUpperCase()}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'BLOOD GROUP: ${card.bloodGroup}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ],
                    ),

                    // QR Code Box
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomPaint(
                        size: const Size(36, 36),
                        painter: _MockQRPainter(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockQRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final r = size.width / 5;

    // Corner Finder Patterns
    canvas.drawRect(Rect.fromLTWH(0, 0, r * 1.6, r * 1.6), paint);
    canvas.drawRect(Rect.fromLTWH(size.width - r * 1.6, 0, r * 1.6, r * 1.6), paint);
    canvas.drawRect(Rect.fromLTWH(0, size.height - r * 1.6, r * 1.6, r * 1.6), paint);

    // Inner White dots
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(r * 0.4, r * 0.4, r * 0.8, r * 0.8), whitePaint);
    canvas.drawRect(Rect.fromLTWH(size.width - r * 1.2, r * 0.4, r * 0.8, r * 0.8), whitePaint);
    canvas.drawRect(Rect.fromLTWH(r * 0.4, size.height - r * 1.2, r * 0.8, r * 0.8), whitePaint);

    // Center Data Dots
    canvas.drawRect(Rect.fromLTWH(r * 2.2, r * 2.2, r * 0.8, r * 0.8), paint);
    canvas.drawRect(Rect.fromLTWH(r * 3.4, r * 2.0, r * 0.6, r * 0.6), paint);
    canvas.drawRect(Rect.fromLTWH(r * 1.8, r * 3.6, r * 0.6, r * 0.6), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// 3. PULSE CHEER BUTTON
// ============================================================================

class PulseCheerButton extends StatefulWidget {
  final int count;
  final VoidCallback onTap;

  const PulseCheerButton({
    super.key,
    required this.count,
    required this.onTap,
  });

  @override
  State<PulseCheerButton> createState() => _PulseCheerButtonState();
}

class _PulseCheerButtonState extends State<PulseCheerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.9,
      upperBound: 1.15,
    );
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _handleTap() {
    _anim.forward().then((_) => _anim.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _anim,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: RKTheme.rubyGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: RKTheme.primary.withValues(alpha: 0.4),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'Cheer (${widget.count})',
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
