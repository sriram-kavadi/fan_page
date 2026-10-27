import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/studio_provider.dart';
import '../models/studio_models.dart';
import '../widgets/studio_widgets.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  bool _showTemplatePanel = false;
  String? _activeItemId;
  final GlobalKey _canvasKey = GlobalKey();

  // Canvas dimensions
  static const double _canvasWidth = 340;
  static const double _canvasHeight = 380;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final studio = context.watch<StudioProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // === TOP TOOLBAR ===
            _TopToolbar(
              studio: studio,
              isDark: isDark,
              onShowTemplates: () => setState(() => _showTemplatePanel = !_showTemplatePanel),
              showTemplatePanel: _showTemplatePanel,
            ),

            // === CANVAS AREA ===
            Expanded(
              child: Stack(
                children: [
                  // Canvas
                  Center(
                    child: _StickerCanvas(
                      studio: studio,
                      isDark: isDark,
                      canvasKey: _canvasKey,
                      onSelectItem: (id) {
                        setState(() => _activeItemId = id);
                        studio.selectCanvasItem(id);
                      },
                      activeItemId: _activeItemId,
                    ),
                  ),

                  // Selected item controls
                  if (_activeItemId != null && studio.canvasItems.any((i) => i.id == _activeItemId))
                    Positioned(
                      bottom: 12,
                      left: 20,
                      right: 20,
                      child: _ItemControls(
                        itemId: _activeItemId!,
                        studio: studio,
                        onDeselect: () {
                          setState(() => _activeItemId = null);
                          studio.selectCanvasItem(null);
                        },
                        isDark: isDark,
                      ),
                    ),
                ],
              ),
            ),

            // === BACKGROUND PICKER ===
            _BackgroundPicker(studio: studio, isDark: isDark),

            // === TEMPLATE PANEL ===
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _showTemplatePanel ? 200 : 0,
              child: _showTemplatePanel
                  ? _TemplatePanel(studio: studio)
                  : const SizedBox.shrink(),
            ),

            // === BOTTOM SAVE TOOLBAR ===
            _BottomSaveBar(
              studio: studio,
              isDark: isDark,
              onSave: () => _showSaveDialog(context, studio),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context, StudioProvider studio) {
    final ctrl = TextEditingController(
        text: 'Design ${studio.savedDesigns.length + 1}');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? StudioTheme.surfaceDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Save Design',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0A0E1A),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Give your design a name to save it to My Designs',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 13,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              autofocus: true,
              style: TextStyle(
                fontFamily: 'Outfit',
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: const InputDecoration(
                labelText: 'Design Name',
                prefixIcon: Icon(Icons.edit_rounded),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                studio.saveCurrentDesign(ctrl.text.trim());
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Design "${ctrl.text.trim()}" saved! 🎨'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: StudioTheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ========================== TOP TOOLBAR ==========================

class _TopToolbar extends StatelessWidget {
  final StudioProvider studio;
  final bool isDark;
  final VoidCallback onShowTemplates;
  final bool showTemplatePanel;

  const _TopToolbar({
    required this.studio,
    required this.isDark,
    required this.onShowTemplates,
    required this.showTemplatePanel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? StudioTheme.bgDark.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '✦ Studio',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0A0E1A),
            ),
          ),
          const Spacer(),

          // Undo
          _ToolButton(
            icon: Icons.undo_rounded,
            tooltip: 'Undo',
            enabled: studio.canUndo,
            onTap: studio.undo,
            isDark: isDark,
          ),
          const SizedBox(width: 4),

          // Redo
          _ToolButton(
            icon: Icons.redo_rounded,
            tooltip: 'Redo',
            enabled: studio.canRedo,
            onTap: studio.redo,
            isDark: isDark,
          ),
          const SizedBox(width: 4),

          // Clear canvas
          _ToolButton(
            icon: Icons.delete_outline_rounded,
            tooltip: 'Clear All',
            enabled: studio.canvasItems.isNotEmpty,
            onTap: studio.clearCanvas,
            isDark: isDark,
            isDestructive: true,
          ),

          const SizedBox(width: 8),

          // Add template button
          GestureDetector(
            onTap: onShowTemplates,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: showTemplatePanel ? StudioTheme.primaryGradient : null,
                color: showTemplatePanel ? null : StudioTheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    showTemplatePanel ? Icons.keyboard_arrow_down_rounded : Icons.add_rounded,
                    color: showTemplatePanel ? Colors.white : StudioTheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: showTemplatePanel ? Colors.white : StudioTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool enabled;
  final VoidCallback onTap;
  final bool isDark;
  final bool isDestructive;

  const _ToolButton({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.onTap,
    required this.isDark,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled
        ? (isDestructive ? StudioTheme.accent : StudioTheme.primary)
        : (isDark ? Colors.white20 : Colors.black20);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 22, color: color),
        ),
      ),
    );
  }
}

// ========================== CANVAS ==========================

class _StickerCanvas extends StatelessWidget {
  final StudioProvider studio;
  final bool isDark;
  final GlobalKey canvasKey;
  final Function(String?) onSelectItem;
  final String? activeItemId;

  const _StickerCanvas({
    required this.studio,
    required this.isDark,
    required this.canvasKey,
    required this.onSelectItem,
    required this.activeItemId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: StudioTheme.primary.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GestureDetector(
          onTap: () => onSelectItem(null),
          child: Stack(
            key: canvasKey,
            children: [
              // Canvas background
              _CanvasBackground(background: studio.canvasBackground),

              // Canvas items
              ...studio.canvasItems.map((item) {
                return _DraggableStickerItem(
                  key: ValueKey(item.id),
                  item: item,
                  onSelect: () => onSelectItem(item.id),
                  onMove: (dx, dy) => studio.moveCanvasItem(item.id, dx, dy),
                );
              }),

              // Empty state
              if (studio.canvasItems.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '✦',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your canvas is empty',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap "Add" to place stickers',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CanvasBackground extends StatelessWidget {
  final String background;
  const _CanvasBackground({required this.background});

  @override
  Widget build(BuildContext context) {
    switch (background) {
      case 'dark_grid':
        return Container(
          color: const Color(0xFF0A0E1A),
          child: CustomPaint(
            painter: _GridPainter(color: Colors.white.withValues(alpha: 0.05)),
          ),
        );
      case 'dark_dots':
        return Container(
          color: const Color(0xFF111827),
          child: CustomPaint(
            painter: _DotsPainter(color: Colors.white.withValues(alpha: 0.06)),
          ),
        );
      case 'gradient_sunset':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A0A2E), Color(0xFF3D0F47), Color(0xFF7B1F4B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      case 'gradient_ocean':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001428), Color(0xFF003D6B), Color(0xFF0066B3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      case 'gradient_forest':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A1F0A), Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      case 'gradient_purple':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D0024), Color(0xFF3A0070), Color(0xFF6A1B9A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      case 'white_clean':
        return Container(color: Colors.white);
      default:
        return Container(
          color: const Color(0xFF0A0E1A),
          child: CustomPaint(
            painter: _GridPainter(color: Colors.white.withValues(alpha: 0.05)),
          ),
        );
    }
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 0.5;
    const step = 30.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DotsPainter extends CustomPainter {
  final Color color;
  _DotsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const step = 25.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DraggableStickerItem extends StatefulWidget {
  final CanvasStickerItem item;
  final VoidCallback onSelect;
  final Function(double dx, double dy) onMove;

  const _DraggableStickerItem({
    super.key,
    required this.item,
    required this.onSelect,
    required this.onMove,
  });

  @override
  State<_DraggableStickerItem> createState() => _DraggableStickerItemState();
}

class _DraggableStickerItemState extends State<_DraggableStickerItem> {
  Offset? _lastPan;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final stickerSize = 80.0 * item.scale;

    return Positioned(
      left: item.x,
      top: item.y,
      child: GestureDetector(
        onTap: widget.onSelect,
        onPanStart: (_) {
          widget.onSelect();
          _lastPan = null;
        },
        onPanUpdate: (details) {
          widget.onMove(details.delta.dx, details.delta.dy);
        },
        child: Transform.rotate(
          angle: item.rotation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: item.isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(stickerSize / 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  )
                : null,
            child: StickerPreviewWidget(
              template: item,
              size: stickerSize,
              showLabel: false,
              isSelected: item.isSelected,
            ),
          ),
        ),
      ),
    );
  }
}

// ========================== ITEM CONTROLS ==========================

class _ItemControls extends StatelessWidget {
  final String itemId;
  final StudioProvider studio;
  final VoidCallback onDeselect;
  final bool isDark;

  const _ItemControls({
    required this.itemId,
    required this.studio,
    required this.onDeselect,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? StudioTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            icon: Icons.zoom_in_rounded,
            label: 'Scale+',
            color: StudioTheme.primary,
            onTap: () => studio.scaleCanvasItem(itemId, 1.15),
          ),
          _ControlButton(
            icon: Icons.zoom_out_rounded,
            label: 'Scale-',
            color: StudioTheme.primary,
            onTap: () => studio.scaleCanvasItem(itemId, 0.87),
          ),
          _ControlButton(
            icon: Icons.rotate_left_rounded,
            label: 'Rotate↺',
            color: StudioTheme.secondary,
            onTap: () => studio.rotateCanvasItem(itemId, -0.25),
          ),
          _ControlButton(
            icon: Icons.rotate_right_rounded,
            label: 'Rotate↻',
            color: StudioTheme.secondary,
            onTap: () => studio.rotateCanvasItem(itemId, 0.25),
          ),
          _ControlButton(
            icon: Icons.delete_outline_rounded,
            label: 'Remove',
            color: StudioTheme.accent,
            onTap: () {
              studio.removeStickerFromCanvas(itemId);
              onDeselect();
            },
          ),
          _ControlButton(
            icon: Icons.check_rounded,
            label: 'Done',
            color: StudioTheme.secondary,
            onTap: onDeselect,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ========================== BACKGROUND PICKER ==========================

class _BackgroundPicker extends StatelessWidget {
  final StudioProvider studio;
  final bool isDark;

  const _BackgroundPicker({required this.studio, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final backgrounds = [
      _BgOption('dark_grid', const Color(0xFF0A0E1A), '⬛ Grid'),
      _BgOption('dark_dots', const Color(0xFF111827), '⚫ Dots'),
      _BgOption('gradient_sunset', const Color(0xFF7B1F4B), '🌅 Sunset'),
      _BgOption('gradient_ocean', const Color(0xFF003D6B), '🌊 Ocean'),
      _BgOption('gradient_forest', const Color(0xFF1B5E20), '🌿 Forest'),
      _BgOption('gradient_purple', const Color(0xFF3A0070), '💜 Purple'),
      _BgOption('white_clean', Colors.grey.shade200, '⬜ White'),
    ];

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? StudioTheme.bgDark2 : Colors.grey.shade100,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'BG:',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: backgrounds.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final bg = backgrounds[index];
                final isSelected = studio.canvasBackground == bg.key;
                return GestureDetector(
                  onTap: () => studio.setCanvasBackground(bg.key),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: bg.color,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? StudioTheme.primary : Colors.transparent,
                            width: 2.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: StudioTheme.primary.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        bg.label.split(' ').last,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 9,
                          color: isDark ? Colors.white38 : Colors.black38,
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

class _BgOption {
  final String key;
  final Color color;
  final String label;
  const _BgOption(this.key, this.color, this.label);
}

// ========================== TEMPLATE PANEL ==========================

class _TemplatePanel extends StatelessWidget {
  final StudioProvider studio;
  const _TemplatePanel({required this.studio});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? StudioTheme.surfaceDark : Colors.grey.shade50,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: Row(
              children: [
                Text(
                  'Choose a Template',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                const Spacer(),
                Text(
                  '${studio.allTemplates.length} templates',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: studio.allTemplates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final template = studio.allTemplates[index];
                return GestureDetector(
                  onTap: () {
                    studio.addStickerToCanvas(template);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${template.name} added!'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: StudioTheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StickerPreviewWidget(
                        template: template,
                        size: 62,
                        showLabel: false,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 70,
                        child: Text(
                          template.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 10,
                            color: isDark ? Colors.white54 : Colors.black54,
                          ),
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

// ========================== BOTTOM SAVE BAR ==========================

class _BottomSaveBar extends StatelessWidget {
  final StudioProvider studio;
  final bool isDark;
  final VoidCallback onSave;

  const _BottomSaveBar({
    required this.studio,
    required this.isDark,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? StudioTheme.bgDark.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${studio.canvasItems.length} sticker${studio.canvasItems.length == 1 ? '' : 's'} on canvas',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 13,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: const Icon(Icons.save_alt_rounded, size: 18),
            label: const Text('Save Design'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  studio.canvasItems.isEmpty ? Colors.grey : StudioTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: studio.canvasItems.isEmpty ? null : onSave,
          ),
        ],
      ),
    );
  }
}
