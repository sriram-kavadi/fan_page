import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/studio_models.dart';

/// Renders a single sticker preview based on shape + gradient + emoji
class StickerPreviewWidget extends StatelessWidget {
  final dynamic template; // StickerTemplate or CanvasStickerItem
  final double size;
  final bool showLabel;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const StickerPreviewWidget({
    super.key,
    required this.template,
    this.size = 90,
    this.showLabel = true,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = (template.colors as List).map((c) => Color(c as int)).toList();
    final emoji = template.emoji as String;
    final shape = template.shape as String;
    String name = '';
    if (template is StickerTemplate) {
      name = (template as StickerTemplate).name;
    } else {
      try {
        name = (template as dynamic).name ?? '';
      } catch (_) {}
    }

    Widget sticker = _StickerShape(
      size: size,
      colors: colors,
      emoji: emoji,
      shape: shape,
      isSelected: isSelected,
    );

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sticker,
          if (showLabel && name.isNotEmpty) ...[
            const SizedBox(height: 6),
            SizedBox(
              width: size + 10,
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white60
                      : Colors.black54,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

mixin _HasName {
  String get name;
}

// ========================= STICKER SHAPE RENDERER =========================

class _StickerShape extends StatelessWidget {
  final double size;
  final List<Color> colors;
  final String emoji;
  final String shape;
  final bool isSelected;

  const _StickerShape({
    required this.size,
    required this.colors,
    required this.emoji,
    required this.shape,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: colors.length >= 2 ? colors : [colors.first, colors.first],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    Widget content = Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size * 0.45),
        ),
      ),
    );

    Widget shaped;
    switch (shape) {
      case 'circle':
        shaped = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.4),
                blurRadius: size * 0.3,
                offset: Offset(0, size * 0.08),
              ),
            ],
          ),
          child: Center(child: Text(emoji, style: TextStyle(fontSize: size * 0.45))),
        );
        break;
      case 'star':
        shaped = CustomPaint(
          size: Size(size, size),
          painter: _StarPainter(gradient: gradient, emoji: emoji, glowColor: colors.first),
        );
        break;
      case 'hexagon':
        shaped = CustomPaint(
          size: Size(size, size),
          painter: _HexPainter(gradient: gradient, emoji: emoji, glowColor: colors.first),
        );
        break;
      case 'shield':
        shaped = CustomPaint(
          size: Size(size, size),
          painter: _ShieldPainter(gradient: gradient, emoji: emoji, glowColor: colors.first),
        );
        break;
      case 'diamond':
        shaped = CustomPaint(
          size: Size(size, size),
          painter: _DiamondPainter(gradient: gradient, emoji: emoji, glowColor: colors.first),
        );
        break;
      case 'heart':
        shaped = CustomPaint(
          size: Size(size, size),
          painter: _HeartPainter(gradient: gradient, emoji: emoji, glowColor: colors.first),
        );
        break;
      default:
        shaped = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: colors.first.withValues(alpha: 0.3),
                blurRadius: size * 0.2,
              ),
            ],
          ),
          child: Center(child: Text(emoji, style: TextStyle(fontSize: size * 0.45))),
        );
    }

    if (isSelected) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size + 8,
            height: size + 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
          ),
          shaped,
        ],
      );
    }

    return shaped;
  }
}

// ========================= SHAPE PAINTERS =========================

class _StarPainter extends CustomPainter {
  final LinearGradient gradient;
  final String emoji;
  final Color glowColor;
  _StarPainter({required this.gradient, required this.emoji, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.45;
    const points = 5;
    final path = Path();

    for (int i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * math.pi / points) - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 6);
    canvas.drawPath(path, paint);

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, fillPaint);

    final tp = TextPainter(
      text: TextSpan(text: emoji, style: TextStyle(fontSize: size.width * 0.4)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HexPainter extends CustomPainter {
  final LinearGradient gradient;
  final String emoji;
  final Color glowColor;
  _HexPainter({required this.gradient, required this.emoji, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    final path = Path();

    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi / 3) - math.pi / 6;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();

    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
    canvas.drawPath(path, glowPaint);

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, fillPaint);

    final tp = TextPainter(
      text: TextSpan(text: emoji, style: TextStyle(fontSize: size.width * 0.4)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShieldPainter extends CustomPainter {
  final LinearGradient gradient;
  final String emoji;
  final Color glowColor;
  _ShieldPainter({required this.gradient, required this.emoji, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.6);
    path.quadraticBezierTo(w, h * 0.9, w * 0.5, h);
    path.quadraticBezierTo(0, h * 0.9, 0, h * 0.6);
    path.lineTo(0, h * 0.25);
    path.close();

    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
    canvas.drawPath(path, glowPaint);

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    final center = Offset(w / 2, h * 0.5);
    final tp = TextPainter(
      text: TextSpan(text: emoji, style: TextStyle(fontSize: w * 0.4)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiamondPainter extends CustomPainter {
  final LinearGradient gradient;
  final String emoji;
  final Color glowColor;
  _DiamondPainter({required this.gradient, required this.emoji, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.5);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.5);
    path.close();

    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
    canvas.drawPath(path, glowPaint);

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    final center = Offset(w / 2, h / 2);
    final tp = TextPainter(
      text: TextSpan(text: emoji, style: TextStyle(fontSize: w * 0.38)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeartPainter extends CustomPainter {
  final LinearGradient gradient;
  final String emoji;
  final Color glowColor;
  _HeartPainter({required this.gradient, required this.emoji, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, h * 0.35);
    path.cubicTo(w * 0.5, h * 0.25, w * 0.35, 0, 0, h * 0.25);
    path.cubicTo(0, h * 0.6, w * 0.5, h * 0.8, w * 0.5, h);
    path.moveTo(w * 0.5, h * 0.35);
    path.cubicTo(w * 0.5, h * 0.25, w * 0.65, 0, w, h * 0.25);
    path.cubicTo(w, h * 0.6, w * 0.5, h * 0.8, w * 0.5, h);

    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);
    canvas.drawPath(path, glowPaint);

    final fillPaint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, fillPaint);

    final center = Offset(w / 2, h * 0.55);
    final tp = TextPainter(
      text: TextSpan(text: emoji, style: TextStyle(fontSize: w * 0.38)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ========================= PREMIUM BADGE =========================

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        gradient: StudioTheme.accentGradient,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'PRO',
        style: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ========================= CATEGORY CHIP =========================

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? StudioTheme.primaryGradient : null,
          color: isSelected
              ? null
              : (isDark ? StudioTheme.cardDark : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? Colors.white12 : Colors.black12),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: StudioTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white60 : Colors.black54),
          ),
        ),
      ),
    );
  }
}

// ========================= GLASS CARD =========================

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
