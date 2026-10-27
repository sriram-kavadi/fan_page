import 'package:flutter_test/flutter_test.dart';
import 'package:nikhils_fantasy_studio/providers/studio_provider.dart';

void main() {
  group('StudioProvider Unit Tests', () {
    late StudioProvider provider;

    setUp(() {
      provider = StudioProvider();
    });

    test('Initial provider state has 30 templates across 5 categories and 5 packs', () {
      expect(provider.allTemplates.length, 30);
      expect(provider.packs.length, 5);
      expect(provider.categories.length, 6); // All, Cosmic, Nature, Fantasy, Tech, Vibes
      expect(provider.canvasItems.isEmpty, isTrue);
      expect(provider.savedDesigns.length, 3); // Seed sample designs
      expect(provider.canUndo, isFalse);
      expect(provider.canRedo, isFalse);
    });

    test('Category filtering narrows templates', () {
      provider.setCategory('Cosmic');
      expect(provider.selectedCategory, 'Cosmic');
      expect(provider.filteredTemplates.every((t) => t.category == 'Cosmic'), isTrue);
      expect(provider.filteredTemplates.length, 6);

      provider.setCategory('All');
      expect(provider.filteredTemplates.length, 30);
    });

    test('Search query filters templates by name', () {
      provider.setSearchQuery('dragon');
      expect(provider.filteredTemplates.length, 1);
      expect(provider.filteredTemplates.first.name, 'Dragon Scale');

      provider.setSearchQuery('xyz_nonexistent');
      expect(provider.filteredTemplates.isEmpty, isTrue);

      provider.setSearchQuery('');
      expect(provider.filteredTemplates.length, 30);
    });

    test('Template favorite toggling', () {
      final template = provider.allTemplates.first;
      expect(template.isFavorite, isFalse);

      provider.toggleTemplateFavorite(template.id);
      expect(provider.allTemplates.first.isFavorite, isTrue);
      expect(provider.favoriteTemplates.length, 1);

      provider.toggleTemplateFavorite(template.id);
      expect(provider.allTemplates.first.isFavorite, isFalse);
      expect(provider.favoriteTemplates.isEmpty, isTrue);
    });

    test('Canvas item operations: add, select, move, scale, rotate, and remove', () {
      final template = provider.allTemplates.first;

      // Add to canvas
      provider.addStickerToCanvas(template);
      expect(provider.canvasItems.length, 1);
      final itemId = provider.canvasItems.first.id;
      expect(provider.canUndo, isTrue);

      // Select item
      provider.selectCanvasItem(itemId);
      expect(provider.selectedCanvasItemId, itemId);
      expect(provider.canvasItems.first.isSelected, isTrue);

      // Move item
      final initialX = provider.canvasItems.first.x;
      final initialY = provider.canvasItems.first.y;
      provider.moveCanvasItem(itemId, 15.0, 25.0);
      expect(provider.canvasItems.first.x, initialX + 15.0);
      expect(provider.canvasItems.first.y, initialY + 25.0);

      // Scale item
      provider.scaleCanvasItem(itemId, 1.5);
      expect(provider.canvasItems.first.scale, closeTo(1.5, 0.01));

      // Rotate item
      provider.rotateCanvasItem(itemId, 0.8);
      expect(provider.canvasItems.first.rotation, closeTo(0.8, 0.01));

      // Remove item
      provider.removeStickerFromCanvas(itemId);
      expect(provider.canvasItems.isEmpty, isTrue);
      expect(provider.selectedCanvasItemId, isNull);
    });

    test('Canvas undo and redo history', () {
      final template = provider.allTemplates.first;

      provider.addStickerToCanvas(template);
      expect(provider.canvasItems.length, 1);
      expect(provider.canUndo, isTrue);

      provider.undo();
      expect(provider.canvasItems.isEmpty, isTrue);
      expect(provider.canRedo, isTrue);

      provider.redo();
      expect(provider.canvasItems.length, 1);
    });

    test('Canvas background change', () {
      expect(provider.canvasBackground, 'dark_grid');
      provider.setCanvasBackground('neon_cosmic');
      expect(provider.canvasBackground, 'neon_cosmic');
    });

    test('Saving, toggling favorite, and deleting created design', () {
      final initialCount = provider.savedDesigns.length;

      provider.saveCurrentDesign('My Epic Artwork');
      expect(provider.savedDesigns.length, initialCount + 1);
      final newDesign = provider.savedDesigns.first;
      expect(newDesign.name, 'My Epic Artwork');

      // Toggle favorite
      provider.toggleDesignFavorite(newDesign.id);
      expect(provider.savedDesigns.first.isFavorite, isTrue);

      // Delete design
      provider.deleteDesign(newDesign.id);
      expect(provider.savedDesigns.length, initialCount);
    });

    test('Sticker pack download increments download count', () {
      final pack = provider.packs.firstWhere((p) => !p.isDownloaded);
      final initialDownloads = provider.totalDownloads;

      provider.downloadPack(pack.id);
      expect(provider.packs.firstWhere((p) => p.id == pack.id).isDownloaded, isTrue);
      expect(provider.totalDownloads, initialDownloads + 1);
    });
  });
}
