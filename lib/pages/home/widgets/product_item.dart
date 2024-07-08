import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:product_scanner_app/constants/constants.dart';
import 'package:product_scanner_app/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 224, 205, 205),
            Color.fromARGB(255, 238, 234, 234),
            Colors.white,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Name',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              const Icon(
                Ionicons.document_text,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.productName,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Price',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              const Icon(
                Ionicons.pricetag,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.productPrice,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Barcode Value',
                style: Theme.of(context).textTheme.titleLarge!,
              ),
              const Icon(
                Ionicons.barcode,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.barcodeValue,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                textStyle: Theme.of(context).textTheme.headlineSmall!),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
