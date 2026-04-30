import 'package:flutter/material.dart';
import 'package:graduation2/feauture/review/view/cart/widget/primary_button.dart';
import 'package:graduation2/feauture/settings/view/widgets/custom_textfield.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ), // للحفاظ على التنسيق في الشاشات الواسعة (Tablets)
                  child: Column(
                    children: [
                      // قسم الصورة الشخصية
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.brown[300],
                            child: const Text(
                              "S",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFC4A484),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Tap to change photo",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      const SizedBox(height: 30),

                      // الحقول (Widgets جاهزة للاستخدام)
                      const CustomInputField(
                        label: "Full Name",
                        initialValue: "Sarah Johnson",
                        icon: Icons.person_outline,
                      ),
                      const CustomInputField(
                        label: "Specialization",
                        initialValue: "Sales Associate",
                        icon: Icons.work_outline,
                      ),
                      const CustomInputField(
                        label: "Gender",
                        initialValue: "Female",
                        icon: Icons.wc_outlined,
                      ),
                      const CustomInputField(
                        label: "Bio",
                        initialValue: "",
                        icon: Icons.info_outline,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 20),

                      PrimaryButton(text: "Save Changes", onPressed: () {}),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
