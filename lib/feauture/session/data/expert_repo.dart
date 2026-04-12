
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/session/data/add_consultation_model.dart';
import 'package:graduation2/feauture/session/data/past_consultation_model.dart';
import 'package:graduation2/feauture/session/data/past_session_model.dart';
import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/session_request_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/data/up_coming_consulatation.dart';
import 'package:graduation2/feauture/session/data/up_coming_session_model.dart';

class ExpertRepo {
  final ApiService _apiService = ApiService();

  Future<void> addExpertService(ExpertServiceModel service) async {
    final response = await _apiService.post(
      '/api/Session/expert/add-service',
      service.toJson(),
    );
    // الـ ApiService عندك بيتعامل مع الأخطاء داخلياً، فلو الكود وصل هنا معناه نجح
    return;
  }

  Future<void> addTimeSlot(TimeSlotModel slot) async {
    try {
      final response = await _apiService.post(
        '/api/Session/expert/add-availability',
        slot.toJson(),
      );
      if (response is Map<String, dynamic> && response['success'] == false) {
        throw response['message'] ?? "هذا الموعد مضاف بالفعل أو حدث خطأ";
      }
    } catch (e) {
      // هنا بنمسك الـ Crash اللي حصل في الـ ApiService ونبعت رسالة مفهومة
      if (e.toString().contains("errorMessage") ||
          e.toString().contains("null")) {
        // دي الرسالة اللي هتظهر لما السيرفر يبعت errors: null
        throw "هذا الموعد مضاف بالفعل من قبل.";
      }
      rethrow; // لو خطأ تاني مرريه للـ Cubit
    }
  }

  Future<List<ServiceModel>> getExpertServices(String expertId) async {
    // ⚠️ التعديل هنا: إضافة null لأن الميثود تطلب parameter ثاني
    final response = await _apiService.get(
      '/api/Session/expert/$expertId/services',
      null,
    );

    // التأكد أن الرد عبارة عن Map ويحتوي على data
    if (response is Map<String, dynamic> && response['data'] != null) {
      List<dynamic> data = response['data'];
      return data.map((e) => ServiceModel.fromJson(e)).toList();
    }

    return []; // إرجاع قائمة فارغة في حالة عدم وجود بيانات
  }

  Future<List<TimeSlotModel>> getExpertAvailableSlots(String expertId) async {
    final response = await _apiService.get(
      '/api/Session/expert/$expertId/slots',
      null,
    );

    if (response is Map<String, dynamic> && response['data'] != null) {
      List<dynamic> data = response['data'];
      return data.map((e) => TimeSlotModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> bookSession({
    required String expertId,
    required int expertServiceId,
    required int expertAvailabilityId,
  }) async {
    final response = await _apiService.post('/api/Session/book', {
      "expertId": expertId,
      "expertServiceId": expertServiceId,
      "expertAvailabilityId": expertAvailabilityId,
    });
    return response; // الـ ApiService بيتعامل مع الأخطاء
  }

  Future<List<SessionRequestModel>> getExpertSessionRequests(
    String expertId,
  ) async {
    final response = await _apiService.get(
      '/api/Session/expert/$expertId/sessions/requests',
      null,
    );

    if (response is Map<String, dynamic> && response['data'] != null) {
      List<dynamic> data = response['data'];
      return data.map((e) => SessionRequestModel.fromJson(e)).toList();
    }
    return [];
  }

//  Future<Map<String, dynamic>> updateMeetingLink(int sessionId, String link) async {
//   final dio = DioClient().dio;

//   final response = await dio.put(
//     '/api/Session/expert/update-meeting-link/$sessionId',
//     data: '"$link"',
//     options: Options(
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ),
//   );
  
//   // بنرجع الـ data اللي هي فيها {success: true, message: "...", ...}
//   return response.data;
// }
Future<Map<String, dynamic>> updateMeetingLink(int sessionId, String link) async {
  final response = await _apiService.put(
    '/api/Session/expert/update-meeting-link/$sessionId',
    '"$link"', // الآن الـ ApiService سيقبل هذا النص بنجاح
  );

  return response as Map<String, dynamic>;
}

Future<List<UpcomingSessionModel>> getUpcomingSessions() async {
  final response = await _apiService.get('/api/Session/expert/upcoming-sessions', null);
  if (response is Map<String, dynamic> && response['data'] != null) {
    List<dynamic> data = response['data'];
    return data.map((e) => UpcomingSessionModel.fromJson(e)).toList();
  }
  return [];
}

Future<List<PastSessionModel>> getPastSessions(String expertId) async {
  final response = await _apiService.get('/api/Session/expert/$expertId/sessions/past', null);
  
  if (response is Map<String, dynamic> && response['data'] != null) {
    List<dynamic> data = response['data'];
    return data.map((e) => PastSessionModel.fromJson(e)).toList();
  }
  return [];
}

Future<List<BeginnerUpcomingSessionModel>> getBeginnerUpcomingSessions() async {
  final response = await _apiService.get('/api/Session/beginner/my-sessions', null);
  
  if (response is Map<String, dynamic> && response['data'] != null) {
    List<dynamic> data = response['data'];
    return data.map((e) => BeginnerUpcomingSessionModel.fromJson(e)).toList();
  }
  return [];
}

Future<List<BeginnerPastSessionModel>> getBeginnerPastSessions(String customerId) async {
  final response = await _apiService.get(
    '/api/Session/customer/$customerId/sessions/past', 
    null
  );
  
  if (response is Map<String, dynamic> && response['data'] != null) {
    List<dynamic> data = response['data'];
    return data.map((e) => BeginnerPastSessionModel.fromJson(e)).toList();
  }
  return [];
}

Future<int> getExpertSessionsCount() async {
  final response = await _apiService.get('/api/Session/expert/sessions/count', null);
  
  if (response is Map<String, dynamic> && response['success'] == true) {
    return response['data']['sessionsCount'] ?? 0;
  }
  return 0;
}
}
