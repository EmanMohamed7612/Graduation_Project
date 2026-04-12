import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/number_product_state.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/materials.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/numberandtype.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews.dart';
import 'package:graduation2/feauture/product_screens/manager/product_cubit.dart';

import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class SupplierAccount extends StatefulWidget {
  const SupplierAccount({super.key, required this.user});
  final user;

  // final VoidCallback? onGoHome;
  @override
  State<SupplierAccount> createState() => _SupplierAccountState();
}

class _SupplierAccountState extends State<SupplierAccount> {
  bool isLoading = true;
  final ReviewApiService _reviewApiService = ReviewApiService();
  @override
  void initState() {
    super.initState();
    userstate();
  }

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int count = 0;
    return Scaffold(
      //  backgroundColor: Color.fromARGB(255, 149, 125, 114),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          '${widget.user.firstName} ${widget.user.secondName}',
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: Icon(Icons.share_outlined, color: Color(0xff6D4C41)),
          ),
        ],
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       child: IconButton(
              //         onPressed: () {
              //           widget.onGoHome?.call();
              //         },
              //         icon: Icon(
              //           Icons.arrow_back_ios_new_outlined,
              //           color: Color(0xff6D4C41),
              //         ),
              //       ),
              //     ),
              //     Text(
              //       'My Profile',
              //       style: TextStyle(
              //         color: const Color(0xFF3E2723),
              //         fontSize: 16,
              //         fontFamily: 'Arimo',
              //         fontWeight: FontWeight.w400,
              //         height: 1.50,
              //       ),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       child: IconButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         icon: Icon(Icons.settings_outlined, color: Color(0xff6D4C41)),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height * .02),
              Container(
                padding: const EdgeInsets.all(16),
                height: height * .33,
                color: Colors.white,
                width: width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: AlignmentGeometry.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: width * .11,
                              backgroundColor: const Color.fromARGB(
                                255,
                                222,
                                221,
                                221,
                              ),
                              child: CircleAvatar(
                                radius: width * .1,
                                backgroundImage: widget.user.picturUrl != null
                                    ? NetworkImage(
                                        widget.user.picturUrl ??
                                            'assets/images/person.png',
                                      )
                                    : AssetImage('assets/images/person.png'),
                                //  backgroundImage:AssetImage('assets/images/person.png'),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff8D6E63),
                                    Color(0xffA1887F),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),

                        BlocBuilder<ProductCountCubit, ProductCountState>(
                          builder: (context, state) {
                            if (state is ProductCountLoading) {
                              return const CircularProgressIndicator(
                                strokeWidth: 2,
                              );
                            }

                            if (state is ProductCountSuccess) {
                              count = state.count;
                              return NumberOfType(
                                number: state.count,
                                type: LocaleKeys.materials.tr(),
                              );
                            }
                            return NumberOfType(number: 0, type: LocaleKeys.materials.tr());
                          },
                        ),
                        NumberOfType(number: totalReviews, type: LocaleKeys.reviews.tr()),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Row(
                      children: [
                        Text(
                          //'eman',
                          '${widget.user.firstName} ${widget.user.secondName}',
                          style: TextStyle(
                            color: const Color(0xFF3E2723),
                            fontSize: 14.25,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(width: width * .03),
                        Container(

                          width: width * .14,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: LinearGradient(
                              colors: [Color(0xff8D6E63), Color(0xffA1887F)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.user.role}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.25,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.bold,
                                height: 1.43,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Master Ceramicist',
                        style: TextStyle(
                          color: const Color(0xFF6D4C41),
                          fontSize: 10.50,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ),
                    SizedBox(height: height * .01),
                    Row(
                      children: [
                        RatingStars(rating: averageRating),
                        // for (int i = 0; i < 4; i++)
                        //   Icon(Icons.star, color: Color(0xffC9A875), size: 15),
                        // Icon(Icons.star_border_outlined, size: 15),
                        isLoadingRating
                            ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                ' ${averageRating.toStringAsFixed(1)}   (${totalReviews}   reviews)',

                                style: TextStyle(
                                  color: const Color(0xFF8D6E63),
                                  fontSize: 11,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '12+ years creating wheel-thrown pottery ',
                        style: TextStyle(
                          color: const Color(0xFF8D6E63),
                          fontSize: 11,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
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
              //  SizedBox(height: height * .01),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    // Tabs
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child:  TabBar(
                        indicatorColor: Color(0xff7A4A32),
                        indicatorWeight: 2,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: LocaleKeys.materials.tr()),

                          Tab(text: LocaleKeys.reviews.tr()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Content
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 400, // مهم ❗ عشان TabBarView
                      child: TabBarView(
                        children: [
                          BlocProvider(
                            create: (context) =>
                                ProductsCubit(ProductOwnerProfileRepo())
                                  ..getRawMatrial(widget.user.id),
                            child: RawMatrialGrid(user: widget.user),
                          ),

                          BlocProvider(
                            create: (context) =>
                                ReviewCubit(ReviewApiService())
                                  ..getUserReviews(widget.user.id),
                            child: ReviewsView(userId: widget.user.id),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
