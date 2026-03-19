import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';

abstract class ExpertServiceState {}
class ExpertServiceInitial extends ExpertServiceState {}
class ExpertServiceLoading extends ExpertServiceState {}
class ExpertServiceSuccess extends ExpertServiceState {
  final String message;
  ExpertServiceSuccess(this.message);


}
class ExpertTimeSlotsLoaded extends ExpertServiceState {
  final List<TimeSlotModel> slots;
  ExpertTimeSlotsLoaded(this.slots);
}
class ExpertServiceError extends ExpertServiceState {
  final String error;
  ExpertServiceError(this.error);

}
// class ExpertServicesLoaded extends ExpertServiceState {
//   final List<ServiceModel> services;
//   ExpertServicesLoaded(this.services);
// }

class ExpertServicesLoaded extends ExpertServiceState {
  final List<ServiceModel> services;
  final List<TimeSlotModel> slots;
  ExpertServicesLoaded({this.services = const [], this.slots = const []});
}