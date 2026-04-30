import 'package:flutter/material.dart';
import 'package:graduation2/feauture/community/view/widgets/post_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key, this.onGoHome});
  final VoidCallback? onGoHome;
  @override
  Widget build(BuildContext context) {
    // نستخدم MediaQuery لمعرفة عرض الشاشة لضبط الـ Padding
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth > 600 ? screenWidth * 0.2 : 16.0;

    return Scaffold(
      // لون خلفية مريح
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xff6D4C41),
          ),
          onPressed: () {
            if (onGoHome != null) {
              onGoHome!();
            } else {
              // لو مش موجودة (زي لو فاتحين البروفايل من صفحة تانية بـ push)
              Navigator.maybePop(context);
            }
          },
        ),
        title: const Text(
          "Community",
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFF6D4C41), const Color(0xFF8D6E63)],
                ),
              ),
              // لون بني داكن
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 10,
        ),
        itemCount: 5, // عدد المنشورات
        itemBuilder: (context, index) {
          return const PostCard();
        },
      ),
    );
  }
}
