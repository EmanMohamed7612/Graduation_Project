import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/feauture/session/view/past_session.dart';
import 'package:graduation2/feauture/session/view/request_session.dart';
import 'package:graduation2/feauture/session/view/up_coming_session.dart';
import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class MyConsultationScreen extends StatefulWidget {
  @override
  _MyConsultationScreenState createState() => _MyConsultationScreenState();
}

class _MyConsultationScreenState extends State<MyConsultationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: kBackgroundGray,
      body: Column(
        children: [
          // الـ Header مع الـ Gradient والـ Tabs
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff6D4C41), // البني الغامق
                  Color(0xff725146),
                  Color(0xff76564A),
                  // اللون الرملي/الفاتح
                  Color(0xff7B5A4F),
                  Color(0xff7F5F54),
                  Color(0xff846459),
                  Color(0xff88695E),
                  Color(0xff8D6E63),
                  Color(0xff957666),

                  Color(0xff9E7E69),
                  Color(0xffA6866B),
                  Color(0xffAF8F6E),
                  Color(0xffB79770),
                  Color(0xffC09F73),
                  Color(0xffC9A875),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            LocaleKeys.my_consultations.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.50,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40), // للموازنة مع زر الرجوع
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // الـ TabBar المخصص
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    //  color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    indicatorColor: Colors.transparent, // نخفي المؤشر الافتراضي
                    dividerColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    labelStyle: TextStyle(
                      color: const Color(0xFF6D4C41),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),

                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: "Upcoming"),
                      Tab(text: "Past"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // محتوى الصفحات
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [UpcomingSessionsPage(), PastSessionsPage()],
            ),
          ),
        ],
      ),
    );
  }

  // // الـ List الخاصة بـ Upcoming
  // Widget _buildUpcomingList() {
  //   return ListView(
  //     padding: EdgeInsets.all(20),
  //     children: [
  //       SessionCard(
  //         name: "Sarah Johnson",
  //         date: "Jan 18, 2026",
  //         time: "2:00 PM",
  //         duration: "60 min",
  //         image: "https://i.pravatar.cc/150?u=a",
  //         type: "upcoming",
  //       ),
  //       SessionCard(
  //         name: "Michael Brown",
  //         date: "Jan 20, 2026",
  //         time: "4:30 PM",
  //         duration: "45 min",
  //         image: "https://i.pravatar.cc/150?u=b",
  //         type: "upcoming",
  //       ),
  //     ],
  //   );
  // }

  // الـ List الخاصة بـ Past
  // Widget _buildPastList() {
  //   return ListView(
  //     padding: EdgeInsets.all(20),
  //     children: [
  //       SessionCard(
  //         name: "David Wilson",
  //         date: "Oct 5, 2025",
  //         time: "3:00 PM",
  //         duration: "60 min",
  //         image: "https://i.pravatar.cc/150?u=c",
  //         type: "past",
  //         rating: 5,
  //         review: "Amazing session! Learned so much about pottery techniques.",
  //       ),
  //     ],
  //   );
  // }

  // // الـ List الخاصة بـ Requests
  // Widget _buildRequestsList() {
  //   return ListView(
  //     padding: EdgeInsets.all(20),
  //     children: [
  //       SessionCard(
  //         name: "Sarah Martinez",
  //         workshop: "Pottery Basics Workshop",
  //         date: "Jan 15, 2026",
  //         time: "2:00 PM",
  //         image: "https://i.pravatar.cc/150?u=d",
  //         type: "request",
  //         note:
  //             "I'm interested in learning pottery wheel basics. Can we schedule a 2-hour session?",
  //       ),
  //     ],
  //   );
  // }
}
