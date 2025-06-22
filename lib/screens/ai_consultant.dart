import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../colors.dart';

class AIConsultantScreen extends StatefulWidget {
  @override
  _AIConsultantScreenState createState() => _AIConsultantScreenState();
}

class _AIConsultantScreenState extends State<AIConsultantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });
    final apiKey = dotenv.env['HUGGINGFACE_API_KEY'];
    final response = await http.post(
      Uri.parse("https://api-inference.huggingface.co/models/HuggingFaceH4/zephyr-7b-beta"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "inputs": message,
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final reply = decoded[0]['generated_text']
          .replaceFirst(message, '') // Remove echo
          .trim();

      setState(() {
        _messages.add({'role': 'assistant', 'content': reply});
        _controller.clear();
        _isLoading = false;
      });
    } else {
      print("Error: ${response.body}");
      setState(() {
        _isLoading = false;
      });
    }
    print('Sending prompt: $message');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.main,
        toolbarHeight: 100.0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('assets/logo.png', scale: 1.1,
        ),),
      body: Column(
        children: [
          SizedBox(height: 50,
          width: 350,
          child: Column(
            children: [
              Text('Решете ги сите дилеми поврзани со вашите уреди со помош на нашиот AI консултант!',
                  style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600,color: AppColors.main,),
              textAlign: TextAlign.center,)
            ],
          )),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg['role'] == 'user'
                          ? AppColors.light_orange
                          : AppColors.light_purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['content'] ?? ''),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
    controller: _controller,
    cursorColor: AppColors.main,
    style: const TextStyle(color: AppColors.main),
    decoration: InputDecoration(
    hintText: 'Постави прашање...',
    hintStyle: const TextStyle(color: AppColors.main, fontSize: 15.0, fontFamily: 'montserrat'),
    suffixIcon: IconButton(onPressed: () => _sendMessage(_controller.text),
    icon: const Icon(Icons.send, color: AppColors.main,)),
    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.main)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: AppColors.main))
    ),),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


