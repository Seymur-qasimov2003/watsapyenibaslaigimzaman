import 'package:flutter/cupertino.dart';

abstract class BaseModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void Busy(bool value) {
    _isBusy = value;
    notifyListeners();
  }
}
