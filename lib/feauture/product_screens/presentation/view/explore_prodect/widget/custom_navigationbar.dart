// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

// import '../../../../../../generated/locale_keys.g.dart';
// import '../../../../../dashboard_screen/presentation/view/seller_dashboard.dart';
// import '../../../../../home/presentation/view/home_screen.dart';
// import '../../../../comming_soon_screen.dart';
// import '../explore_screen.dart';

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// // class _MainWrapperState extends State<MainWrapper> {
// //   int _selectedIndex = 0; // ابدأي من الصفر عشان يفتح الهوم أول ما يشتغل

// //   // قائمة الصفحات
// //   final List<Widget> _pages = [
// //     const HomeScreen(),
// //     const ExploreAllScreen(),
// //     const ComingSoonScreen(title: 'Community'),
// //     const ComingSoonScreen(title: 'AI'),
// //     Profile(),

// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // عرض الصفحة بناءً على الاندكس المختار
// //       body: IndexedStack(index: _selectedIndex, children: _pages),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         onTap: (index) {
// //           setState(() {
// //             _selectedIndex = index;
// //           });
// //         },
// //         type: BottomNavigationBarType.fixed,
// //         selectedItemColor: Colors.brown,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //           BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
// //           BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
// //           BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class _MainWrapperState extends State<MainWrapper> {
//   int _selectedIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
//     5,
//     (_) => GlobalKey<NavigatorState>(),
//   );
//   void changeTab(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: List.generate(5, (index) {
//           return Navigator(
//             key: _navigatorKeys[index],
//             onGenerateRoute: (settings) {
//               return MaterialPageRoute(builder: (_) => _getRootPage(index));
//             },
//           );
//         }),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,

//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           if (_selectedIndex == index) {
//             _navigatorKeys[index].currentState!.popUntil(
//               (route) => route.isFirst,
//             );
//           } else {
//             setState(() => _selectedIndex = index);
//           }
//         },
//         // selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.home_outlined),
//             label: LocaleKeys.naav_home.tr(),
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.explore_outlined),
//             label: LocaleKeys.naav_explore.tr(),
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.groups_outlined),
//             label: LocaleKeys.naav_community.tr(),
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.auto_awesome_outlined),
//             label: LocaleKeys.naav_ai.tr(),
//           ),
//            BottomNavigationBarItem(
//             icon: Icon(Icons.person_2_outlined),
//             label: LocaleKeys.naav_profile.tr(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getRootPage(int index) {
//     switch (index) {
//       case 0:
//         return const HomeScreen();
//       case 1:
//         return const ExploreAllScreen();
//       case 2:
//         return  ComingSoonScreen(title: LocaleKeys.community_title.tr());
//       case 3:
//         return  ComingSoonScreen(title: LocaleKeys.ai_title.tr());
//       case 4:
//         return Profile(onGoHome: () => changeTab(0));

//       default:
//         return const HomeScreen();
//     }
//   }
// }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

// import '../../../../../dashboard_screen/presentation/view/seller_dashboard.dart';
// import '../../../../../home/presentation/view/home_screen.dart';
// import '../../../../comming_soon_screen.dart';
// import '../explore_screen.dart';

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// // class _MainWrapperState extends State<MainWrapper> {
// //   int _selectedIndex = 0; // ابدأي من الصفر عشان يفتح الهوم أول ما يشتغل

// //   // قائمة الصفحات
// //   final List<Widget> _pages = [
// //     const HomeScreen(),
// //     const ExploreAllScreen(),
// //     const ComingSoonScreen(title: 'Community'),
// //     const ComingSoonScreen(title: 'AI'),
// //     Profile(),

// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // عرض الصفحة بناءً على الاندكس المختار
// //       body: IndexedStack(index: _selectedIndex, children: _pages),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         onTap: (index) {
// //           setState(() {
// //             _selectedIndex = index;
// //           });
// //         },
// //         type: BottomNavigationBarType.fixed,
// //         selectedItemColor: Colors.brown,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //           BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
// //           BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
// //           BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class _MainWrapperState extends State<MainWrapper> {
//   int _selectedIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
//     5,
//     (_) => GlobalKey<NavigatorState>(),
//   );
//   void changeTab(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: List.generate(5, (index) {
//           return Navigator(
//             key: _navigatorKeys[index],
//             onGenerateRoute: (settings) {
//               return MaterialPageRoute(builder: (_) => _getRootPage(index));
//             },
//           );
//         }),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,

//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           if (_selectedIndex == index) {
//             _navigatorKeys[index].currentState!.popUntil(
//               (route) => route.isFirst,
//             );
//           } else {
//             setState(() => _selectedIndex = index);
//           }
//         },
//         // selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore_outlined),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.groups_outlined),
//             label: 'Community',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.auto_awesome_outlined),
//             label: 'AI',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_2_outlined),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getRootPage(int index) {
//     switch (index) {
//       case 0:
//         return const HomeScreen();
//       case 1:
//         return const ExploreAllScreen();
//       case 2:
//         return const ComingSoonScreen(title: 'Community');
//       case 3:
//         return const ComingSoonScreen(title: 'AI');
//       case 4:
//         return Profile(onGoHome: () => changeTab(0));

//       default:
//         return const HomeScreen();
//     }
//   }
// }

//   update
// import 'package:flutter/material.dart';
// import 'package:graduation2/feauture/home/presentation/view/home_screen.dart';
// import 'package:graduation2/feauture/product_screens/comming_soon_screen.dart';
// import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/explore_screen.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   int _selectedIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
//     5,
//     (_) => GlobalKey<NavigatorState>(),
//   );
//   void changeTab(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<bool> _onWillPop() async {
//     final NavigatorState currentNavigator =
//         _navigatorKeys[_selectedIndex].currentState!;

//     if (currentNavigator.canPop()) {
//       currentNavigator.pop();
//       return false;
//     }

//     if (_selectedIndex != 0) {
//       setState(() {
//         _selectedIndex = 0;
//       });
//       return false;
//     }

//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;

//         final NavigatorState currentNavigator =
//             _navigatorKeys[_selectedIndex].currentState!;

//         if (currentNavigator.canPop()) {
//           currentNavigator.pop();
//         } else if (_selectedIndex != 0) {
//           setState(() {
//             _selectedIndex = 0;
//           });
//         }
//       },
//       child: Scaffold(
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: List.generate(5, (index) {
//             return Navigator(
//               key: _navigatorKeys[index],
//               onGenerateRoute: (settings) {
//                 return MaterialPageRoute(builder: (_) => _getRootPage(index));
//               },
//             );
//           }),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _selectedIndex,
//           onTap: (index) {
//             if (_selectedIndex == index) {
//               _navigatorKeys[index].currentState!.popUntil(
//                 (route) => route.isFirst,
//               );
//             } else {
//               setState(() => _selectedIndex = index);
//             }
//           },
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.explore_outlined),
//               label: 'Explore',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.groups_outlined),
//               label: 'Community',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.auto_awesome_outlined),
//               label: 'AI',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_2_outlined),
//               label: 'Profile',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getRootPage(int index) {
//     switch (index) {
//       case 0:
//         return const HomeScreen();
//       case 1:
//         return const ExploreAllScreen();
//       case 2:
//         return const ComingSoonScreen(title: 'Community');
//       case 3:
//         return const ComingSoonScreen(title: 'AI');
//       case 4:
//         return Profile(onGoHome: () => changeTab(0));

//       default:
//         return const HomeScreen();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:graduation2/feauture/chat_bot/views/chat_bot_screen.dart';
import 'package:graduation2/feauture/community/view/community_screen.dart';
import 'package:graduation2/feauture/home/presentation/view/home_screen.dart';
import 'package:graduation2/feauture/product_screens/comming_soon_screen.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/explore_screen.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  Future<bool> _onBackPressed() async {
    final NavigatorState navigator =
        _navigatorKeys[_currentIndex].currentState!;

    if (navigator.canPop()) {
      navigator.pop();
      return false;
    }

    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }

    return true;
  }

  void _selectTab(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  Widget _buildNavigator(int index, Widget page) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (_) {
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        await _onBackPressed();
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildNavigator(0, const HomeScreen()),
            _buildNavigator(1, ExploreAllScreen(onGoHome: () => _selectTab(0))),
            _buildNavigator(2, CommunityScreen(onGoHome: () => _selectTab(0))),
            _buildNavigator(3, ChatBotScreen(onGoHome: () => _selectTab(0))),
            _buildNavigator(4, Profile(onGoHome: () => _selectTab(0))),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _selectTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              label: "Community",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome_outlined),
              label: "AI",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
