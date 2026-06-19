import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/community/data/post_repo.dart';
import 'package:graduation2/feauture/community/manager/my_posts_cubit.dart';
import 'package:graduation2/feauture/favourite/views/favourite_screen.dart';
import 'package:graduation2/feauture/message/manager/inboxmessage_cubit.dart';
import 'package:graduation2/feauture/message/manager/inboxmessage_repo.dart';
import 'package:graduation2/feauture/message/view/message_view.dart';
import 'package:graduation2/feauture/order_screen/deliver_screen/deliver_address.dart';

import 'package:graduation2/feauture/profile/views/accounts/widgets/posts_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/custom_button.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews_customer.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key, required this.user, this.onGoHome});
  final user;

  final VoidCallback? onGoHome;

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final ReviewApiService _reviewApiService = ReviewApiService();
  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;
  int postsCount = 0;

  Future<void> userstate() async {
    final stats = await _reviewApiService.getUserState(widget.user.id);
    final count = await PostsRepo().getUserPostsCount(widget.user.id);
    if (mounted) {
      setState(() {
        postsCount = count;
        if (stats != null) {
          averageRating = stats.averageRating;
          totalReviews = stats.totalReviews;
        }
        isLoadingRating = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userstate();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: width * .08,
                      backgroundImage: widget.user.profileImage != null
                          ? NetworkImage(
                        widget.user.profileImage ??
                            'assets/images/person.png',
                      )
                          : const AssetImage('assets/images/person.png') as ImageProvider,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            '${widget.user.firstName} ${widget.user.secondName}',
                            style: const TextStyle(
                              color: Color(0xFF3E2723),
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
                            widget.user.specialization ??
                                'Handmade enthusiast | Love supporting local',
                            style: const TextStyle(
                              color: Color(0xFF8D6E63),
                              fontSize: 12,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.63,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.description_outlined,
                                color: Color(0xFF8D6E63),
                                size: 14,
                              ),
                              Text(
                                '$postsCount ${LocaleKeys.posts.tr()} .',
                                style: const TextStyle(
                                  color: Color(0xFF8D6E63),
                                  fontSize: 12,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              const Icon(
                                Icons.star_outline_outlined,
                                color: Color(0xFF8D6E63),
                                size: 14,
                              ),
                              Text(
                                '$totalReviews  ${LocaleKeys.reviews.tr()}',
                                style: const TextStyle(
                                  color: Color(0xFF8D6E63),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonprofile(
                      text: LocaleKeys.orders.tr(),
                      icon: Icons.shopping_bag_outlined,
                      color1: const Color(0xFF6D4C41),
                      color2: const Color(0xFF8D6E63),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeliveryAddressScreen(),
                          ),
                        );
                      },
                    ),

                    CustomButtonprofile(
                      text: LocaleKeys.wishList.tr(),
                      icon: Icons.favorite_outline,
                      color1: const Color(0xFFC9A875),
                      color2: const Color(0xFFD4AF37),
                      onTap: () {
                        // ✅ التعديل هنا: تم إزالة الكيوبيت القديم والتنقل مباشرة لصفحة المفضلة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavouriteScreen(),
                          ),
                        );
                      },
                    ),
                    CustomButtonprofile(
                      text: LocaleKeys.messages.tr(),
                      icon: Icons.message_outlined,
                      color1: const Color(0xFFC9A875),
                      color2: const Color(0xFFD4AF37),
                      message: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) =>
                                InboxCubit(InboxRepo())
                                  ..startInboxUpdates(),
                                child: const MessagesScreen(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                    color: Colors.white,
                  ),
                  child: TabBar(
                    indicatorColor: const Color(0xff7A4A32),
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

                SizedBox(
                  height: height * .55,
                  width: double.infinity,
                  child: TabBarView(
                    children: [
                      BlocProvider(
                        create: (context) =>
                        MyPostsCubit(PostsRepo())
                          ..fetchUserPosts(widget.user.id),
                        child: MyPosts(),
                      ),
                      BlocProvider(
                        create: (context) =>
                        ReviewCubit(ReviewApiService())
                          ..getCreatedReviews(widget.user.id),
                        child: ReviewCustomer(userId: widget.user.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}