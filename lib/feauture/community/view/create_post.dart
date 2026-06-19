import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/create_post_cubit.dart';
import 'package:graduation2/feauture/community/manager/create_post_state.dart';
import 'package:graduation2/feauture/community/view/widgets/action_button.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/story_field.dart';
import 'widgets/upload_box.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.onGoHome});
  final VoidCallback? onGoHome;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(PostsRepo()),
      child: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          print("Current State is: $state");
          if (state is CreatePostSuccess) {
            // 1. إخفاء أي تنبيه قديم
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );

            // الحل السحري: نستخدم Navigator.pop بالـ context الحالي فوراً
            // التأخير الـ 200 ملي ثانية أحياناً بيعمل مشكلة لو الـ state اتغيرت بسرعة
            Navigator.of(context).pop(true);
          } else if (state is CreatePostFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          //
          final cubit = context.read<CreatePostCubit>();

          return Scaffold(
            //backgroundColor: const Color(0xFFFDFBFA), // لون الخلفية من التصميم
            appBar: AppBar(
              title: const Text(
                "Create Post",
                style: TextStyle(
                  color: Color(0xFF3E2723),
                  fontSize: 21,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xff6D4C41),
                ),
                onPressed: () {
                  if (widget.onGoHome != null) {
                    widget.onGoHome!();
                  } else {
                    Navigator.maybePop(context);
                  }
                },
              ),
            ),
            body: SafeArea(
              child: LayoutBuilder(
                // بيساعدنا نعرف مقاس الشاشة المتاح
                builder: (context, constraints) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false, // مهم جداً عشان الـ Spacer يشتغل
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              StoryField(controller: contentController),
                              const SizedBox(height: 24),
                              const Text(
                                "Add Photo",
                                style: TextStyle(
                                  color: Color(0xFF3E2723),
                                  fontSize: 14,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // GestureDetector(
                              //   onTap: () async {
                              //     final picker = ImagePicker();
                              //     final pickedFile = await picker.pickImage(
                              //       source: ImageSource.gallery,
                              //     );
                              //     if (pickedFile != null) {
                              //       context.read<CreatePostCubit>().setImage(
                              //         File(pickedFile.path),
                              //       );
                              //     }
                              //   },
                              //   child: const UploadBox(),
                              // ),
                              GestureDetector(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (pickedFile != null) {
                                    // context.read<CreatePostCubit>().setImage(
                                    //   File(pickedFile.path),
                                    // );
                                    cubit.setImage(File(pickedFile.path));
                                  }
                                },
                                child:
                                    context
                                            .read<CreatePostCubit>()
                                            .selectedImage !=
                                        null
                                    ? Container(
                                        // الشكل اللي هيظهر لما تختار صورة
                                        width: double.infinity,
                                        height:
                                            200, // تقدري تكبري الارتفاع عشان الصورة تبان
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFD7CCC8),
                                            width: 1.5,
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                              context
                                                  .read<CreatePostCubit>()
                                                  .selectedImage!,
                                            ),
                                            fit: BoxFit
                                                .cover, // عشان الصورة تملأ المكان بشكل شيك
                                          ),
                                        ),
                                      )
                                    : const UploadBox(), // لو مفيش صورة يظهر الـ UploadBox القديم
                              ),
                              // Spacer بيزق كل اللي تحته لآخر الشاشة
                              // const Spacer(),
                              if (context
                                      .read<CreatePostCubit>()
                                      .selectedImage !=
                                  null)
                                Text("Image Selected ✅"),

                              const Spacer(),
                              Builder(
                                builder: (context) {
                                  if (state is CreatePostLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xff6D4C41),
                                      ),
                                    );
                                  }
                                  // لو الحالة نجاح أو فشل أو ابتدائية، يظهر الزرار
                                  return ActionButtons(
                                    onPost: () {
                                      if (contentController.text.isNotEmpty) {
                                        cubit.submitPost(
                                          contentController.text,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              // if (state is CreatePostLoading)
                              //   Center(child: const CircularProgressIndicator())
                              // else
                              //   ActionButtons(
                              //     onPost: () {
                              //       // context.read<CreatePostCubit>().submitPost(
                              //       //   contentController.text,
                              //       // );
                              //       cubit.submitPost(contentController.text);
                              //     },
                              //   ),
                              // const SizedBox(
                              //   height: 40,
                              // ), // مسافة أمان قبل الأزرار
                              // const ActionButtons(),
                              const SizedBox(
                                height: 24,
                              ), // مسافة تحت الزرار الأخير
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
