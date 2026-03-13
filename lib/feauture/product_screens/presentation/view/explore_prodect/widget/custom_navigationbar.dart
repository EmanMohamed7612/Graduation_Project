import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';

import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../dashboard_screen/presentation/view/seller_dashboard.dart';
import '../../../../../home/presentation/view/home_screen.dart';
import '../../../../comming_soon_screen.dart';
import '../explore_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

// class _MainWrapperState extends State<MainWrapper> {
//   int _selectedIndex = 0; // ابدأي من الصفر عشان يفتح الهوم أول ما يشتغل

//   // قائمة الصفحات
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const ExploreAllScreen(),
//     const ComingSoonScreen(title: 'Community'),
//     const ComingSoonScreen(title: 'AI'),
//     Profile(),

//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // عرض الصفحة بناءً على الاندكس المختار
//       body: IndexedStack(index: _selectedIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
//           BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
//           BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );
  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(5, (index) {
          return Navigator(
            key: _navigatorKeys[index],
            onGenerateRoute: (settings) {
              return MaterialPageRoute(builder: (_) => _getRootPage(index));
            },
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: _selectedIndex,
        onTap: (index) {
          if (_selectedIndex == index) {
            _navigatorKeys[index].currentState!.popUntil(
              (route) => route.isFirst,
            );
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        // selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: LocaleKeys.naav_home.tr(),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: LocaleKeys.naav_explore.tr(),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: LocaleKeys.naav_community.tr(),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: LocaleKeys.naav_ai.tr(),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: LocaleKeys.naav_profile.tr(),
          ),
        ],
      ),
    );
  }

  Widget _getRootPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ExploreAllScreen();
      case 2:
        return  ComingSoonScreen(title: LocaleKeys.community_title.tr());
      case 3:
        return  ComingSoonScreen(title: LocaleKeys.ai_title.tr());
      case 4:
        return Profile(onGoHome: () => changeTab(0));

      default:
        return const HomeScreen();
    }
  }
}
