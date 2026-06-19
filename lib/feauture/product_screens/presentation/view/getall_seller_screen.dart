/*import 'package:flutter/material.dart';

class AllSellersScreen extends StatelessWidget {
  const AllSellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4), // لون الخلفية الفاتح
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("All Sellers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Discover talented artisans", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            _buildFilterTabs(),
            const SizedBox(height: 20),
            Expanded(child: _buildSellersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _filterChip("All", true),
          _filterChip("Expert", false),
          _filterChip("Beginner", false),
          _filterChip("Supplier", false),
        ],
      ),
    );
  }

  Widget _filterChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF8B6B5D) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
    );
  }

  Widget _buildSellersList() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage("assets/images/profile.png")),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Emma Rodriguez", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        _expertBadge(),
                      ],
                    ),
                    const Text("Ceramics Expert - 12+ years experience", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Text(" 4.9  1240 sales", style: TextStyle(fontSize: 12)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _expertBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(5)),
      child: const Row(
        children: [Icon(Icons.star, size: 10, color: Colors.orange), Text(" Expert", style: TextStyle(fontSize: 10))],
      ),
    );
  }
}*/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';
import 'package:graduation2/generated/locale_keys.g.dart';


class AllSellersScreen extends StatelessWidget {
  const AllSellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          LocaleKeys.all_sellers.tr(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Text(
              LocaleKeys.discover_talented_artisans.tr(),
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildFilterTabs(),
            const SizedBox(height: 20),

            /// هنا ربطناها بالـ Cubit
            Expanded(
              child: BlocBuilder<BestSellerCubit, BestSellerState>(
                builder: (context, state) {
                  if (state is BestSellerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BestSellerFailure) {
                    return Center(child: Text(state.errorMessage));
                  }

                  if (state is BestSellerSuccess) {
                    if (state.sellers.isEmpty) {
                      return const Center(child: Text("No Sellers"));
                    }

                    return ListView.builder(
                      itemCount: state.sellers.length,
                      itemBuilder: (context, index) {
                        final seller = state.sellers[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                // نقوم بالتحقق إذا كان الرابط فارغاً أو null
                                backgroundImage: (seller.imageUrl != null && seller.imageUrl!.isNotEmpty)
                                    ? NetworkImage(seller.imageUrl!) as ImageProvider
                                    : const AssetImage("assets/images/bestseller.png"), // الصورة الافتراضية من ملفاتك
                              ),
                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          seller.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        _expertBadge(),
                                      ],
                                    ),
                                    Text(
                                      LocaleKeys.top_sellers.tr()
                                      ,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _filterChip("All", true),
          _filterChip(LocaleKeys.filter_expert.tr(), false),
          _filterChip(LocaleKeys.filter_beginner.tr(), false),
          _filterChip(LocaleKeys.filter_supplier.tr(), false),
        ],
      ),
    );
  }

  Widget _filterChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF8B6B5D) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _expertBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 10, color: Colors.orange),
          Text(
              LocaleKeys.expert.tr(),
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}