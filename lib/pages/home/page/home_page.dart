import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_scanner_app/models/product.dart';
import 'package:product_scanner_app/pages/home/widgets/product_item.dart';
import 'package:product_scanner_app/providers/product_barcode_provider.dart';
import 'package:product_scanner_app/providers/product_name_provider.dart';
import 'package:product_scanner_app/providers/product_price_provider.dart';
import 'package:product_scanner_app/providers/scan_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String productBarcode = ref.watch(productBarcodeProvider);
    final String productPrice = ref.watch(productPriceProvider);
    final String productName = ref.watch(productNameProvider);
    final isScanning = ref.watch(scanProvider);

    final product = Product(
      productName,
      productPrice,
      productBarcode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (!isScanning)
                ? Text(
                    'Scan now to start',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                        ),
                  )
                : (productBarcode.isEmpty)
                    ? Text(
                        'No product found',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    : (isScanning)
                        ? ProductItem(product: product)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
          ],
        ),
      ),
    );
  }
}
