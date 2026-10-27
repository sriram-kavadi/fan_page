/// Sticker template model
class StickerTemplate {
  final String id;
  final String name;
  final String category;
  final String emoji;
  final List<int> colors; // gradient color pair as int values
  final String shape; // 'circle', 'star', 'hexagon', 'shield', 'diamond', 'heart'
  final String borderStyle; // 'glow', 'solid', 'dashed', 'none'
  final int borderColor;
  final String textOverlay;
  final bool isFavorite;
  final bool isPremium;
  int downloadCount;

  StickerTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.emoji,
    required this.colors,
    required this.shape,
    this.borderStyle = 'glow',
    this.borderColor = 0xFF0A84FF,
    this.textOverlay = '',
    this.isFavorite = false,
    this.isPremium = false,
    this.downloadCount = 0,
  });

  StickerTemplate copyWith({
    bool? isFavorite,
    int? downloadCount,
  }) {
    return StickerTemplate(
      id: id,
      name: name,
      category: category,
      emoji: emoji,
      colors: colors,
      shape: shape,
      borderStyle: borderStyle,
      borderColor: borderColor,
      textOverlay: textOverlay,
      isFavorite: isFavorite ?? this.isFavorite,
      isPremium: isPremium,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }
}

/// Canvas sticker item (placed on canvas)
class CanvasStickerItem {
  final String id;
  final String templateId;
  final String emoji;
  final List<int> colors;
  final String shape;
  final String textOverlay;
  double x;
  double y;
  double scale;
  double rotation;
  bool isSelected;

  CanvasStickerItem({
    required this.id,
    required this.templateId,
    required this.emoji,
    required this.colors,
    required this.shape,
    this.textOverlay = '',
    this.x = 0,
    this.y = 0,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.isSelected = false,
  });
}

/// Created design (finished work saved to gallery)
class CreatedDesign {
  final String id;
  final String name;
  final String canvasBackground;
  final int stickerCount;
  final DateTime createdAt;
  final DateTime lastModified;
  bool isFavorite;

  CreatedDesign({
    required this.id,
    required this.name,
    required this.canvasBackground,
    required this.stickerCount,
    required this.createdAt,
    required this.lastModified,
    this.isFavorite = false,
  });

  CreatedDesign copyWith({bool? isFavorite}) {
    return CreatedDesign(
      id: id,
      name: name,
      canvasBackground: canvasBackground,
      stickerCount: stickerCount,
      createdAt: createdAt,
      lastModified: lastModified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// Sticker pack (downloadable collection)
class StickerPack {
  final String id;
  final String name;
  final String description;
  final String previewEmoji;
  final List<int> gradientColors;
  final int stickerCount;
  final String category;
  bool isDownloaded;

  StickerPack({
    required this.id,
    required this.name,
    required this.description,
    required this.previewEmoji,
    required this.gradientColors,
    required this.stickerCount,
    required this.category,
    this.isDownloaded = false,
  });
}
