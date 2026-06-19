import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/community/data/post_model.dart';
import 'package:graduation2/feauture/community/manager/community_cubit.dart';
import 'package:graduation2/feauture/community/view/comments_page.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';
import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/account.dart';

class PostCard extends StatelessWidget {
  final PostModel post; // إضافة الـ Model
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: User Info
          ListTile(
            leading: ClipOval(
              child: SizedBox(
                width: 40, // العرض (ضعف الـ radius اللي كان 20)
                height: 40, // الطول
                child: post.userImage != null
                    ? Image.network(
                        post.userImage!,
                        fit: BoxFit
                            .cover, // ده السر اللي بيخلي الصورة تتظبط وتملأ الدائرة
                        errorBuilder: (context, error, stackTrace) {
                          // لو حصل مشكلة في تحميل الصورة من النت
                          return Image.asset(
                            "assets/images/person.png",
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        "assets/images/person.png",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     gradient: LinearGradient(
            //       colors: [const Color(0xFF6D4C41), const Color(0xFF8D6E63)],
            //     ),
            //   ),
            //   child: CircleAvatar(
            //     // child: Text(
            //     //   "EC",
            //     //   style: TextStyle(
            //     //     color: Colors.white,
            //     //     fontSize: 14,
            //     //     fontFamily: 'Arimo',
            //     //     fontWeight: FontWeight.w400,
            //     //     height: 1.50,
            //     //   ),
            //     // ),
            //     child: post.userImage != null
            //         ? Image.network(post.userImage!)
            //         : Image.asset("assets/images/no_photo.png"),
            //   ),
            // ),
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) =>
                          AccountCubit(UserProfileRepo())
                            ..fetchAccount(post.userId),
                      child: const AccountScreen(),
                    ),
                  ),
                );
              },
              child: Text(
                post.userName,
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 14,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ),
            subtitle: Text(
              post.createdAt.substring(0, 10),
              style: TextStyle(
                color: const Color(0xFF8D6E63),
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),

          // Post Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              post.content,
              style: TextStyle(
                color: const Color(0xFF3E2723),
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),

          // Post Image (Responsive with AspectRatio)
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(15),
          //     child: AspectRatio(
          //       aspectRatio: 16 / 9, // يحافظ على تناسق الصورة في أي شاشة
          // child: Image.network(
          //   'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?q=80&w=500',
          //   fit: BoxFit.cover,
          // ),
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio:
                      16 / 9, // بيحافظ على شكل المستطيل السينمائي زي الصورة
                  child: Image.network(
                    post.imageUrl!,
                    fit: BoxFit
                        .cover, // مهم جداً عشان الصورة تملأ المكان المخصص ليها
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/no_photo.png",
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xFF6D4C41),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          //     ),
          //   ),
          // ),

          // Footer: Actions (Likes, Comments, Share)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildStatItem(
                  post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                  post.likesCount.toString(),
                  color: post.isLikedByMe
                      ? Colors.red
                      : const Color(0xFF8D6E63), // تغيير اللون
                  onTap: () {
                    // منادي على الـ Cubit
                    context.read<CommunityCubit>().toggleLike(post.id);
                  },
                ),
                const SizedBox(width: 20),
                _buildStatItem(
                  Icons.chat_bubble_outline,
                  post.commentsCount.toString(),
                  onTap: () async {
                    final communityCubit = context.read<CommunityCubit>();

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          // 2. نمرر نفس الـ Cubit لصفحة التعليقات عشان تقدر تكلمه
                          value: communityCubit,
                          child: CommentsPage(postId: post.id),
                        ),
                      ),
                    );
                  },
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) {
                  //         return CommentsPage(postId: post.id);
                  //       },
                  //     ),
                  //   );
                  //   if (context.mounted) {
                  //     context.read<CommunityCubit>().updateCommentCount(
                  //       post.id,
                  //     );
                  //   }
                  // },
                ),
                const Spacer(),
                // const Icon(Icons.share_outlined, color: Color(0xFF8D6E63)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String count, {
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? const Color(0xFF8D6E63)),
          const SizedBox(width: 5),
          Text(
            count,
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
