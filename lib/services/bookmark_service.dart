import 'package:flutter/material.dart';
import '../data/chili_data.dart';
import '../models/pest_disease_model.dart';

class BookmarkService extends ChangeNotifier {
  static final BookmarkService _instance = BookmarkService._internal();
  factory BookmarkService() => _instance;
  BookmarkService._internal();

  final Set<String> _bookmarkedIds = {};

  Set<String> get bookmarkedIds => _bookmarkedIds;

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }

  List<PestDiseaseModel> get bookmarkedItems {
    return ChiliData.items
        .where((item) => _bookmarkedIds.contains(item.id))
        .toList();
  }

  int get count => _bookmarkedIds.length;
}

