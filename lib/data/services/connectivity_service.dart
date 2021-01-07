import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectionProvider extends ChangeNotifier {
  bool neTisOn = true;

  StreamController<ConnectivityResult> netWorkStatus =
  StreamController<ConnectivityResult>();

  ConnectionProvider() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      netWorkStatus.add(result);

      setNetWork(result);
    });

    notifyListeners();
  }

  setNetWork(ConnectivityResult value) {
    if (value == ConnectivityResult.none) {
      neTisOn = false;
    } else {
      neTisOn = true;
    }
    notifyListeners();
  }
}