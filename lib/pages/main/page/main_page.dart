import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ionicons/ionicons.dart';
import 'package:product_scanner_app/constants/constants.dart';
import 'package:product_scanner_app/pages/history/page/history_page.dart';
import 'package:product_scanner_app/pages/home/page/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_scanner_app/providers/product_barcode_provider.dart';
import 'package:product_scanner_app/providers/image_provider.dart';
import 'package:product_scanner_app/providers/product_name_provider.dart';
import 'package:product_scanner_app/providers/product_price_provider.dart';
import 'package:product_scanner_app/providers/scan_provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int activeIndex = 0;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  Future<void> _pickImage(ImageSource source) async {
    final selectedImage = await ImagePicker().pickImage(source: source);

    if (selectedImage == null) {
      return;
    }
    ref.read(imageProvider.notifier).resetImage();
    ref.read(productNameProvider.notifier).resetName();
    ref.read(productPriceProvider.notifier).resetPrice();
    ref.read(productBarcodeProvider.notifier).resetBarcode();
    ref.read(imageProvider.notifier).loadImage(File(selectedImage.path));
    ref.read(scanProvider.notifier).isScanning(true);
    ref.read(imageProvider.notifier).processImage();
  }

  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Product Scanner',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: pages[activeIndex],
      bottomNavigationBar: StylishBottomBar(
        currentIndex: activeIndex,
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            selectedColor: mainColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text('History'),
            selectedColor: mainColor,
          ),
        ],
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconSize: 30,
          iconStyle: IconStyle.animated,
          opacity: 0.3,
        ),
        hasNotch: true,
        notchStyle: NotchStyle.circle,
        elevation: 30,
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        icon: Ionicons.scan_sharp,
        activeIcon: Ionicons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        buttonSize: const Size.fromRadius(35),
        childrenButtonSize: const Size.fromRadius(35),
        visible: true,
        direction: SpeedDialDirection.up,
        renderOverlay: true,
        animationDuration: const Duration(milliseconds: 500),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.image_search_outlined),
            backgroundColor: Colors.white,
            foregroundColor: mainColor,
            label: 'Select from gallery',
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          SpeedDialChild(
            child: const Icon(Ionicons.camera_outline),
            backgroundColor: Colors.white,
            foregroundColor: mainColor,
            label: 'Take a picture',
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
