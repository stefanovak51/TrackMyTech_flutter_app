class FavoriteSaver {
  static final List<Map<String, dynamic>> _favorites = [];

  static void add(Map<String, dynamic> device) {
    if (!_favorites.any((d) => d['deviceName'] == device['deviceName'])) {
      _favorites.add(device);
    }
  }

  static void remove(Map<String, dynamic> device) {
    _favorites.removeWhere((d) => d['deviceName'] == device['deviceName']);
  }

  static bool isFavorite(String deviceName) {
    return _favorites.any((d) => d['deviceName'] == deviceName);
  }

  static List<Map<String, dynamic>> getFavorites() {
    return _favorites;
  }
}
