import 'package:flutter/material.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/posts_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/widgets/review_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews_customer.dart';

class CustomerAccount extends StatelessWidget {
  const CustomerAccount({super.key});

  // final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          // onGoHome?.call,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          'Profile',
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
                        //  backgroundImage: user.profileImage != null
                        // ? NetworkImage(
                        //     user.profileImage ?? 'assets/images/person.png',
                        //   )
                        // : AssetImage('assets/images/person.png'),
                        backgroundImage: AssetImage(
                          'assets/images/topseller.png',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              // '${user.firstName} ${user.secondName}',
                              'eman mohamed',
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
                              // user.specialization ??
                              'Handmade enthusiast | Love supporting localHandmade enthusiast | Love supporting local',
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
                      onTap: () {},
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
                              ' Send Message',
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
