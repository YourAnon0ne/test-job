import 'package:flutter/material.dart';

class TextInputModel extends ChangeNotifier {
  String _displayText = '';
  bool _isTextFieldValid = true;

  String get displayText => _displayText;
  bool get isTextFieldValid => _isTextFieldValid;

  void updateDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  void validateTextField(String text) {
    _isTextFieldValid = text.trim().isNotEmpty;
    notifyListeners();
  }

  void clearTextField() {
    _displayText = '';
    _isTextFieldValid = true;
    notifyListeners();
  }
}
