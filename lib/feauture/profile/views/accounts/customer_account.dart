import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/my_posts_cubit.dart';
import 'package:graduation2/feauture/message/manager/message_cubit.dart';
import 'package:graduation2/feauture/message/manager/message_repo.dart';
import 'package:graduation2/feauture/message/manager/message_singlerR.dart';
import 'package:graduation2/feauture/message/view/messagechatpage.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/posts_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/review_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class CustomerAccount extends StatefulWidget {
  const CustomerAccount({super.key, required this.user});
  final user;

  @override
  State<CustomerAccount> createState() => _CustomerAccountState();
}

class _CustomerAccountState extends State<CustomerAccount> {
  final ReviewApiService _reviewApiService = ReviewApiService();
  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;
  int postsCount = 0;

  Future<void> userstate() async {
    final stats = await _reviewApiService.getUserState(widget.user.id);
    final count = await PostsRepo().getUserPostsCount(widget.user.id);
    if (mounted) {
      // للتأكد أن الـ widget لسه موجودة
      setState(() {
        postsCount = count; // 3. تحديث العدد
        if (stats != null) {
          averageRating = stats.averageRating;
          totalReviews = stats.totalReviews;
        }
        isLoadingRating = false;
      });
    }
    // if (stats != null) {
    //   setState(() {
    //     averageRating = stats.averageRating;
    //     totalReviews = stats.totalReviews;
    //     isLoadingRating = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    userstate(); // استدعاء الدالة عند فتح الصفحة
  }

  // final VoidCallback onGoHome;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // onGoHome?.call,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          LocaleKeys.profile.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: height * .22,
              color: Colors.white,
              width: width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: width * .08,
                        backgroundImage: widget.user.picturUrl != null
                            ? NetworkImage(
                                widget.user.picturUrl ??
                                    'assets/images/person.png',
                              )
                            : AssetImage('assets/images/person.png'),
                        // backgroundImage: AssetImage(
                        //   'assets/images/topseller.png',
                        // ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              '${widget.user.firstName} ${widget.user.secondName}',
                              //  'eman mohamed',
                              style: TextStyle(
                                color: const Color(0xFF3E2723),
                                fontSize: 16,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              widget.user.specialization ?? '',
                              //'Handmade enthusiast | Love supporting localHandmade enthusiast | Love supporting local',
                              style: TextStyle(
                                color: const Color(0xFF8D6E63),
                                fontSize: 12,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.63,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  color: const Color(0xFF8D6E63),
                                  size: 14,
                                ),
                                Text(
                                  '$postsCount ${LocaleKeys.posts.tr()} .',
                                  style: TextStyle(
                                    color: const Color(0xFF8D6E63),
                                    fontSize: 12,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                                Icon(
                                  Icons.star_outline_outlined,
                                  color: const Color(0xFF8D6E63),
                                  size: 14,
                                ),
                                Text(
                                  '${totalReviews}  ${LocaleKeys.reviews.tr()}',
                                  style: TextStyle(
                                    color: const Color(0xFF8D6E63),
                                    fontSize: 12,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .025),
                  Container(
                    height: height * 0.04,
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        begin: Alignment(0.50, 0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [
                          const Color(0xFF6D4C41),
                          const Color(0xFF8D6E63),
                        ],
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) =>
                                    MessagesCubit(
                                      MessagesRepo(),
                                      SignalRService(), // يجب تمرير الـ Service هنا
                                    )..loadMessages(
                                      widget.user.id,
                                    ), // استدعاء الميثود بعد التهيئة
                                // value: context.read<MessagesCubit>()..loadMessages(widget.user.id),
                                child: ChatScreen(
                                  otherUserId: widget.user.id,
                                  otherUserName: widget.user.fullName,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.messenger_outline_outlined,
                              color: Colors.white,
                              size: 16,
                            ),

                            Text(
                              ' ${LocaleKeys.sendmessage.tr()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Arimo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                      color: Colors.white,
                    ),
                    child: TabBar(
                      indicatorColor: Color(0xff7A4A32),
                      indicatorWeight: 2,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: LocaleKeys.posts.tr()),

                        Tab(text: LocaleKeys.reviews.tr()),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Content
                  SizedBox(
                    height: height * .55,
                    width: double.infinity,

                    // مهم ❗ عشان TabBarView
                    child: TabBarView(
                      children: [
                        BlocProvider(
                          create: (context) =>
                              MyPostsCubit(PostsRepo())
                                ..fetchUserPosts(widget.user.id),
                          child: MyPosts(),
                        ),
                        //postsAccount(),
                        ReviewAccount(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
