import 'package:flutter/material.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';

class ReviewAccount extends StatelessWidget {
  const ReviewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),

      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),

                height: height * .2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //   radius: width * .08,
                        //   //  backgroundImage: user.profileImage != null
                        //   // ? NetworkImage(
                        //   //     user.profileImage ?? 'assets/images/person.png',
                        //   //   )
                        //   // : AssetImage('assets/images/person.png'),
                        //   backgroundImage: AssetImage(
                        //     'assets/images/topseller.png',
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/ImageWithFallback-7.png',
                            fit: BoxFit.cover,
                            width: width * .1,
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
                                'Ceramic Bowl Set',
                                style: TextStyle(
                                  color: const Color(0xFF3E2723),
                                  fontSize: 16,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Row(
                                children: [
                                  RatingStars(rating: 4),

                                  Text(
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    // user.specialization ??
                                    '  2 days ago',
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
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      //  // user.specialization ??',
                      'Just got this beautiful ceramic bowl set! The craftsmanship is absolutely stunning 😍',
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
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
