import 'dart:async';

import 'package:flutter/material.dart';

class DebounceUtils {
  static Timer? _debounceTimer;

  static void startDebounceTimer(
    VoidCallback callback,
  ) {
    _debounceTimer?.cancel(); // Cancel any previous timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      callback();
    });
  }
}
