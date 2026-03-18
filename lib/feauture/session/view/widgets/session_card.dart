import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String? duration;
  final String image;
  final String type; // upcoming, past, request
  final String? workshop;
  final String? review;
  final String? note;
  final int? rating;

  const SessionCard({
    required this.name,
    required this.date,
    required this.time,
    required this.image,
    required this.type,
    this.duration,
    this.workshop,
    this.review,
    this.note,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 25, backgroundImage: NetworkImage(image)),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (workshop != null)
                      Text(
                        workshop!,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    if (rating != null)
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            size: 14,
                            color: i < rating!
                                ? Colors.amber
                                : Colors.grey[300],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (type == "upcoming")
                Icon(Icons.check_circle, color: Color(0xffCAA971), size: 25),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFDF5ED),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Color(0xffC9A875),
                    ),
                    SizedBox(width: 8),
                    Text(date, style: TextStyle(fontSize: 13)),
                  ],
                ),
                SizedBox(height: 10),
                //  Spacer(),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Color(0xffC9A875)),
                    SizedBox(width: 8),
                    Text(
                      duration != null ? "$time • $duration" : time,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (review != null || note != null) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                review ?? note!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          SizedBox(height: 15),
          if (type !=
              "past") // صفحة الـ Past غالباً لا تحتوي على أزرار تفاعل مباشرة في الصورة
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  type == "upcoming" ? Icons.videocam_outlined : Icons.link,
                  color: Colors.white,
                  size: 18,
                ),
                label: Text(
                  type == "upcoming" ? "Join Session" : "Add Meeting Link",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7B5B4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
