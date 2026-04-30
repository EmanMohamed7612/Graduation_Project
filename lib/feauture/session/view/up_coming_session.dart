import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class UpcomingSessionsPage extends StatefulWidget {
  @override
  State<UpcomingSessionsPage> createState() => _UpcomingSessionsPageState();
}

class _UpcomingSessionsPageState extends State<UpcomingSessionsPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء البيانات مرة واحدة فقط عند إنشاء الصفحة
    context.read<ExpertServiceCubit>().fetchUpcomingSessions();
  }

  @override
  Widget build(BuildContext context) {
    // نطلب البيانات أول ما الصفحة تفتح

    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ExpertServiceError)
         { return Center(child: Text(state.error));}

        if (state is UpcomingSessionsLoaded) {
          if (state.sessions.isEmpty)
           { return Center(child: Text(LocaleKeys.noupcomingsessions.tr()));}

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];
              int status = _getSessionStatus(
                session.date,
                session.startTime,
                session.endTime, // مرري الـ endTime من الموديل
              );

              // فحص هل وقت السيشن بدأ؟
              // bool isTimeToShow = _checkIfSessionStarted(
              //   session.date,
              //   session.startTime,
              // );

              return SessionCard(
                name: session.beginnerName,
                workshop: session.serviceName,
                date: session.date.split('T')[0], // عرض التاريخ فقط
                time: session.startTime,
                image: session.beginnerName.isNotEmpty
                    ? session.beginnerName
                    : "assests/images/person.png",
                    //"https://via.placeholder.com/150",
                type: "upcoming",
                // نمرر حالة الوقت للكارت
                //  isTimeActive: isTimeToShow,
                isTimeActive: status == 1,
                isExpired: status == 2,
                meetingLink: session.meetingLink,
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  // دالة الفحص الجديدة
  int _getSessionStatus(
    String dateStr,
    String startTimeStr,
    String endTimeStr,
  ) {
    DateTime sessionDate = DateTime.parse(dateStr);

    // تحويل وقت البداية والنهاية لـ DateTime
    List<String> startParts = startTimeStr.split(':');
    List<String> endParts = endTimeStr.split(':');

    DateTime sessionStart = DateTime(
      sessionDate.year,
      sessionDate.month,
      sessionDate.day,
      int.parse(startParts[0]),
      int.parse(startParts[1]),
    );

    DateTime sessionEnd = DateTime(
      sessionDate.year,
      sessionDate.month,
      sessionDate.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    DateTime now = DateTime.now();

    if (now.isAfter(sessionEnd)) {
      return 2; // الموعد انتهى
    } else if (now.isAfter(
      sessionStart.subtract(const Duration(minutes: 10)),
    )) {
      return 1; // متاح حالياً (بدأ أو سيبدأ خلال 10 دقائق)
    } else {
      return 0; // لم يحن الموعد بعد
    }
  }

  // bool _checkIfSessionStarted(String dateStr, String startTimeStr) {
  //   DateTime sessionDate = DateTime.parse(dateStr);
  //   List<String> timeParts = startTimeStr.split(':');
  //   DateTime sessionStart = DateTime(
  //     sessionDate.year,
  //     sessionDate.month,
  //     sessionDate.day,
  //     int.parse(timeParts[0]),
  //     int.parse(timeParts[1]),
  //   );
  //   // السماح قبل الموعد بـ 10 دقائق مثلاً
  //   return DateTime.now().isAfter(sessionStart.subtract(Duration(minutes: 10)));
  // }
}
