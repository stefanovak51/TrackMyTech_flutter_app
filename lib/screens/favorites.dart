import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackmytech/colors.dart';
import 'package:trackmytech/favorites_saver.dart';
import 'package:trackmytech/screens/qr_code.dart';
import '../widgets/favorite_card.dart';
import 'device_info.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int selectedIndex = 1; // Start on favorites tab

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteSaver.getFavorites();

    Widget currentScreen;
    if (selectedIndex == 0) {
      currentScreen = const QRScanScreen(); // Replace with your QR screen widget
    } else {
      currentScreen = Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.main,
          toolbarHeight: 100.0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset('assets/logo.png', scale: 1.1),
        ),
        body: favorites.isEmpty
            ? const Center(child: Text('Немате омилени уреди'))
            : ListView.builder(
          itemCount: favorites.length,
            itemBuilder: (context, index) {
              final device = favorites[index]; // ✅ define device here
              return FavoriteCard(
                device: device,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgressScreen(
                        qrData: json.encode(device),
                      ),
                    ),
                  );
                },
              );
            }
        ),
      );
    }
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Container(
        color: AppColors.main,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // QR Tab
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppColors.light_purple
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            // Favorites Tab
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppColors.light_purple
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  selectedIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
