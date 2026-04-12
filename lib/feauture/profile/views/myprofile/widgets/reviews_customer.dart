import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/review/manager/review_cubit.dart';
import 'package:graduation2/feauture/review/manager/review_state.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class ReviewCustomer extends StatefulWidget {
  const ReviewCustomer({super.key, required this.userId});
  final String userId;
  @override
  State<ReviewCustomer> createState() => _ReviewCustomerState();
}

class _ReviewCustomerState extends State<ReviewCustomer> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getCreatedReviews(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReviewLoaded) {
          final reviews = state.reviews;

          if (reviews.isEmpty) {
            return Center(child: Text(LocaleKeys.no_reviews.tr()));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .65,
            ),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return GestureDetector(
                onTap: () {},

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child:
                            //  review.itemImage != null
                            //                                    ? Image.(
                            //                                       review.itemImage ??
                            //                                            'assets/images/person.png',
                            //                                      )
                            //                                    : AssetImage(
                            //                                        'assets/images/person.png',
                            //                                      ),
                            //                             AssetImage(
                            //                                        'assets/images/person.png',
                            //                                      ),
                            // Image.asset(
                            //   'assets/images/topseller.png',
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            // ),
                            //review.itemImage != null
                            //?
                            review.itemImage != null &&
                                review.itemImage!.startsWith('http')
                            ? Image.network(
                                review.itemImage!,
                                height: height * .15,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/no_photo.png',
                                height: height * .15,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        //: Image.asset('assets/images/no_photo.png'),
                        // backgroundImage: AssetImage(
                        //   'assets/images/topseller.png',
                        // ),
                      ),

                      // backgroundImage:
                      //                                     review.reviewerImage != null
                      //                                     ? NetworkImage(
                      //                                         review.reviewerImage ??
                      //                                             'assets/images/person.png',
                      //                                       )
                      //                                     : AssetImage(
                      //                                         'assets/images/person.png',
                      //                                       ),
                      //                                 // backgroundImage: AssetImage(
                      //                                 //   'assets/images/topseller.png',
                      //                                 // ),
                      //                               ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: RatingStars(
                                rating: review.rating.toDouble(),
                              ),
                              // child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Icon(
                              //       Icons.star,
                              //       color: const Color(0xffC9A875),
                              //       size: 16,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Icon(
                              //       Icons.star,
                              //       color: const Color(0xffC9A875),
                              //       size: 16,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Icon(
                              //       Icons.star,
                              //       color: const Color(0xffC9A875),
                              //       size: 16,
                              //     ),
                              //   ],
                              // ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                '${review.itemName}',
                                maxLines: 4,
                                style: const TextStyle(
                                  color: Color(0xff7A4A32),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
