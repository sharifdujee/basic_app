import 'package:flutter/material.dart';

class AppState extends ChangeNotifier{
  int selectedCategoryId = 0;

  /// update category id
  void updateCategoryId (int selectedCategoryId){
    this.selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }
}