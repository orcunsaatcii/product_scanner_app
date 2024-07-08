import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarcodeNotifier extends StateNotifier<String> {
  BarcodeNotifier() : super('');

  void loadBarcode(String barcode) async {
    state = barcode;
  }

  void resetBarcode() {
    state = '';
  }
}

final productBarcodeProvider = StateNotifierProvider<BarcodeNotifier, String>(
  (ref) => BarcodeNotifier(),
);
