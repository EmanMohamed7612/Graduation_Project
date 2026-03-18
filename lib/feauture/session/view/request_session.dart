import 'package:flutter/material.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';

class RequestsSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SessionCard(
          name: "Sarah Martinez",
          workshop: "Pottery Basics Workshop",
          date: "Jan 15, 2026",
          time: "2:00 PM",
          image: "https://i.pravatar.cc/150?u=d",
          type: "request",
          note:
              "I'm interested in learning pottery wheel basics. Can we schedule a 2-hour session?",
        ),
      ],
    );
  }
}
