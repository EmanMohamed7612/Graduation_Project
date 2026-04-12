import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final VoidCallback? onAddLinkTap;
  final bool? isTimeActive;
  final String? meetingLink;
  final bool? isExpired;
  const SessionCard({
    required this.name,
    required this.date,
    required this.time,
    required this.image,
    required this.type,
    this.isExpired,
    this.duration,
    this.workshop,
    this.review,
    this.note,
    this.rating,
    this.onAddLinkTap,
    this.isTimeActive,
    this.meetingLink,
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
                onPressed: () async {
                  //   if (type == LocaleKeys.requests.tr()) {
                  //     onAddLinkTap?.call();
                  //   }
                  //   // else if (type == LocaleKeys.upcoming.tr()) {
                  //   //     // التحقق من الوقت قبل فتح اللينك
                  //   //     if (isTimeActive == true) {
                  //   //       if (meetingLink != null &&
                  //   //           await canLaunchUrl(Uri.parse(meetingLink!))) {
                  //   //         //await launchUrl(Uri.parse(meetingLink!));
                  //   //         // داخل ElevatedButton.icon في SessionCard.dart
                  //   //         await launchUrl(
                  //   //           Uri.parse(meetingLink!),
                  //   //           mode: LaunchMode
                  //   //               .externalApplication, // يفتح في تطبيق Meet أو المتصفح مباشرة
                  //   //         );
                  //   //       } else {
                  //   //         ScaffoldMessenger.of(context).showSnackBar(
                  //   //           const SnackBar(
                  //   //             content: Text(
                  //   //               "عذراً، لينك الاجتماع غير متوفر حالياً",
                  //   //             ),
                  //   //           ),
                  //   //         );
                  //   //       }
                  //   //     } else {
                  //   //       // لو لسه الميعاد مجاش
                  //   //       ScaffoldMessenger.of(context).showSnackBar(
                  //   //         const SnackBar(
                  //   //           content: Text(
                  //   //             "لم يحن ميعاد الجلسة بعد، يرجى الانتظار للموعد المحدد",
                  //   //           ),
                  //   //           backgroundColor: Colors.brown,
                  //   //         ),
                  //   //       );
                  //   //     }
                  //   //   }
                  //   // },

                  //   // icon: Icon(
                  //   //   type == "upcoming" ? Icons.videocam_outlined : Icons.link,
                  //   //   color: Colors.white,
                  //   //   size: 18,
                  //   // ),
                  //   // label: Text(
                  //   //   type == "upcoming" ? "Join Session" : "Add Meeting Link",
                  //   //   style: TextStyle(color: Colors.white),
                  //   // ),
                  //   if (isExpired == true) {
                  //     // حالة انتهاء الوقت
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text(
                  //           "عذراً، ميعاد الجلسة انتهى ولا يمكنك الدخول الآن",
                  //         ),
                  //         backgroundColor: Colors.red,
                  //       ),
                  //     );
                  //   } else if (isTimeActive == true) {
                  //     // حالة الموعد متاح (الكود القديم الخاص بفتح اللينك)
                  //     if (meetingLink != null && meetingLink!.isNotEmpty) {
                  //       await launchUrl(
                  //         Uri.parse(meetingLink!),
                  //         mode: LaunchMode.externalApplication,
                  //       );
                  //     } else {
                  //       // SnackBar اللينك غير متوفر
                  //     }
                  //   } else {
                  //     // حالة لم يحن الموعد بعد
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text("لم يحن ميعاد الجلسة بعد")),
                  //     );
                  //   }
                  // },
                  if (type == "request") {
                    onAddLinkTap?.call();
                    return; // توقف هنا ولا تكمل بقية الشروط
                  }

                  // 2. إذا كان النوع "قادم" (Upcoming) -> هنا فقط نفحص الوقت واللينك
                  if (type == "upcoming") {
                    if (isExpired == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            LocaleKeys
                                .sorryyoursessionhasendedandyoucannotenternow
                                .tr(),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (isTimeActive == true) {
                      if (meetingLink != null && meetingLink!.isNotEmpty) {
                        await launchUrl(
                          Uri.parse(meetingLink!),
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              LocaleKeys
                                  .sorrythemeetinglinkiscurrentlyunavailable
                                  .tr(),
                            ),
                          ),
                        );
                      }
                    } else {
                      // حالة لم يحن الموعد بعد
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            LocaleKeys
                                .thesessionhasnotyetbegunpleasewaitforthescheduledtime
                                .tr(),
                          ),
                          backgroundColor: Colors.brown,
                        ),
                      );
                    }
                  }
                },
                // تغيير شكل الزرار لو الموعد انتهى
                label: Text(
                  isExpired == true
                      ? "Session Ended"
                      : (type == "upcoming"
                            ? LocaleKeys.joinsession.tr()
                            : LocaleKeys.addmeetinglink.tr()),
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  type == "upcoming" ? Icons.videocam_outlined : Icons.link,
                  color: Colors.white,
                  size: 18,
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
