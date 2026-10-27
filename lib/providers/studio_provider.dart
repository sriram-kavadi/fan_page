import 'package:flutter/foundation.dart';
import '../models/studio_models.dart';

class StudioProvider extends ChangeNotifier {
  // === TEMPLATE LIBRARY ===
  final List<StickerTemplate> _templates = [
    // COSMIC category
    StickerTemplate(id: 't1', name: 'Galaxy Nova', category: 'Cosmic', emoji: '🌌', colors: [0xFF0A84FF, 0xFF9B59B6], shape: 'circle', borderStyle: 'glow'),
    StickerTemplate(id: 't2', name: 'Solar Flare', category: 'Cosmic', emoji: '☀️', colors: [0xFFFFD700, 0xFFFF6B6B], shape: 'star', borderStyle: 'glow'),
    StickerTemplate(id: 't3', name: 'Aurora Ring', category: 'Cosmic', emoji: '🌌', colors: [0xFF00C896, 0xFF0A84FF], shape: 'hexagon', borderStyle: 'glow'),
    StickerTemplate(id: 't4', name: 'Moon Phase', category: 'Cosmic', emoji: '🌙', colors: [0xFF1A1A2E, 0xFF4A00E0], shape: 'circle', borderStyle: 'solid'),
    StickerTemplate(id: 't5', name: 'Nebula Cloud', category: 'Cosmic', emoji: '✨', colors: [0xFF9B59B6, 0xFFFF6B6B], shape: 'diamond'),
    StickerTemplate(id: 't6', name: 'Comet Trail', category: 'Cosmic', emoji: '☄️', colors: [0xFF00BCD4, 0xFF0A84FF], shape: 'shield'),

    // NATURE category
    StickerTemplate(id: 't7', name: 'Forest Spirit', category: 'Nature', emoji: '🌿', colors: [0xFF2ECC71, 0xFF00C896], shape: 'circle', borderStyle: 'glow'),
    StickerTemplate(id: 't8', name: 'Ocean Wave', category: 'Nature', emoji: '🌊', colors: [0xFF0A84FF, 0xFF00BCD4], shape: 'hexagon', borderStyle: 'glow'),
    StickerTemplate(id: 't9', name: 'Cherry Blossom', category: 'Nature', emoji: '🌸', colors: [0xFFFF6B6B, 0xFFFF8E8E], shape: 'heart', borderStyle: 'glow'),
    StickerTemplate(id: 't10', name: 'Thunder Storm', category: 'Nature', emoji: '⚡', colors: [0xFFFFD700, 0xFF444444], shape: 'diamond', borderStyle: 'solid'),
    StickerTemplate(id: 't11', name: 'Crystal Snow', category: 'Nature', emoji: '❄️', colors: [0xFFB3E5FC, 0xFF0A84FF], shape: 'star', borderStyle: 'glow'),
    StickerTemplate(id: 't12', name: 'Volcano Fire', category: 'Nature', emoji: '🌋', colors: [0xFFFF6B6B, 0xFFFFD700], shape: 'shield'),

    // FANTASY category
    StickerTemplate(id: 't13', name: 'Dragon Scale', category: 'Fantasy', emoji: '🐉', colors: [0xFFFF6B6B, 0xFF9B59B6], shape: 'hexagon', borderStyle: 'glow', isPremium: true),
    StickerTemplate(id: 't14', name: 'Phoenix Flame', category: 'Fantasy', emoji: '🦅', colors: [0xFFFFD700, 0xFFFF6B6B], shape: 'star', borderStyle: 'glow', isPremium: true),
    StickerTemplate(id: 't15', name: 'Unicorn Magic', category: 'Fantasy', emoji: '🦄', colors: [0xFFFF6B6B, 0xFF9B59B6], shape: 'heart', borderStyle: 'glow'),
    StickerTemplate(id: 't16', name: 'Crystal Sword', category: 'Fantasy', emoji: '⚔️', colors: [0xFF00BCD4, 0xFF9B59B6], shape: 'diamond', borderStyle: 'solid'),
    StickerTemplate(id: 't17', name: 'Magic Portal', category: 'Fantasy', emoji: '🌀', colors: [0xFF9B59B6, 0xFF0A84FF], shape: 'circle', borderStyle: 'glow', isPremium: true),
    StickerTemplate(id: 't18', name: 'Mermaid Tail', category: 'Fantasy', emoji: '🧜', colors: [0xFF00C896, 0xFF00BCD4], shape: 'shield'),

    // TECH category
    StickerTemplate(id: 't19', name: 'Cyber Circuit', category: 'Tech', emoji: '💻', colors: [0xFF0A84FF, 0xFF00BCD4], shape: 'hexagon', borderStyle: 'glow'),
    StickerTemplate(id: 't20', name: 'Neon Matrix', category: 'Tech', emoji: '🤖', colors: [0xFF00C896, 0xFF0A84FF], shape: 'shield', borderStyle: 'glow'),
    StickerTemplate(id: 't21', name: 'Pixel Power', category: 'Tech', emoji: '🎮', colors: [0xFF9B59B6, 0xFF0A84FF], shape: 'circle', borderStyle: 'solid'),
    StickerTemplate(id: 't22', name: 'AI Nexus', category: 'Tech', emoji: '🧠', colors: [0xFF0A84FF, 0xFF9B59B6], shape: 'diamond', borderStyle: 'glow', isPremium: true),
    StickerTemplate(id: 't23', name: 'Quantum Bit', category: 'Tech', emoji: '⚛️', colors: [0xFF00BCD4, 0xFF0A84FF], shape: 'star'),
    StickerTemplate(id: 't24', name: 'Data Stream', category: 'Tech', emoji: '📡', colors: [0xFF00C896, 0xFF007B55], shape: 'hexagon'),

    // VIBES category
    StickerTemplate(id: 't25', name: 'Fire King', category: 'Vibes', emoji: '🔥', colors: [0xFFFF6B6B, 0xFFFFD700], shape: 'circle', borderStyle: 'glow'),
    StickerTemplate(id: 't26', name: 'Crown Royal', category: 'Vibes', emoji: '👑', colors: [0xFFFFD700, 0xFFFF8C00], shape: 'star', borderStyle: 'glow', isPremium: true),
    StickerTemplate(id: 't27', name: 'Legend Badge', category: 'Vibes', emoji: '🏆', colors: [0xFFFFD700, 0xFF9B59B6], shape: 'shield', borderStyle: 'glow'),
    StickerTemplate(id: 't28', name: 'Chill Wave', category: 'Vibes', emoji: '🌈', colors: [0xFF9B59B6, 0xFF00C896], shape: 'hexagon'),
    StickerTemplate(id: 't29', name: 'Zen Circle', category: 'Vibes', emoji: '☯️', colors: [0xFF1A1A2E, 0xFF0A84FF], shape: 'circle', borderStyle: 'solid'),
    StickerTemplate(id: 't30', name: 'Lucky Star', category: 'Vibes', emoji: '⭐', colors: [0xFFFFD700, 0xFFFF6B6B], shape: 'star', borderStyle: 'glow'),
  ];

  // === STICKER PACKS ===
  final List<StickerPack> _packs = [
    StickerPack(
      id: 'pack_1',
      name: 'Cosmic Explorer',
      description: 'Journey through galaxies with 6 stunning cosmic stickers',
      previewEmoji: '🌌',
      gradientColors: [0xFF0A84FF, 0xFF9B59B6],
      stickerCount: 6,
      category: 'Cosmic',
      isDownloaded: true,
    ),
    StickerPack(
      id: 'pack_2',
      name: 'Fantasy Realm',
      description: 'Unlock legendary dragon, phoenix & unicorn power stickers',
      previewEmoji: '🐉',
      gradientColors: [0xFFFF6B6B, 0xFF9B59B6],
      stickerCount: 6,
      category: 'Fantasy',
    ),
    StickerPack(
      id: 'pack_3',
      name: 'Nature Force',
      description: 'Channel the raw power of nature in every sticker',
      previewEmoji: '🌊',
      gradientColors: [0xFF2ECC71, 0xFF00BCD4],
      stickerCount: 6,
      category: 'Nature',
    ),
    StickerPack(
      id: 'pack_4',
      name: 'Tech Cyberverse',
      description: 'Futuristic AI and digital circuit themed stickers',
      previewEmoji: '🤖',
      gradientColors: [0xFF0A84FF, 0xFF00C896],
      stickerCount: 6,
      category: 'Tech',
    ),
    StickerPack(
      id: 'pack_5',
      name: 'Vibe Nation',
      description: 'Crown, trophies, fire & legendary vibes for winners',
      previewEmoji: '👑',
      gradientColors: [0xFFFFD700, 0xFFFF6B6B],
      stickerCount: 6,
      category: 'Vibes',
    ),
  ];

  // === CANVAS ITEMS ===
  final List<CanvasStickerItem> _canvasItems = [];
  String _canvasBackground = 'dark_grid'; // canvas background key
  List<List<CanvasStickerItem>> _undoStack = [];
  List<List<CanvasStickerItem>> _redoStack = [];
  String? _selectedCanvasItemId;

  // === CREATED DESIGNS ===
  final List<CreatedDesign> _savedDesigns = [
    CreatedDesign(
      id: 'design_1',
      name: 'Galaxy Explorer',
      canvasBackground: 'dark_grid',
      stickerCount: 4,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      lastModified: DateTime.now().subtract(const Duration(days: 1)),
      isFavorite: true,
    ),
    CreatedDesign(
      id: 'design_2',
      name: 'Fire Nation',
      canvasBackground: 'gradient_sunset',
      stickerCount: 6,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastModified: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CreatedDesign(
      id: 'design_3',
      name: 'Cyber Circuit',
      canvasBackground: 'dark_dots',
      stickerCount: 3,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      lastModified: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  // === SEARCH & FILTER ===
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // === STATS ===
  int totalDownloads = 12400;
  int totalTemplates = 30;
  int totalPacks = 5;

  // === GETTERS ===
  List<StickerTemplate> get allTemplates => List.unmodifiable(_templates);
  List<StickerPack> get packs => List.unmodifiable(_packs);
  List<CanvasStickerItem> get canvasItems => List.unmodifiable(_canvasItems);
  List<CreatedDesign> get savedDesigns => List.unmodifiable(_savedDesigns);
  String get canvasBackground => _canvasBackground;
  String? get selectedCanvasItemId => _selectedCanvasItemId;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  List<StickerTemplate> get favoriteTemplates =>
      _templates.where((t) => t.isFavorite).toList();

  List<CreatedDesign> get favoriteDesigns =>
      _savedDesigns.where((d) => d.isFavorite).toList();

  List<String> get categories => ['All', 'Cosmic', 'Nature', 'Fantasy', 'Tech', 'Vibes'];

  List<StickerTemplate> get filteredTemplates {
    var list = _selectedCategory == 'All'
        ? _templates
        : _templates.where((t) => t.category == _selectedCategory).toList();

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((t) =>
              t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              t.category.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return list;
  }

  // === TEMPLATE ACTIONS ===
  void toggleTemplateFavorite(String id) {
    final index = _templates.indexWhere((t) => t.id == id);
    if (index != -1) {
      final t = _templates[index];
      _templates[index] = t.copyWith(isFavorite: !t.isFavorite);
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // === CANVAS ACTIONS ===
  void addStickerToCanvas(StickerTemplate template) {
    _pushUndo();
    _canvasItems.add(CanvasStickerItem(
      id: 'item_${DateTime.now().millisecondsSinceEpoch}',
      templateId: template.id,
      emoji: template.emoji,
      colors: template.colors,
      shape: template.shape,
      textOverlay: template.textOverlay,
      x: 100 + (_canvasItems.length * 20) % 200,
      y: 100 + (_canvasItems.length * 20) % 200,
    ));
    notifyListeners();
  }

  void removeStickerFromCanvas(String itemId) {
    _pushUndo();
    _canvasItems.removeWhere((item) => item.id == itemId);
    if (_selectedCanvasItemId == itemId) _selectedCanvasItemId = null;
    notifyListeners();
  }

  void selectCanvasItem(String? itemId) {
    _selectedCanvasItemId = itemId;
    for (var item in _canvasItems) {
      item.isSelected = item.id == itemId;
    }
    notifyListeners();
  }

  void moveCanvasItem(String itemId, double dx, double dy) {
    final index = _canvasItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _canvasItems[index].x += dx;
      _canvasItems[index].y += dy;
      notifyListeners();
    }
  }

  void scaleCanvasItem(String itemId, double scale) {
    final index = _canvasItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _canvasItems[index].scale = (_canvasItems[index].scale * scale).clamp(0.3, 4.0);
      notifyListeners();
    }
  }

  void rotateCanvasItem(String itemId, double angle) {
    final index = _canvasItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _canvasItems[index].rotation += angle;
      notifyListeners();
    }
  }

  void clearCanvas() {
    _pushUndo();
    _canvasItems.clear();
    _selectedCanvasItemId = null;
    notifyListeners();
  }

  void setCanvasBackground(String bg) {
    _canvasBackground = bg;
    notifyListeners();
  }

  void _pushUndo() {
    _undoStack.add(_canvasItems.map((item) => CanvasStickerItem(
      id: item.id,
      templateId: item.templateId,
      emoji: item.emoji,
      colors: item.colors,
      shape: item.shape,
      textOverlay: item.textOverlay,
      x: item.x,
      y: item.y,
      scale: item.scale,
      rotation: item.rotation,
    )).toList());
    if (_undoStack.length > 20) _undoStack.removeAt(0);
    _redoStack.clear();
  }

  void undo() {
    if (_undoStack.isEmpty) return;
    _redoStack.add(List.from(_canvasItems));
    _canvasItems.clear();
    _canvasItems.addAll(_undoStack.removeLast());
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    _undoStack.add(List.from(_canvasItems));
    _canvasItems.clear();
    _canvasItems.addAll(_redoStack.removeLast());
    notifyListeners();
  }

  // === DESIGN GALLERY ===
  void saveCurrentDesign(String name) {
    _savedDesigns.insert(0, CreatedDesign(
      id: 'design_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      canvasBackground: _canvasBackground,
      stickerCount: _canvasItems.length,
      createdAt: DateTime.now(),
      lastModified: DateTime.now(),
    ));
    notifyListeners();
  }

  void toggleDesignFavorite(String id) {
    final index = _savedDesigns.indexWhere((d) => d.id == id);
    if (index != -1) {
      _savedDesigns[index] = _savedDesigns[index].copyWith(
        isFavorite: !_savedDesigns[index].isFavorite,
      );
      notifyListeners();
    }
  }

  void deleteDesign(String id) {
    _savedDesigns.removeWhere((d) => d.id == id);
    notifyListeners();
  }

  // === STICKER PACKS ===
  void downloadPack(String packId) {
    final index = _packs.indexWhere((p) => p.id == packId);
    if (index != -1) {
      _packs[index].isDownloaded = true;
      totalDownloads++;
      notifyListeners();
    }
  }
}
