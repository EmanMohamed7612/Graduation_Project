import 'package:flutter/material.dart';
import 'package:graduation2/feauture/language/lnguage_view.dart';
import 'package:graduation2/feauture/settings/view/edit_profile_screen.dart';
import 'package:graduation2/feauture/settings/view/widgets/setting.group.dart';
import 'package:graduation2/feauture/settings/view/widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(
      //   0xFFFBFBFB,
      // ), // خلفية مائلة للبياض لظهور الكروت
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5, // ظل خفيف جداً للأب بار
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xffEFEBE9),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Color(0xff6D4C41),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // تجربة تمرير سلسة
        child: Column(
          children: [
            const SizedBox(height: 8),

            // مجموعة الحساب - Account Section
            SettingsGroup(
              header: "Account",
              items: [
                SettingItem(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LanguageView(), // نفتح شاشة الاختيار اللي عندك
                      ),
                    );
                  },
                ),
                SettingItem(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                  },
                ),
                SettingItem(
                  icon: Icons.lock_outline,
                  title: "Privacy & Security",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // مجموعة الدعم - Support Section
            SettingsGroup(
              header: "Support",
              items: [
                SettingItem(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  onTap: () {},
                ),
                SettingItem(
                  icon: Icons.logout,
                  title: "Logout",
                  textColor: Colors.redAccent,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30), // مسافة أمان في الأسفل
          ],
        ),
      ),
    );
  }
}
