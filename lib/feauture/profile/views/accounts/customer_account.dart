import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/my_posts_cubit.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/posts_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/review_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

import '../../../message/manager/inboxmessage_cubit.dart';
import '../../../message/manager/inboxmessage_repo.dart';
import '../../../message/view/message_view.dart';

class CustomerAccount extends StatelessWidget {
  const CustomerAccount({super.key,required this.user});
  final user;
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
                         backgroundImage: user.picturUrl != null
                                    ? NetworkImage(
                                        user.picturUrl ??
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
                               '${user.firstName} ${user.secondName}',
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
                               user.specialization??'',
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
                                  '12 Posts  .',
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
                                  '12 Reviews ',
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
                            builder: (context) => BlocProvider(
                              // هنا نقوم بإنشاء الـ Cubit ونعطيه الـ Repo الخاص به
                              create: (context) => InboxCubit(InboxRepo())..fetchInbox(),
                              child: const MessagesScreen(),
                            ),
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
                    child:  TabBar(
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
                      
                      //    BlocProvider(
                      //   create: (context) =>
                      //       MyPostsCubit(PostsRepo())
                      //         ..fetchUserPosts(widget.user.id),
                      //   child: MyPosts(),
                      // ),
                        PostsAccount(),
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
