import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanNotifier extends StateNotifier<bool> {
  ScanNotifier() : super(false);

  void isScanning(bool isScanning) {
    state = isScanning;
  }
}

final scanProvider = StateNotifierProvider<ScanNotifier, bool>(
  (ref) => ScanNotifier(),
);
