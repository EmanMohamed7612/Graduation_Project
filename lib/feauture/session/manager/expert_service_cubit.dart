import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/session/data/add_consultation_model.dart';
import 'package:graduation2/feauture/session/data/expert_repo.dart';
import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';

class ExpertServiceCubit extends Cubit<ExpertServiceState> {
  final ExpertRepo _repo = ExpertRepo();

  // متغيرات داخل الـ Cubit لحفظ آخر بيانات تم تحميلها
  List<ServiceModel> currentServices = [];
  List<TimeSlotModel> currentSlots = [];

  ExpertServiceCubit() : super(ExpertServiceInitial());
  Future<void> addService(ExpertServiceModel service) async {
    emit(ExpertServiceLoading());
    try {
      await _repo.addExpertService(service);
      emit(ExpertServiceSuccess("Service added successfully"));
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> addTimeSlot(TimeSlotModel slot) async {
    emit(ExpertServiceLoading());

    try {
      await _repo.addTimeSlot(slot);
      emit(ExpertServiceSuccess("تمت إضافة الموعد بنجاح"));
    } catch (e) {
      // فحص نوع الخطأ القادم من الـ Repo
      String errorMessage = "حدث خطأ غير متوقع";

      if (e is ApiError) {
        errorMessage = e.message;
      } else if (e is String) {
        errorMessage = e;
      } else {
        errorMessage = e.toString();
      }

      emit(ExpertServiceError(errorMessage));
    }
    // try {
    //   await _repo.addTimeSlot(slot);
    //   emit(ExpertServiceSuccess("Time slot added successfully"));
    // } catch (e) {
    //   emit(ExpertServiceError(e.toString()));
    // }
  }

  Future<void> fetchExpertServices(String expertId) async {
    emit(ExpertServiceLoading());
    try {
      currentServices = await _repo.getExpertServices(expertId);
      // بنبعت الخدمات ومعاها المواعيد (حتى لو فاضية دلوقتي)
      emit(
        ExpertServicesLoaded(services: currentServices, slots: currentSlots),
      );
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> fetchTimeSlots(String expertId) async {
    // بلاش emit(Loading) هنا لو مش عايزة الشاشة كلها تختفي، أو اعملي Loading فرعي
    try {
      currentSlots = await _repo.getExpertAvailableSlots(expertId);
      // بنبعت المواعيد الجديدة مع الحفاظ على الخدمات اللي حملناها قبل كدة
      emit(
        ExpertServicesLoaded(services: currentServices, slots: currentSlots),
      );
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> fetchInitialData(String expertId) async {
    emit(ExpertServiceLoading());
    try {
      currentServices = await _repo.getExpertServices(expertId);
      currentSlots = await _repo.getExpertAvailableSlots(expertId);
      emit(
        ExpertServicesLoaded(services: currentServices, slots: currentSlots),
      );
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> bookConsultation({
    required String expertId,
    required int serviceId,
    required int availabilityId,
  }) async {
    emit(ExpertServiceLoading());
    try {
      final result = await _repo.bookSession(
        expertId: expertId,
        expertServiceId: serviceId,
        expertAvailabilityId: availabilityId,
      );
      emit(ExpertServiceSuccess(result['message'] ?? "Booking Successful!"));
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> fetchSessionRequests(String expertId) async {
    emit(ExpertServiceLoading());
    try {
      final requests = await _repo.getExpertSessionRequests(expertId);
      emit(ExpertSessionRequestsLoaded(requests));
    } catch (e) {
      emit(ExpertServiceError(e.toString()));
    }
  }

  Future<void> updateLink({
    required int sessionId,
    required String link,
    required String expertId,
  }) async {
    emit(ExpertServiceLoading());
    try {
      final result = await _repo.updateMeetingLink(sessionId, link);

      // استخراج الرسالة من رد السيرفر
      String successMsg =
          result['message'] ?? "Meeting link updated successfully";

      emit(ExpertServiceSuccess(successMsg));

      // تحديث القائمة بعد النجاح
      await fetchSessionRequests(expertId);
    } catch (e) {
      // التقاط رسالة الخطأ من ApiError أو أي خطأ آخر
      String errorMessage = "حدث خطأ أثناء التحديث";
      if (e is ApiError) {
        errorMessage = e.message;
      } else {
        errorMessage = e.toString();
      }
      emit(ExpertServiceError(errorMessage));
    }
  }


  Future<void> fetchUpcomingSessions() async {
  emit(ExpertServiceLoading());
  try {
    final sessions = await _repo.getUpcomingSessions();
    emit(UpcomingSessionsLoaded(sessions));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}

Future<void> fetchPastSessions(String expertId) async {
  emit(ExpertServiceLoading());
  try {
    final sessions = await _repo.getPastSessions(expertId);
    emit(PastSessionsLoaded(sessions));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}

Future<void> fetchBeginnerUpcomingSessions() async {
  emit(ExpertServiceLoading());
  try {
    final sessions = await _repo.getBeginnerUpcomingSessions();
    emit(BeginnerUpcomingSessionsLoaded(sessions));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}
Future<void> fetchBeginnerPastSessions(String customerId) async {
  emit(ExpertServiceLoading());
  try {
    final sessions = await _repo.getBeginnerPastSessions(customerId);
    emit(BeginnerPastSessionsLoaded(sessions)); // الـ State الجديدة
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}
Future<void> fetchSessionsCount() async {
  try {
    final count = await _repo.getExpertSessionsCount();
    emit(ExpertSessionsCountLoaded(count));
  } catch (e) {
    // اختياري: ممكن تبعتي Error state لو حابة
    print(e.toString());
  }
}
}
