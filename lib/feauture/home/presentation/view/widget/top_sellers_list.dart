/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';



class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Text(state.errorMessage);
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(
              child: Text(
                'No Sellers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = state.sellers[index];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          product.imageUrl ?? '',
                          errorBuilder: (_, __, ___) {
                            return Image.asset(
                              'assets/images/bestseller.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';

class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(child: Text('No Sellers'));
          }

          return SizedBox(
            height: 230, // زيادة الارتفاع قليلاً لاستيعاب النصوص والبادينج
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final seller = state.sellers[index];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // زوايا مستديرة مثل الصورة
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // جزء الصورة
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            image: DecorationImage(
                              image: (seller.imageUrl != null && seller.imageUrl!.isNotEmpty)
                                  ? NetworkImage(seller.imageUrl!)
                                  : const AssetImage('assets/images/bestseller.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // جزء النصوص
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              seller.speciality ?? "Top Seller", // افترضت وجود وصف
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';

class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(child: Text('No Sellers'));
          }

          return SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final seller = state.sellers[index];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الصورة مضبوطة هنا باستخدام BoxFit.cover
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            image: DecorationImage(
                              image: (seller.imageUrl != null && seller.imageUrl!.isNotEmpty)
                                  ? NetworkImage(seller.imageUrl!)
                                  : const AssetImage('assets/images/bestseller.png') as ImageProvider,
                              fit: BoxFit.cover, // ده اللي بيخلي الصورة تملا المربع بدون تشوه
                            ),
                          ),
                        ),
                      ),

                      // النصوص والبادج
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // إضافة الـ Expert Badge هنا
                            if (seller.speciality == "Expert")
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    Icon(Icons.star, size: 12, color: Colors.orange),
                                    Text(" Expert", style: TextStyle(fontSize: 10, color: Colors.orange)),
                                  ],
                                ),
                              )
                            else
                              Text(
                                seller.speciality ?? "Artisan",
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';

class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(child: Text('No Sellers'));
          }

          return SizedBox(
            height: 230,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final seller = state.sellers[index];

                return Container(
                  width: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25), // حواف الكارت الخارجي
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // المجلد المسؤول عن الصورة
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  // هتاخد نفس الـ BorderRadius بتاع الـ Container الأب عشان الصورة تتقص صح
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)
                                  ),
                                  image: DecorationImage(
                                    image: (seller.imageUrl != null && seller.imageUrl!.isNotEmpty)
                                        ? NetworkImage(seller.imageUrl!)
                                        : const AssetImage('assets/images/bestseller.png') as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            // البادج فوق الصورة
                            if (seller.speciality == "Expert")
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE4BC64), // لون ذهبي مطفي مثل الصورة
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, size: 12, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        "Expert",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // منطقة النصوص
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF2D2D2D),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              seller.speciality ?? "Artisan",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../generated/locale_keys.g.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';

class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(child: Text('No Sellers'));
          }

          return SizedBox(
            height: 200,
            child: ListView.separated(

              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final seller = state.sellers[index];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // 1. حاوية الصورة بالحواف المستديرة
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25)
                                  ),
                                  image: DecorationImage(
                                    image: (seller.imageUrl != null && seller.imageUrl!.isNotEmpty)
                                        ? NetworkImage(seller.imageUrl!)
                                        : const AssetImage('assets/images/bestseller.png') as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // 2. البادج (Expert) - سيظهر دائماً الآن
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4BC64), // لون ذهبي
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, size: 12, color: Colors.white),
                                    const SizedBox(width: 4),
                                    Text(
                                      LocaleKeys.expert.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. منطقة النصوص (الاسم والتخصص)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF2D2D2D),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              seller.speciality ?? "Artisan",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}