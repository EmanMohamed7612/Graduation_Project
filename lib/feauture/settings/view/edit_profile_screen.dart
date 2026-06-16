import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_state.dart';
import 'package:graduation2/feauture/review/view/cart/widget/primary_button.dart';
import 'package:graduation2/feauture/settings/manager/user_profile_cubit.dart';
import 'package:graduation2/feauture/settings/manager/user_profile_state.dart';
import 'package:graduation2/feauture/settings/view/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  File? _selectedImage;

  // ميثود لاختيار صورة
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  // // ميثود الحفظ
  // Future<void> _saveData() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     // بنقسم الـ Full Name لـ First و Last لو محتاجة
  //     List<String> names = nameController.text.split(' ');

  //     await _repo.updateUserProfile(
  //       firstName: names.isNotEmpty ? names[0] : "",
  //       lastName: names.length > 1 ? names.sublist(1).join(' ') : "",
  //       specialization: specController.text,
  //       bio: bioController.text,
  //       imageFile: _selectedImage,
  //       gender: 1, // كمثال: 1 للذكر و 2 للأنثى حسب الـ Enum عندك
  //     );

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Profile Updated Successfully!")),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }
  @override
  void initState() {
    super.initState();
    // يجب جلب البيانات الحالية من الـ Cubit ووضعها في الـ Controllers
    // final user = context.read<UserProfileCubit>().state;
    // if (user is UserProfileSuccess) {
    //   nameController.text =
    //       "${user.profile.firstName} ${user.profile.secondName}";
    //   bioController.text = user.profile.bio;
    //   specController.text = user.profile.specialization ?? "";

    //   // ... وهكذا
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = context.read<UserProfileCubit>().state;

      if (userState is UserProfileSuccess) {
        nameController.text =
            "${userState.profile.firstName} ${userState.profile.secondName}";

        bioController.text = userState.profile.bio;

        specController.text = userState.profile.specialization ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) async {
        if (state is UpdateProfileSuccess) {
          context.read<UserProfileCubit>().fetchProfile();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile Updated Successfully!")),
          );
          // بعدين الـ pop
          Navigator.pop(context, true); // الرجوع للخلف بعد النجاح
          //Navigator.of(context).pop(true);
        }
        if (state is UpdateProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
              "Edit Profile",
              style: TextStyle(
                color: Color(0xFF3E2723),
                fontSize: 16,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
              ),
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
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : null,
                              child: _selectedImage == null
                                  ? const Text("S")
                                  : null,
                            ),
                          ),
                          // Stack(
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 50,
                          //       backgroundColor: Color(0xFF7D5D52),
                          //       child: Text(
                          //         "S",
                          //         style: TextStyle(
                          //           fontSize: 32,
                          //           fontFamily: 'Arimo',
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //     Positioned(
                          //       bottom: 0,
                          //       right: 0,
                          //       child: Container(
                          //         padding: const EdgeInsets.all(4),
                          //         decoration: const BoxDecoration(
                          //           color: Color(0xFFC9A875),
                          //           shape: BoxShape.circle,
                          //         ),
                          //         child: const Icon(
                          //           Icons.camera_alt_outlined,
                          //           color: Colors.white,
                          //           size: 15,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 8),
                          const Text(
                            "Tap to change photo",
                            style: TextStyle(
                              color: const Color(0xFF8D6E63),
                              fontSize: 10.50,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // الحقول (Widgets جاهزة للاستخدام)
                          CustomInputField(
                            label: "Full Name",
                            initialValue: "Sarah Johnson",
                            icon: Icons.person_outline,
                            controller: nameController,
                          ),
                          CustomInputField(
                            label: "Specialization",
                            initialValue: "Sales Associate",
                            icon: Icons.work_outline,
                            controller: specController,
                          ),
                          CustomInputField(
                            label: "Gender",
                            initialValue: "Female",
                            icon: Icons.wc_outlined,
                            controller: genderController,
                          ),
                          CustomInputField(
                            label: "Bio",
                            initialValue: "",
                            icon: Icons.info_outline,
                            maxLines: 4,
                            controller: bioController,
                          ),

                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: state is UpdateProfileLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : PrimaryButton(
                                    text: "Save Changes",
                                    onPressed: () {
                                      context
                                          .read<UpdateProfileCubit>()
                                          .updateProfile(
                                            fullName: nameController.text,
                                            bio: bioController.text,
                                            specialization: specController.text,
                                            imageFile: _selectedImage,
                                          );
                                      // context
                                      //     .read<UpdateProfileCubit>()
                                      //     .updateProfile(
                                      //       fullName: nameController.text,
                                      //       bio: bioController.text,
                                      //       specialization:
                                      //           specController.text,
                                      //       imageFile: _selectedImage,
                                      //     );
                                    },
                                  ),
                          ),
                          // _isLoading
                          //     ? const Center(
                          //         child: CircularProgressIndicator(
                          //           color: Color(0xFF70564F),
                          //         ),
                          //       )
                          //     : PrimaryButton(
                          //         text: "Save Changes",
                          //         onPressed:
                          //             _saveData, // هنا بننادي الميثود مباشرة
                          //       ),
                          // PrimaryButton(
                          //   text: "Save Changes",
                          //   onPressed: () {
                          //     _isLoading
                          //         ? const CircularProgressIndicator()
                          //         : PrimaryButton(
                          //             text: "Save Changes",
                          //             onPressed: _saveData,
                          //           );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
