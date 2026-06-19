import 'package:graduation2/core/services/api_services.dart';

import '../data/inboxmessage_model.dart';

class InboxRepo {
  final ApiService _apiService = ApiService();

  Future<List<InboxItemModel>> getInbox() async {
    try {
      final response = await _apiService.get('/api/messages/inbox', null);

      // التعامل مع هيكلة الـ Map اللي فيها data
      if (response is Map<String, dynamic> && response['data'] != null) {
        final List list = response['data'];
        return list.map((e) => InboxItemModel.fromJson(e)).toList();
      }
      // احتياطاً لو الـ API رجع القائمة مباشرة
      if (response is List) {
        return response.map((e) => InboxItemModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}