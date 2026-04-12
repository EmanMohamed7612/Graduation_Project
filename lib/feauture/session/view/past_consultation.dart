// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/session/view/widgets/session_card.dart';

// class PastConsultation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(20),
//       children: const [
//         SessionCard(
//           name: "David Wilson",
//           date: "Oct 5, 2025",
//           time: "3:00 PM",
//           duration: "60 min",
//           image: "https://i.pravatar.cc/150?u=c",
//           type: "past",
//           rating: 5,
//           review: "Amazing session! Learned so much about pottery techniques.",
//         ),
//       ],
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class PastConsultation extends StatefulWidget {
  @override
  State<PastConsultation> createState() => _PastConsultationState();
}

class _PastConsultationState extends State<PastConsultation> {
  @override
  void initState() {
    super.initState();

    // هنا نطلب البيانات. ملاحظة: يجب توفير customerId الحقيقي (من الـ User Preferences أو Auth)
    // سأفترض وجود customerId ثابت للتجربة أو استبدله بمتغير المستخدم الحالي
    _loadSessions();
  }

  void _loadSessions() async {
    // 1. نجيب الـ expertId من الـ PrefHelpers
    String? userId = await PrefHelpers.getUserId();

    if (userId != null) {
      // 2. نمرر الـ ID الحقيقي للـ Cubit
      if (mounted) {
        context.read<ExpertServiceCubit>().fetchBeginnerPastSessions(userId);
      }
    } else {
      // اختياري: لو مفيش ID ممكن تطلعي رسالة خطأ
      print("Error: User ID not found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6D4C41)),
          );
        } else if (state is BeginnerPastSessionsLoaded) {
          if (state.sessions.isEmpty) {
            return  Center(child: Text(LocaleKeys.nopastsessionsfound.tr()));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];
              return SessionCard(
                name: session.expertName,
                // تنسيق التاريخ ليظهر بشكل جميل
                date:
                    "${session.date.day}/${session.date.month}/${session.date.year}",
                time: session.timeAndDuration,
                image:session.expertImageUrl.isNotEmpty ? session.expertImageUrl : "assests/images/person.png",
                type: "past",
                workshop: session.serviceName,
                note:
                    "Amount Paid: ${session.amountPaid}", // مثال لاستخدام حقل السعر
              );
            },
          );
        } else if (state is ExpertServiceError) {
          return Center(child: Text(state.error));
        }
        return  Center(child: Text(LocaleKeys.startloadingsessions.tr()));
      },
    );
  }
}
