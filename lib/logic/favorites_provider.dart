import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};

  bool isFavorite(int id) => _favoriteIds.contains(id);

  void toggle(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
