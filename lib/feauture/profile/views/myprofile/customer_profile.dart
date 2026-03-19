import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';
import 'package:graduation2/feauture/favourite/manager/favourite_cubit.dart';
import 'package:graduation2/feauture/favourite/views/favourite_screen.dart';
import 'package:graduation2/feauture/home/manager/fav_apiserves.dart';

import 'package:graduation2/feauture/profile/views/accounts/widgets/posts_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/custom_button.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews_customer.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';

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

  Future<void> userstate() async {
    final stats = await _reviewApiService.getUserState(widget.user.id);

    if (stats != null) {
      setState(() {
        averageRating = stats.averageRating;
        totalReviews = stats.totalReviews;
        isLoadingRating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      //  padding: const EdgeInsets.all(16),
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
                          : AssetImage('assets/images/person.png'),
                      // backgroundImage: AssetImage('assets/images/topseller.png'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            '${widget.user.firstName} ${widget.user.secondName}',
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
                            widget.user.specialization ??
                                'Handmade enthusiast | Love supporting local',
                            style: TextStyle(
                              color: const Color(0xFF8D6E63),
                              fontSize: 12,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.63,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                color: const Color(0xFF8D6E63),
                                size: 14,
                              ),
                              Text(
                                '0 Posts  .',
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
                                '${totalReviews}  Reviews',
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonprofile(
                      text: 'Orders',
                      icon: Icons.shopping_bag_outlined,
                      color1: const Color(0xFF6D4C41),
                      color2: const Color(0xFF8D6E63),
                    ),

                    CustomButtonprofile(
                      text: 'WishList',
                      icon: Icons.favorite_outline,
                      color1: const Color(0xFFC9A875),
                      color2: const Color(0xFFD4AF37),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return FavouriteScreen();
                        //     },
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return BlocProvider(
                                create: (context) => MyFavoriteCubit(
                                  FavoriteApiService(DioClient()),
                                )..getFavorites(),
                                child: FavouriteScreen(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    CustomButtonprofile(
                      text: 'Messages',
                      icon: Icons.message_outlined,
                      color1: const Color(0xFFC9A875),
                      color2: const Color(0xFFD4AF37),
                      message: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
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
                  child: const TabBar(
                    indicatorColor: Color(0xff7A4A32),
                    indicatorWeight: 2,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Posts'),

                      Tab(text: 'Reviews'),
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
                      //  PostsView(),
                      //   MyPostsView(),
                      PostsAccount(),
                      // ReviewCustomer(userId:widget.user.id),
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
