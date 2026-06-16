import 'package:flutter/material.dart';

class PostsAccount extends StatelessWidget {
  const PostsAccount({super.key});

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

                height: height * .45,
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
                                '2 days ago',
                                style: TextStyle(
                                  color: const Color(0xFF8D6E63),
                                  fontSize: 12,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w400,
                                  height: 1.63,
                                ),
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
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                        top: 4,
                        bottom: 4,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/ImageWithFallback-7.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * .15,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(thickness: .5, color: Color(0xFF8D6E63)),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Color(0xFF8D6E63),
                        ),
                        Text(
                          '  67 likes',
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 12,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ],
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
// import 'package:flutter/material.dart';

// class MyPostsView extends StatelessWidget {
//   const MyPostsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     int count = 0;
//     return GridView.builder(
//       padding: const EdgeInsets.all(8),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 18,
//         crossAxisSpacing: 16,
//         childAspectRatio: 1,
//       ),
//       itemCount: 4,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {},
//           child: ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(15)),
//             child: Image.asset(
//               'assets/images/topseller.png',
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation2/feauture/community/manager/my_posts_cubit.dart';
// import 'package:graduation2/feauture/community/manager/my_posts_state.dart';

// class PostsAccount extends StatelessWidget {
//   const PostsAccount({super.key});

//   @override
//   Widget build(BuildContext context) {
//  //   double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return BlocBuilder<MyPostsCubit, MyPostsState>(
//       builder: (context, state) {
//         if (state is MyPostsLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is MyPostsError) {
//           return Center(child: Text(state.message));
//         } else if (state is MyPostsSuccess) {
//           if (state.posts.isEmpty) {
//             return const Center(child: Text("No posts found"));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),

//             physics: const BouncingScrollPhysics(),
//             itemCount: state.posts.length,
//             itemBuilder: (context, index) {
//               final post = state.posts[index];
//               return Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),

//                     // height: height * .45,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment
//                           .start, // لضبط النصوص على اليسار/اليمين
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               radius: width * .06,
//                               //  backgroundImage: user.profileImage != null
//                               // ? NetworkImage(
//                               //     user.profileImage ?? 'assets/images/person.png',
//                               //   )
//                               // : AssetImage('assets/images/person.png'),
//                               backgroundImage: post.userImage != null
//                                   ? NetworkImage(post.userImage!)
//                                   : const AssetImage('assets/images/person.png')
//                                         as ImageProvider,
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     textAlign: TextAlign.start,
//                                     // '${user.firstName} ${user.secondName}',
//                                     post.userName,
//                                     style: TextStyle(
//                                       color: const Color(0xFF3E2723),
//                                       fontSize: 16,
//                                       fontFamily: 'Arimo',
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.50,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     softWrap: true,
//                                     overflow: TextOverflow.visible,
//                                     // user.specialization ??
//                                     post.createdAt.split('T')[0],
//                                     style: TextStyle(
//                                       color: const Color(0xFF8D6E63),
//                                       fontSize: 12,
//                                       fontFamily: 'Arimo',
//                                       fontWeight: FontWeight.w400,
//                                       height: 1.63,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           textAlign: TextAlign.start,
//                           //  // user.specialization ??',
//                           post.content,
//                           style: TextStyle(
//                             color: const Color(0xff3E2723),
//                             fontSize: 16,
//                             fontFamily: 'Arimo',
//                             fontWeight: FontWeight.w400,
//                             height: 1.50,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         if (post.imageUrl != null) ...[
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               left: 8.0,
//                               right: 8,
//                               top: 4,
//                               bottom: 4,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Image.network(
//                                 post.imageUrl!,
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: 200,
//                               ),
//                             ),
//                           ),
//                         ],
//                         // Padding(
//                         //   padding: const EdgeInsets.only(
//                         //     left: 8.0,
//                         //     right: 8,
//                         //     top: 4,
//                         //     bottom: 4,
//                         //   ),
//                         //   child: ClipRRect(
//                         //     borderRadius: const BorderRadius.all(
//                         //       Radius.circular(16),
//                         //     ),
//                         //     child: Image.asset(
//                         //       'assets/images/ImageWithFallback-7.png',
//                         //       fit: BoxFit.cover,
//                         //       width: double.infinity,
//                         //       height: height * .15,
//                         //     ),
//                         //   ),
//                         // ),
//                         SizedBox(height: 8),
//                         Divider(thickness: .5, color: Color(0xFF8D6E63)),
//                         SizedBox(height: 16),
//                         Row(
//                           children: [
//                             // Icon(
//                             //   Icons.favorite_border_outlined,
//                             //   color: Color(0xFF8D6E63),
//                             // ),
//                             Text(
//                               '  ${post.likesCount} likes',
//                               style: TextStyle(
//                                 color: const Color(0xFF8D6E63),
//                                 fontSize: 12,
//                                 fontFamily: 'Arimo',
//                                 fontWeight: FontWeight.w400,
//                                 height: 1.33,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               );
//             },
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }

