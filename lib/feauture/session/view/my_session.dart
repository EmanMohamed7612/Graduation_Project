// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
// import 'package:graduation2/feauture/session/view/past_session.dart';
// import 'package:graduation2/feauture/session/view/request_session.dart';
// import 'package:graduation2/feauture/session/view/up_coming_session.dart';
// import 'package:graduation2/feauture/session/view/widgets/session_card.dart';
// import 'package:graduation2/generated/locale_keys.g.dart';

// class MySessionsScreen extends StatefulWidget {
//   @override
//   _MySessionsScreenState createState() => _MySessionsScreenState();
// }

// class _MySessionsScreenState extends State<MySessionsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create:(context) => ExpertServiceCubit(),
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             //  backgroundColor: kBackgroundGray,
//             body: Column(
//               children: [
//                 // الـ Header مع الـ Gradient والـ Tabs
//                 Container(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).padding.top + 10,
//                     bottom: 20,
//                   ),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color(0xff6D4C41), // البني الغامق
//                         Color(0xff725146),
//                         Color(0xff76564A),
//                         // اللون الرملي/الفاتح
//                         Color(0xff7B5A4F),
//                         Color(0xff7F5F54),
//                         Color(0xff846459),
//                         Color(0xff88695E),
//                         Color(0xff8D6E63),
//                         Color(0xff957666),

//                         Color(0xff9E7E69),
//                         Color(0xffA6866B),
//                         Color(0xffAF8F6E),
//                         Color(0xffB79770),
//                         Color(0xffC09F73),
//                         Color(0xffC9A875),
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.white24,
//                               child: IconButton(
//                                 icon: Icon(
//                                   Icons.arrow_back_ios_new,
//                                   size: 18,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: Center(
//                                 child: Text(
//                                   LocaleKeys.mySessions.tr(),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 17.50,
//                                     fontFamily: 'Arimo',
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 40), // للموازنة مع زر الرجوع
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // الـ TabBar المخصص
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 20),
//                         height: 45,
//                         decoration: BoxDecoration(
//                           //  color: Colors.black.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: TabBar(
//                           controller: _tabController,
//                           indicator: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           indicatorColor:
//                               Colors.transparent, // نخفي المؤشر الافتراضي
//                           dividerColor: Colors.transparent,
//                           labelColor: Colors.black,
//                           unselectedLabelColor: Colors.white,
//                           labelStyle: TextStyle(
//                             color: const Color(0xFF6D4C41),
//                             fontSize: 12.25,
//                             fontFamily: 'Arimo',
//                             fontWeight: FontWeight.w600,
//                             height: 1.43,
//                           ),

//                           indicatorSize: TabBarIndicatorSize.tab,
//                           tabs: const [
//                             Tab(text: "Upcoming"),
//                             Tab(text: "Past"),
//                             Tab(text: "Requests"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // محتوى الصفحات
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       UpcomingSessionsPage(),
//                       PastSessionsPage(),
//                       RequestsSessionsPage(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }

// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/feauture/session/view/past_session.dart';
import 'package:graduation2/feauture/session/view/request_session.dart';
import 'package:graduation2/feauture/session/view/up_coming_session.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class MySessionsScreen extends StatefulWidget {
  @override
  _MySessionsScreenState createState() => _MySessionsScreenState();
}

class _MySessionsScreenState extends State<MySessionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                            LocaleKeys.mySessions.tr(),
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
                    tabs: [
                      Tab(text: LocaleKeys.upcoming.tr()),
                      Tab(text: LocaleKeys.past.tr()),
                      Tab(text: LocaleKeys.requests.tr()),
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
              children: [
                UpcomingSessionsPage(),
                PastSessionsPage(),
                RequestsSessionsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
