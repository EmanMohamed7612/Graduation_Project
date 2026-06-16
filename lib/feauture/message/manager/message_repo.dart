import 'package:graduation2/core/services/api_services.dart';

import '../data/message_model.dart';


class MessagesRepo {
  final ApiService _apiService = ApiService();

  // جلب تاريخ المحادثة مع شخص معين
  Future<List<MessageModel>> getConversation(String otherUserId, {int page = 1}) async {
    final response = await _apiService.get(
      '/api/messages/conversation/$otherUserId',
      {'pageNumber': page, 'pageSize': 20},
    );

    // بناءً على الـ Document الـ data جوه data['data']
    if (response['success'] == true) {
      final List list = response['data']['data'];
      return list.map((e) => MessageModel.fromJson(e)).toList();
    }
    return [];
  }

  // إرسال رسالة
  Future<void> sendMessage(String receiverId, String content) async {
    await _apiService.post('/api/messages/send', {
      'receiverId': receiverId,
      'content': content,
    });
  }

  // ميسود لتصفير العداد (Mark all as read)
  Future<void> markAsRead(String otherUserId) async {
    await _apiService.put('/api/messages/conversation/$otherUserId/read-all', {});
  }
}