import 'package:flutter/material.dart';

class BlocRefreshNotifier extends ChangeNotifier {
  BlocRefreshNotifier(Stream stream) {
    stream.listen((_) {
      notifyListeners();
    });
  }
}
