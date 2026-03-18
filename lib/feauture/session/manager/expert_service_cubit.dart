import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/data/add_consultation_model.dart';
import 'package:graduation2/feauture/session/data/expert_repo.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';

class ExpertServiceCubit extends Cubit<ExpertServiceState> {
  final ExpertRepo _repo = ExpertRepo();
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
    emit(ExpertServiceSuccess("Time slot added successfully"));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}


Future<void> fetchExpertServices(String expertId) async {
  emit(ExpertServiceLoading());
  try {
    final services = await _repo.getExpertServices(expertId);
    emit(ExpertServicesLoaded(services));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}

Future<void> fetchTimeSlots(String expertId) async {
  emit(ExpertServiceLoading());
  try {
    final slots = await _repo.getExpertAvailableSlots(expertId);
    emit(ExpertTimeSlotsLoaded(slots));
  } catch (e) {
    emit(ExpertServiceError(e.toString()));
  }
}
}