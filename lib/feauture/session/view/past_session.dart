import 'package:flutter/material.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';


class PastSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SessionCard(
          name: "David Wilson",
          date: "Oct 5, 2025",
          time: "3:00 PM",
          duration: "60 min",
          image: "https://i.pravatar.cc/150?u=c",
          type: "past",
          rating: 5,
          review: "Amazing session! Learned so much about pottery techniques.",
        ),
      ],
    );
  }
}