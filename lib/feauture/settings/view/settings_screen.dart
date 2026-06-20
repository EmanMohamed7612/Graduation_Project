import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/language/lnguage_view.dart';
import 'package:graduation2/feauture/settings/view/edit_profile_screen.dart';
import 'package:graduation2/feauture/settings/view/widgets/restart_wodget.dart';
import 'package:graduation2/feauture/settings/view/widgets/setting.group.dart';
import 'package:graduation2/feauture/settings/view/widgets/settings_item.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _profileUpdated = false;
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
              onPressed: () => Navigator.pop(context, _profileUpdated),
            ),
          ),
        ),
        title: Text(
          LocaleKeys.settings.tr(),
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
              header: LocaleKeys.account.tr(),
              items: [
                SettingItem(
                  icon: Icons.language,
                  title: LocaleKeys.language.tr(),
                  subtitle: LocaleKeys.english.tr(),
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
                  title: LocaleKeys.editprofile.tr(),
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditProfilePage(),
                    //   ),
                    // );
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );

                    // إذا رجعت بـ true، نغير حالة المتغير في الـ Settings
                    if (result == true) {
                      setState(() => _profileUpdated = true);
                    }
                    // final result = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditProfilePage(),
                    //   ),
                    // );
                    // print("EditProfile returned: $result"); // ← ضيفي ده
                    // if (result == true) {
                    //   setState(() => _profileUpdated = true);
                    //   print("_profileUpdated set to true"); // ← وده
                    // }
                  },
                ),
                SettingItem(
                  icon: Icons.lock_outline,
                  title: LocaleKeys.privacyandsecurity.tr(),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // مجموعة الدعم - Support Section
            SettingsGroup(
              header: LocaleKeys.support.tr(),
              items: [
                SettingItem(
                  icon: Icons.help_outline,
                  title: LocaleKeys.helpcenter.tr(),
                  onTap: () {},
                ),
                // SettingItem(
                //   icon: Icons.logout,
                //   title: LocaleKeys.logout.tr(),
                //   textColor: Colors.redAccent,
                //   onTap: () {
                //     // context.read<AuthCubit>().logout();

                //     // // 2. توجيه المستخدم لصفحة الـ Login ومسح كل الـ Routes السابقة
                //     // Navigator.pushAndRemoveUntil(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => LoginView()),
                //     //   (route) => false,
                //     // );
                //     context.read<AuthCubit>().logout();

                //     // 2. التوجيه لصفحة الـ LoginScreen باستخدام الـ rootNavigator لتفريغ الـ Stack بالكامل
                //     if (context.mounted) {
                //       Navigator.of(
                //         context,
                //         rootNavigator: true,
                //       ).pushAndRemoveUntil(
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               LoginView(), // تأكدي من اسم شاشة تسجيل الدخول عندك
                //         ),
                //         (route) =>
                //             false, // يمسح الـ Wrapper وكل الشاشات السابقة من الذاكرة
                //       );
                //     }
                //     // if (context.mounted) {
                //     //   RestartWidget.restartApp(context);
                //     // }
                //   },
                // ),
              ],
            ),

            const SizedBox(height: 30), // مسافة أمان في الأسفل
          ],
        ),
      ),
    );
  }
}
