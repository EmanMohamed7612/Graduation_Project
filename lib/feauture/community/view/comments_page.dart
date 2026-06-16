import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/comment_model.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/comment_cubit.dart';
import 'package:graduation2/feauture/community/manager/comment_state.dart';
import 'package:graduation2/feauture/community/view/widgets/comment_card.dart';
import 'package:graduation2/feauture/community/view/widgets/comment_input_field.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, this.onGoHome, required this.postId});
  final int postId;
  final VoidCallback? onGoHome;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentsCubit(PostsRepo())..fetchComments(postId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Comments",
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
              if (onGoHome != null) {
                onGoHome!();
              } else {
                Navigator.maybePop(context);
              }
              // Navigator.pop(context, true);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentsCubit, CommentsState>(
                builder: (context, state) {
                  // if (state is CommentsLoading) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(
                  //       color: Color(0xFF6D4C41),
                  //     ),
                  //   );
                  // } else if (state is CommentsFetchSuccess ||
                  //     state is CommentsAddSuccess) {
                  //   // ملاحظة: لتبسيط الكود، يفضل دمج القوائم في Cubit واحد،
                  //   // لكن حالياً سنعرض القادمة من الـ Fetch
                  //   final List<CommentModel> comments =
                  //       (state is CommentsFetchSuccess)
                  //       ? state.comments
                  //       : (state is CommentsAddSuccess
                  //             ? [state.comment]
                  //             : []); // مثال بسيط

                  //   if (comments.isEmpty) {
                  //     return const Center(child: Text("No comments yet."));
                  //   }
                  if (state is CommentsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6D4C41),
                      ),
                    );
                  }

                  // بنستخدم القائمة اللي متخزنة في الـ Cubit نفسه
                  final comments = context.read<CommentsCubit>().allComments;

                  if (comments.isEmpty) {
                    return const Center(child: Text("No comments yet."));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentCard(
                        name: comment.userName,
                        initials: comment.userName
                            .substring(0, 1)
                            .toUpperCase(),
                        time: comment.timeAgo,
                        message: comment.text,
                      );
                    },
                  );
                  //   } else if (state is CommentsError) {
                  //     return Center(child: Text(state.message));
                  //   }
                  //   return const SizedBox();
                },
              ),
            ),
            CommentInputField(postId: postId),
          ],
        ),
      ),
    );
  }
}
