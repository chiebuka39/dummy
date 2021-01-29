import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectionProvider extends ChangeNotifier {
  bool _neTisOn;
  bool get neTisOn => _neTisOn;

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
      _neTisOn = false;
    } else {
      _neTisOn = true;
    }
    notifyListeners();
  }
}