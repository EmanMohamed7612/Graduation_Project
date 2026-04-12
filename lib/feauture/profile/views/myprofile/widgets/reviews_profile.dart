import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/manager/review_state.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:intl/intl.dart';

class ReviewsProfile extends StatefulWidget {
  const ReviewsProfile({super.key, required this.userId});
  final String userId;
  @override
  State<ReviewsProfile> createState() => _ReviewsProfileState();
}

// String formatDate(String time) {
//   DateTime dateTime = DateTime.parse(time);
//   return DateFormat('dd / MM / yyyy').format(dateTime);
// }

String formatDate(String? time) {
  if (time == null || time.isEmpty) return '';

  try {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd / MM / yyyy').format(dateTime);
  } catch (e) {
    return time;
  }
}

class _ReviewsProfileState extends State<ReviewsProfile> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getUserReviews(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //  bool showWrieReview = false;
    return Column(
      children: [
        Expanded(
          // height: height * .4,
          child: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) {
              if (state is ReviewLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReviewLoaded) {
                final reviews = state.reviews;

                if (reviews.isEmpty) {
                  return const Center(child: Text("No Reviews Yet"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  itemCount: reviews.length,

                  //           final review = reviews[index];
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: height * .15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: width * .05,
                                    backgroundImage:
                                        review.reviewerImage != null
                                        ? NetworkImage(
                                            review.reviewerImage ??
                                                'assets/images/person.png',
                                          )
                                        : AssetImage(
                                            'assets/images/person.png',
                                          ),
                                    // backgroundImage: AssetImage(
                                    //   'assets/images/topseller.png',
                                    // ),
                                  ),
                                  // ClipRRect(
                                  //   borderRadius: const BorderRadius.all(
                                  //     Radius.circular(12),
                                  //   ),
                                  //   child: Image.asset(
                                  //     'assets/images/ImageWithFallback-7.png',
                                  //     fit: BoxFit.cover,
                                  //     width: width * .1,
                                  //   ),
                                  // ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.start,
                                              '${review.reviewerName}',
                                              //  'Eman Mohamed',
                                              style: TextStyle(
                                                color: const Color(0xFF3E2723),
                                                fontSize: 16,
                                                fontFamily: 'Arimo',
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                              ),
                                            ),
                                            Text(
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              formatDate(review.createdAt),
                                              // '  2 days ago',
                                              style: TextStyle(
                                                color: const Color(0xFF8D6E63),
                                                fontSize: 12,
                                                fontFamily: 'Arimo',
                                                fontWeight: FontWeight.w400,
                                                height: 1.63,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        RatingStars(
                                          rating: review.rating.toDouble(),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                textAlign: TextAlign.start,
                                '${review.review}',
                                //'Just got this beautiful ceramic bowl set! The craftsmanship is absolutely stunning 😍',
                                style: TextStyle(
                                  color: const Color(0xff3E2723),
                                  fontSize: 16,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              }

              if (state is ReviewError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),

          // BlocBuilder<ReviewCubit, ReviewState>(
          //   builder: (context, state) {
          //     if (state is ReviewLoading) {
          //       return const Center(child: CircularProgressIndicator());
          //     }

          //     if (state is ReviewLoaded) {
          //       final reviews = state.reviews;

          //       if (reviews.isEmpty) {
          //         return const Center(child: Text("No Reviews Yet"));
          //       }

          //       return ListView.builder(
          //         itemCount: reviews.length,
          //         itemBuilder: (context, index) {
          //           final review = reviews[index];

          //           return Container(
          //             padding: const EdgeInsets.all(8),
          //             margin: const EdgeInsets.only(bottom: 16),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(16),
          //             ),

          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     const CircleAvatar(
          //                       backgroundImage: AssetImage(
          //                         'assets/images/topseller.png',
          //                       ),
          //                     ),

          //                     const SizedBox(width: 12),

          //                     Expanded(
          //                       child: Column(
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                         children: [
          //                           Text(
          //                             review.reviewerName,
          //                             style: const TextStyle(
          //                               fontSize: 16,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),

          //                           RatingStars(
          //                             rating: review.rating.toDouble(),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),

          //                 const SizedBox(height: 8),

          //                 Text(
          //                   review.review,
          //                   style: const TextStyle(fontSize: 14),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       );
          //     }

          //     if (state is ReviewError) {
          //       return Center(child: Text(state.message));
          //     }

          //     return const SizedBox();
          //   },
          // ),
        ),
      ],
    );
  }
}
