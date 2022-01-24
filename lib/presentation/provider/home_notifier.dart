import 'package:core/core.dart' show ItemEnum;
import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  ItemEnum _selectedItem = ItemEnum.Movie;
  ItemEnum get selectedDrawerItem => _selectedItem;

  void setSelectedDrawerItem(ItemEnum newItem) {
    this._selectedItem = newItem;
    notifyListeners();
  }
}
