import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:product_scanner_app/constants/constants.dart';
import 'package:product_scanner_app/providers/product_barcode_provider.dart';
import 'package:product_scanner_app/providers/product_name_provider.dart';
import 'package:product_scanner_app/providers/product_price_provider.dart';

class ImageNotifier extends StateNotifier<File?> {
  final Ref ref;

  ImageNotifier(this.ref) : super(null);

  void loadImage(File image) {
    state = image;
  }

  void resetImage() {
    state = null;
  }

  Future<void> processImage() async {
    final image = state;
    if (image == null) {
      return;
    }
    final imageInput = InputImage.fromFilePath(image.path);
    List<Barcode> barcodes = [];
    String barcodeValue = '';

    final List<BarcodeFormat> formats = [BarcodeFormat.all];
    final BarcodeScanner barcodeScanner = BarcodeScanner(formats: formats);

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RegExp nameRegex = RegExp(r'^(?=.*[A-ZÜÇÖŞİĞ])[A-Z0-9ÜÇÖŞİĞ\s]+$');

    RegExp priceRegex = RegExp(
        r'^(t\s?|\$\s?|\₺\s?|\€\s?)?\d{1,3}(,\d{3})*[.,]\d{2}(\s?\$|\s?\₺|\s?\€|\s?t)?$');

    RegExp barcodeRegex = RegExp(r'^(\d{13})$');

    try {
      StringBuffer combinedText = StringBuffer();
      final recognizedText = await textRecognizer.processImage(imageInput);

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          combinedText.write("${line.text} ");
        }
        String combinedString = combinedText.toString().trim();
        if (nameRegex.hasMatch(combinedString)) {
          if (!nonAcceptableKeywords
              .any((element) => combinedString.contains(element))) {
            ref.read(productNameProvider.notifier).loadName(combinedString);
          }
        }
        combinedText.clear();
      }

      barcodes = await barcodeScanner.processImage(imageInput);

      if (barcodes.isEmpty) {
        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            if (barcodeRegex.hasMatch(line.text)) {
              barcodeValue = line.text;
            }
          }
        }
        if (barcodeValue.isEmpty) {
          ref.read(productBarcodeProvider.notifier).loadBarcode('');
        } else {
          ref.read(productBarcodeProvider.notifier).loadBarcode(barcodeValue);
        }
      } else {
        ref
            .read(productBarcodeProvider.notifier)
            .loadBarcode(barcodes[0].displayValue!);
      }
      barcodeScanner.close();

      List<TextLine> regexMatchedLines = [];

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          if (priceRegex.hasMatch(line.text)) {
            regexMatchedLines.add(line);
          }
        }
      }

      if (regexMatchedLines.isNotEmpty) {
        double maxFontSize = regexMatchedLines[0].boundingBox.height;
        TextLine priceLine = regexMatchedLines[0];
        for (TextLine line in regexMatchedLines) {
          if (line.boundingBox.height > maxFontSize) {
            maxFontSize = line.boundingBox.height;
            priceLine = line;
          }
        }
        if (priceLine.text.contains('t')) {
          ref
              .read(productPriceProvider.notifier)
              .loadPrice(priceLine.text.replaceAll('t', '₺'));
        } else {
          ref.read(productPriceProvider.notifier).loadPrice(priceLine.text);
        }
      } else {
        ref.read(productPriceProvider.notifier).loadPrice('No price found');
      }
    } catch (e) {
      print('Error OTR $e');
    }
  }
}

final imageProvider = StateNotifierProvider<ImageNotifier, File?>(
  (ref) => ImageNotifier(ref),
);
