import 'package:flutter/material.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
 // تأكدي من استيراد الكارت

class UpcomingSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // هنا مستقبلاً ستستخدمي FutureBuilder لجلب البيانات من الـ API
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SessionCard(
          name: "Sarah Johnson",
          date: "Jan 18, 2026",
          time: "2:00 PM",
          duration: "60 min",
          image: "https://i.pravatar.cc/150?u=a",
          type: "upcoming",
        ),
        SessionCard(
          name: "Michael Brown",
          date: "Jan 20, 2026",
          time: "4:30 PM",
          duration: "45 min",
          image: "https://i.pravatar.cc/150?u=b",
          type: "upcoming",
        ),
      ],
    );
  }
}