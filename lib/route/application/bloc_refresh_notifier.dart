import 'dart:async';

import 'package:flutter/material.dart';

class BlocRefreshNotifier extends ChangeNotifier {
  late StreamSubscription _subscription;

  BlocRefreshNotifier(Stream stream) {
    print('BlocRefreshNotifier :: Stream has been initialized');
    _subscription = stream.listen(
      (_) {
        print('BlocRefreshNotifier :: Stream has been updated');
        notifyListeners();
      },
      onError: (error) {
        print('BlocRefreshNotifier :: Stream encountered an error: $error');
      },
      onDone: () {
        print('BlocRefreshNotifier :: Stream is done');
      },
    );
    cancelSubscription();
  }

  void cancelSubscription() {
    _subscription.cancel();
    print('BlocRefreshNotifier :: Subscription has been cancelled');
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
