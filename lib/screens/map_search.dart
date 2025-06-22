import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:trackmytech/colors.dart';


class MapSearchScreen extends StatefulWidget {
  @override
  _StoreSearchMapState createState() => _StoreSearchMapState();
}

class _StoreSearchMapState extends State<MapSearchScreen> {
  List<Map<String, dynamic>> _results = [];
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController = MapController();

  Future<void> _search(String query) async {
    final results = await searchStores(query);
    setState(() {
      _results = results;
    });

    if (results.isNotEmpty) {
      _mapController.move(LatLng(results[0]['lat'], results[0]['lon']), 15);
    }
  }

  Future<List<Map<String, dynamic>>> searchStores(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json',
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp (example@email.com)',
    });

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((item) => {
        'name': item['display_name'],
        'lat': double.parse(item['lat']),
        'lon': double.parse(item['lon']),
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.main,
        toolbarHeight: 100.0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo.png', scale: 1.1,
        ),),
      body: Column(
            children: [
              Expanded(
                child: FlutterMap(
                  mapController: _mapController,
                  options: const MapOptions(initialCenter: LatLng(41.9981, 21.4254), initialZoom: 13.0),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                MarkerLayer(
                  markers: _results.map((store) {
                    return Marker(
                      point: LatLng(store['lat'], store['lon']),
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: AppColors.main, size: 30),
                    );
                  }).toList(),),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              SizedBox(width: 300,
                height: 50,
                child: TextField(
                  controller: _controller,
                  cursorColor: AppColors.orange,
                  style: const TextStyle(color: AppColors.orange),
                  decoration: InputDecoration(
                      hintText: 'Пронајди сервис или мобилара',
                      hintStyle: const TextStyle(color: AppColors.orange, fontSize: 15.0, fontFamily: 'montserrat'),
                      suffixIcon: IconButton(onPressed: () => _search(_controller.text),
                          icon: const Icon(Icons.search, color: AppColors.orange,)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.orange)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: AppColors.orange))
                  ),),
              )
            ],
          ),)
        ;
  }
}

