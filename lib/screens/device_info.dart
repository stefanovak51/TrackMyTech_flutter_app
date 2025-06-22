import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trackmytech/favorites_saver.dart';
import 'package:trackmytech/screens/favorites.dart';

import '../colors.dart';

class ProgressScreen extends StatefulWidget {
  final String qrData;

  const ProgressScreen({required this.qrData});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Map<String, dynamic> data;
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    try {
      data = json.decode(widget.qrData);
      final deviceName = data['deviceName'] ?? '';
      isFavorite = FavoriteSaver.isFavorite(deviceName);
    } catch (e) {
      data = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Грешка")),
        body: Center(child: Text("QR кодот не е валиден JSON")),
      );
    }

    String deviceName = data['deviceName'] ?? 'Непознат уред';
    String process = data['process'] ?? '';
    int progress = data['progress'] ?? 0;
    List steps = data['steps'] ?? [];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.main,
        toolbarHeight: 100.0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo.png', scale: 1.1,
        ),),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Row(
                children: [
                  if (data['image'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        data['image'],
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      const Text(
                        'Вашиот уред:',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.main),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        deviceName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Процес:',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.main),
                        textAlign: TextAlign.center,
                      ),
                      Text(process, style: const TextStyle(fontSize: 16)),
                    ],),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.main,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesScreen(),
                        ),
                      );
                      setState(() {
                        isFavorite = !isFavorite;
                        if (isFavorite) {
                          FavoriteSaver.add(data);
                        } else {
                          FavoriteSaver.remove(data);
                        }
                      });
                    },
                  ),
                ]),
            SizedBox(height: 30),
            // Progress arc
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress / 100,
                    strokeWidth: 10,
                    color: AppColors.orange,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                Text(
                  "$progress%",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.main),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.circle, color: AppColors.orange,),
                Text('Завршено',
                    style: TextStyle(fontSize: 15, color: AppColors.main)),
                Icon(Icons.circle, color: AppColors.main,),
                Text('Во прогрес',
                    style: TextStyle(fontSize: 15, color: AppColors.main)),
                Icon(Icons.circle, color: Colors.grey,),
                Text('Незапочнато',
                    style: TextStyle(fontSize: 15, color: AppColors.main)),
              ],
            ),
            SizedBox(height: 19,),
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
                  color: AppColors.orange),
              width: 700,
              child: const Column(children: [
                Text("Дополнителни информации:", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.main))
              ]),
            ), // Steps list
            Container(
              color: AppColors.orange,
              height: 300,
              width: 700,
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return ListTile(
                    title: Text(step['label']),
                    trailing: Icon(
                      step['done'] ? Icons.check_circle : Icons
                          .radio_button_unchecked,
                      color: step['done'] ? AppColors.main : Colors.grey,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}

