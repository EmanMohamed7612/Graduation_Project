import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/chat_bot/views/widgets/chat_bubble.dart';

class ChatBotRepo {
  final ApiService _apiService = ApiService();
  final Dio _dio = Dio(); // نستخدم نسخة dio منفصلة للـ streaming

  Stream<String> askAIStream(String message) async* {
    final token = await PrefHelpers.getToken();

    try {
      final response = await _dio.post(
        'https://craftoriagp.runasp.net/api/ChatBot/ask',
        // التعديل هنا: إرسال Map بدلاً من Raw String
        data: {"message": message},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'text/event-stream',
            'Content-Type': 'application/json',
            'X-Accel-Buffering': 'no',
          },
          responseType: ResponseType.stream,
        ),
      );

      final Stream<List<int>> stream = response.data.stream;

      await for (var chunk in stream) {
        String decoded = utf8.decode(chunk);

        // معالجة الـ SSE
        List<String> lines = decoded.split('\n');
        // for (var line in lines) {
        //   if (line.startsWith('data: ')) {
        //     String content = line.replaceFirst('data: ', '').trim();

        //     // التأكد من استبعاد الرسائل غير الضرورية
        //     if (content != "Connecting..." && content.isNotEmpty) {
        //       yield content;
        //     }
        //   }
        // }

        // داخل chat_bot_repo.dart
        for (var line in lines) {
          if (line.startsWith('data: ')) {
            String content = line.replaceFirst(
              'data: ',
              '',
            ); // شيلي trim() من هنا مؤقتاً

            // التعديل: اتأكدي إن الـ content فيه حروف فعلية مش مجرد سطر جديد أو مسافة
            if (content.trim().isNotEmpty && content != "Connecting...") {
              yield content;
            }
          }
        }
      }
    } catch (e) {
      print("Streaming Error: $e");
      throw Exception("Failed to get AI response");
    }
  }

  Future<ChatMessage?> getWelcomeMessage() async {
    try {
      final response = await _apiService.get('/api/ChatBot/welcome', null);

      // التحقق من النجاح (السيرفر باعت success كـ bool)
      if (response != null && response['success'] == true) {
        dynamic data = response['data'];
        String welcomeText = "";

        // التحقق لو الداتا نص فارغ أو نل
        if (data == null || (data is String && data.trim().isEmpty)) {
          // welcomeText =
          //     "Hello! Welcome to Craftoria. How can I assist you today?";
        } else {
          welcomeText = data.toString();
        }

        return ChatMessage(
          text: welcomeText,
          time: DateFormat.jm().format(
            DateTime.now(),
          ), // استخدمي التنسيق ده أفضل
          isAi: true,
        );
      }
      return null;
    } catch (e) {
      print("Error fetching welcome message: $e");
      return null;
    }
  }

  // داخل ملف ChatBotRepo
  Future<List<ChatMessage>> getChatHistory() async {
    try {
      final response = await _apiService.get('/api/ChatBot/history', null);

      if (response != null && response['success'] == true) {
        List<dynamic> data = response['data'];

        return data.map((item) {
          // تحويل التاريخ لشكل مقروء (مثل 10:30 AM)
          DateTime date = DateTime.parse(item['createdAt']);
          String formattedTime = DateFormat.jm().format(date);

          return ChatMessage(
            text: item['content'] ?? "",
            time: formattedTime,
            isAi: item['role'] == 'assistant', // لو الـ role مساعد يبقى AI
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching chat history: $e");
      return [];
    }
  }
}
