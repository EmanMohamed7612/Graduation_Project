import 'package:graduation2/feauture/session/data/past_consultation_model.dart';
import 'package:graduation2/feauture/session/data/past_session_model.dart';
import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/session_request_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/data/up_coming_consulatation.dart';
import 'package:graduation2/feauture/session/data/up_coming_session_model.dart';

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
class ExpertSessionRequestsLoaded extends ExpertServiceState {
  final List<SessionRequestModel> requests;
  ExpertSessionRequestsLoaded(this.requests);
}

class UpcomingSessionsLoaded extends ExpertServiceState {
  final List<UpcomingSessionModel> sessions;
  UpcomingSessionsLoaded(this.sessions);
}

class PastSessionsLoaded extends ExpertServiceState {
  final List<PastSessionModel> sessions;
  PastSessionsLoaded(this.sessions);
}
class BeginnerUpcomingSessionsLoaded extends ExpertServiceState {
  final List<BeginnerUpcomingSessionModel> sessions;
  BeginnerUpcomingSessionsLoaded(this.sessions);
}
// أضيفي دي في ملف الـ states
class BeginnerPastSessionsLoaded extends ExpertServiceState {
  final List<BeginnerPastSessionModel> sessions;
  BeginnerPastSessionsLoaded(this.sessions);
}
class ExpertSessionsCountLoaded extends ExpertServiceState {
  final int count;
  ExpertSessionsCountLoaded(this.count);
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