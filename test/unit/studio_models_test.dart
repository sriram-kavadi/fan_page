import 'package:flutter_test/flutter_test.dart';
import 'package:nikhils_fantasy_studio/models/studio_models.dart';

void main() {
  group('Studio Models Unit Tests', () {
    test('StickerTemplate creation and copyWith functionality', () {
      final template = StickerTemplate(
        id: 't_dragon',
        name: 'Dragon Scale',
        category: 'Fantasy',
        emoji: '🐉',
        colors: [0xFFFF6B6B, 0xFF9B59B6],
        shape: 'hexagon',
        borderStyle: 'glow',
        isPremium: true,
      );

      expect(template.id, 't_dragon');
      expect(template.name, 'Dragon Scale');
      expect(template.category, 'Fantasy');
      expect(template.emoji, '🐉');
      expect(template.shape, 'hexagon');
      expect(template.isPremium, isTrue);
      expect(template.isFavorite, isFalse);
      expect(template.downloadCount, 0);

      // copyWith favorite toggle
      final faved = template.copyWith(isFavorite: true, downloadCount: 42);
      expect(faved.id, 't_dragon');
      expect(faved.isFavorite, isTrue);
      expect(faved.downloadCount, 42);
      expect(faved.name, 'Dragon Scale');
    });

    test('CanvasStickerItem position, scale, and rotation modifications', () {
      final item = CanvasStickerItem(
        id: 'item_1',
        templateId: 't1',
        emoji: '🌌',
        colors: [0xFF0A84FF, 0xFF9B59B6],
        shape: 'circle',
        x: 100.0,
        y: 150.0,
        scale: 1.2,
        rotation: 0.5,
      );

      expect(item.id, 'item_1');
      expect(item.emoji, '🌌');
      expect(item.x, 100.0);
      expect(item.y, 150.0);
      expect(item.scale, 1.2);
      expect(item.rotation, 0.5);
      expect(item.isSelected, isFalse);

      item.x = 200.0;
      item.scale = 1.5;
      item.isSelected = true;

      expect(item.x, 200.0);
      expect(item.scale, 1.5);
      expect(item.isSelected, isTrue);
    });

    test('CreatedDesign model tracking and favorite toggle', () {
      final now = DateTime.now();
      final design = CreatedDesign(
        id: 'design_1',
        name: 'Cosmic Shield V1',
        canvasBackground: 'dark_grid',
        stickerCount: 4,
        createdAt: now,
        lastModified: now,
        isFavorite: false,
      );

      expect(design.name, 'Cosmic Shield V1');
      expect(design.canvasBackground, 'dark_grid');
      expect(design.stickerCount, 4);
      expect(design.isFavorite, isFalse);

      design.isFavorite = true;
      expect(design.isFavorite, isTrue);
    });

    test('StickerPack model metadata and status', () {
      final pack = StickerPack(
        id: 'pack_fantasy',
        name: 'Fantasy Realm',
        description: 'Legendary creatures pack',
        previewEmoji: '🐉',
        gradientColors: [0xFFFF6B6B, 0xFF9B59B6],
        stickerCount: 6,
        category: 'Fantasy',
        isDownloaded: false,
      );

      expect(pack.name, 'Fantasy Realm');
      expect(pack.previewEmoji, '🐉');
      expect(pack.stickerCount, 6);
      expect(pack.isDownloaded, isFalse);

      pack.isDownloaded = true;
      expect(pack.isDownloaded, isTrue);
    });
  });
}
