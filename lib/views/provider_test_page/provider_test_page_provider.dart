import 'dart:io';

import 'package:app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ProviderTestPageProvider extends ChangeNotifier {
  bool loading = true;
  bool faved = false;
  bool downloaded = false;

  getFeed(String url) async {
    setLoading(true);
    try {
      setLoading(false);
    } catch (e) {
      throw (e);
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setFaved(value) {
    faved = value;
    notifyListeners();
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
