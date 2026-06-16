// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/session/view/widgets/session_card.dart';

// class PastSessionsPage extends StatelessWidget {
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
import 'package:intl/intl.dart'; // هتحتاجي مكتبة intl لتنسيق التاريخ

class PastSessionsPage extends StatefulWidget {
  @override
  State<PastSessionsPage> createState() => _PastSessionsPageState();
}

class _PastSessionsPageState extends State<PastSessionsPage> {
  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() async {
    // 1. نجيب الـ expertId من الـ PrefHelpers
    String? expertId = await PrefHelpers.getUserId();

    if (expertId != null) {
      // 2. نمرر الـ ID الحقيقي للـ Cubit
      if (mounted) {
        context.read<ExpertServiceCubit>().fetchPastSessions(expertId);
      }
    } else {
      // اختياري: لو مفيش ID ممكن تطلعي رسالة خطأ
      print("Error: Expert ID not found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PastSessionsLoaded) {
          if (state.sessions.isEmpty) {
            return const Center(child: Text("No past sessions found"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.sessions.length,
            itemBuilder: (context, index) {
              final session = state.sessions[index];

              // تنسيق التاريخ من الـ String اللي جاي
              DateTime dateTime = DateTime.parse(session.date);
              String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);

              return SessionCard(
                name: session.beginnerName,
                workshop: session.serviceName,
                date: formattedDate,
                time: "", // الـ API باعت الـ duration فيه الوقت والمدة مع بعض
                duration: session.duration,
                image:
                    "https://i.pravatar.cc/150?u=${session.sessionId}", // صورة عشوائية مؤقتاً
                type: "past",
                rating: 5, // لو الـ API مش باعت ريتنج حالياً
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
