import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNameNotifier extends StateNotifier<String> {
  ProductNameNotifier() : super('');

  void loadName(String name) async {
    state = name;
  }

  void resetName() {
    state = '';
  }
}

final productNameProvider = StateNotifierProvider<ProductNameNotifier, String>(
  (ref) => ProductNameNotifier(),
);
