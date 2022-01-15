import 'package:ditonton/common/item_enum.dart';
import 'package:flutter/foundation.dart';

class HomeNotifier extends ChangeNotifier {
  ItemEnum _selectedItem = ItemEnum.Movie;
  ItemEnum get selectedItem => _selectedItem;

  void setSelectedItem(ItemEnum item) {
    this._selectedItem = item;
    notifyListeners();
  }
}
