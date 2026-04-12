// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
//  // تأكدي من استيراد الكارت

// class UpcomingConsultationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // هنا مستقبلاً ستستخدمي FutureBuilder لجلب البيانات من الـ API
//     return ListView(
//       padding: const EdgeInsets.all(20),
//       children: const [
//         SessionCard(
//           name: "Sarah Johnson",
//           date: "Jan 18, 2026",
//           time: "2:00 PM",
//           duration: "60 min",
//           image: "https://i.pravatar.cc/150?u=a",
//           type: "upcoming",
//         ),
//         SessionCard(
//           name: "Michael Brown",
//           date: "Jan 20, 2026",
//           time: "4:30 PM",
//           duration: "45 min",
//           image: "https://i.pravatar.cc/150?u=b",
//           type: "upcoming",
//         ),
//       ],
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
import 'package:graduation2/generated/locale_keys.g.dart';
import 'package:intl/intl.dart';

class UpcomingConsultationPage extends StatefulWidget {
  @override
  State<UpcomingConsultationPage> createState() =>
      _UpcomingConsultationPageState();
}

class _UpcomingConsultationPageState extends State<UpcomingConsultationPage> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند فتح الصفحة
    context.read<ExpertServiceCubit>().fetchBeginnerUpcomingSessions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xff6D4C41)),
          );
        } else if (state is BeginnerUpcomingSessionsLoaded) {
          if (state.sessions.isEmpty) {
            return  Center(child: Text(LocaleKeys.noupcomingsessionsfound.tr()));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];

              // معالجة حالة الزر بناءً على joinStatus
              bool isActive = session.joinStatus == "JOIN_NOW";
              bool isExpired = session.joinStatus == "ENDED";

              return SessionCard(
                name: session.expertName,
                workshop: session.serviceName,
                date: DateFormat('MMM dd, yyyy').format(session.date),
                time: "${session.startTime} - ${session.endTime}",
                image:
                    "https://i.pravatar.cc/150?u=${session.expertId}", // صورة افتراضية
                type: "upcoming",
                meetingLink: session.meetingLink,
                isTimeActive: isActive,
                isExpired: isExpired,
              );
            },
          );
        } else if (state is ExpertServiceError) {
          return Center(child: Text(state.error));
        }
        return const SizedBox();
      },
    );
  }
}
