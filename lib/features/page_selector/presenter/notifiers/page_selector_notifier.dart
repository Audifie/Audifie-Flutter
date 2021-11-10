import 'package:flutter/material.dart';

class PageSelectorNotifier extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void changePage(int pageIndex) {
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}