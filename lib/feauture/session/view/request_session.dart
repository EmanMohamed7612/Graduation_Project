// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/session/view/widgets/session_card.dart';

// class RequestsSessionsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(20),
//       children: const [
//         SessionCard(
//           name: "Sarah Martinez",
//           workshop: "Pottery Basics Workshop",
//           date: "Jan 15, 2026",
//           time: "2:00 PM",
//           image: "https://i.pravatar.cc/150?u=d",
//           type: "request",
//           note:
//               "I'm interested in learning pottery wheel basics. Can we schedule a 2-hour session?",
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/widgets/add_link_dialog.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
// عشان نجيب الـ expertId

class RequestsSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // يفضل استدعاء البيانات عند بناء الصفحة
    return FutureBuilder(
      future: PrefHelpers.getUserId(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          context.read<ExpertServiceCubit>().fetchSessionRequests(
            snapshot.data!,
          );
        }
        return BlocListener<ExpertServiceCubit, ExpertServiceState>(
          listener: (context, state) {
            if (state is ExpertServiceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ExpertServiceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
            builder: (context, state) {
              if (state is ExpertServiceLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExpertSessionRequestsLoaded) {
                if (state.requests.isEmpty) {
                  return const Center(child: Text("No requests found"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    final request = state.requests[index];
                    return SessionCard(
                      name: request.beginnerName,
                      workshop: request.serviceName,
                      date: request.date.split('T')[0], // عرض التاريخ فقط
                      time: "${request.startTime} - ${request.endTime}",
                      image: request.beginnerImage.isNotEmpty
                          ? request.beginnerImage
                          :"assests/images/person.png",
                          // : "https://via.placeholder.com/150",
                      type: "request",

                      // note: "Request ID: ${request.sessionId}", // لو حابة تعرضي رقم الجلسة
                      onAddLinkTap: () {
                        showDialog(
                          context: context,
                          builder: (innerContext) => BlocProvider.value(
                            value: context
                                .read<
                                  ExpertServiceCubit
                                >(), // مهم عشان الـ Dialog يشوف الـ Cubit
                            child: AddLinkDialog(
                              sessionId: request.sessionId,
                              expertId: snapshot.data!, // الـ ID بتاع الخبير
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is ExpertServiceError) {
                return Center(child: Text(state.error));
              }
              return const Center(child: Text("Start loading..."));
            },
          ),
        );
      },
    );
  }
}
