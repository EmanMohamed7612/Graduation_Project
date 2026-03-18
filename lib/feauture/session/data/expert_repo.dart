import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/session/data/add_consultation_model.dart';
import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';

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
  await _apiService.post(
    '/api/Session/expert/add-availability',
    slot.toJson(),
  );
  return;
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
}