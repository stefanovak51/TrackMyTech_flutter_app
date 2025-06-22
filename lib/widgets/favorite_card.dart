import 'package:flutter/material.dart';

import '../colors.dart';

class FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> device;
  final VoidCallback onTap;

  const FavoriteCard({super.key, required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFFF7F5FF),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (device['image'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    device['image'],
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      device['deviceName'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Icon(Icons.arrow_downward, color: AppColors.main),
                    Text(
                      device['process'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time, size: 16, color: AppColors.main,),
                        const SizedBox(width: 4),
                        Text(
                          device['date'] ?? '20.06.2025',
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.location_on, size: 16, color:AppColors.main),
                        const SizedBox(width: 4),
                        Text(
                          device['place'] ?? 'Сетек',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
