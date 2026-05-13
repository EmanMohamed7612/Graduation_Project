import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/manager/comment_cubit.dart';
import 'package:graduation2/feauture/community/manager/comment_state.dart';
import 'package:graduation2/feauture/community/manager/community_cubit.dart';

class CommentInputField extends StatefulWidget {
  const CommentInputField({super.key, required this.postId});
  final int postId;
  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      listener: (context, state) {
        // if (state is CommentsAddSuccess) {
        //   _controller.clear();
        //   // هنا ممكن تضيفي كود لتحديث قائمة التعليقات
        //   ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text("Comment added!")));
        // }
        if (state is CommentsAddSuccess) {
          _controller.clear();

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Comment added!")));

          // هنا هننادي على الـ CommunityCubit عشان يزود العداد
          // لأننا هنا متأكدين 100% إن التعليق اتضاف بنجاح
          context.read<CommunityCubit>().updateCommentCount(widget.postId);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    hintStyle: TextStyle(
                      color: const Color(0xFFBCAAA4),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9F8F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: const Color(0xFFC9A875),
                child: state is CommentSendLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          context.read<CommentsCubit>().sendComment(
                            widget.postId,
                            _controller.text,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
