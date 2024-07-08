import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPriceNotifier extends StateNotifier<String> {
  ProductPriceNotifier() : super('');

  void loadPrice(String price) {
    state = price;
  }

  void resetPrice() {
    state = '';
  }
}

final productPriceProvider =
    StateNotifierProvider<ProductPriceNotifier, String>(
  (ref) => ProductPriceNotifier(),
);
