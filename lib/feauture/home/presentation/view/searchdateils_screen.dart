


/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/search_cubit.dart';
import '../../manager/search_state.dart';

class SearchDetailsScreen extends StatelessWidget {
  final String searchQuery;
  const SearchDetailsScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9), // لون الخلفية الكريمي من التصميم
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            readOnly: true, // للقراءة فقط لأن البحث تم فعلاً
            decoration: InputDecoration(
              hintText: searchQuery,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: Colors.grey), // أيقونة الفلتر
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // قائمة التصنيفات العلوية (Horizontal Categories)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("All", true),
                  _buildCategoryChip("Ceramics", false),
                  _buildCategoryChip("Jewelry", false),
                  _buildCategoryChip("Home Decor", false),
                  _buildCategoryChip("Leather", false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    int count = (state is SearchSuccess) ? state.products.length : 0;
                    return Text("Showing $count products",
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.brown));
                  },
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort, size: 16, color: Colors.orangeAccent),
                  label: const Text("Sort by", style: TextStyle(color: Colors.orangeAccent)),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.brown));
                  } else if (state is SearchSuccess) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(state.products[index]);
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(child: Text(state.errMessage));
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

  // Widget لتصميم زر التصنيفات
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF7B5B4D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget لتصميم الكارت الخاص بكل منتج (كما في الصورة)
  Widget _buildProductCard(dynamic product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  product.image, // الصورة القادمة من API
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                  child: const Text("Handmade", style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(" 4.9", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(product.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                const Text("\$45", // السعر يمكن تحديثه إذا توفر في API
                    style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/category_search.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../product/data/product_details_repo.dart';
import '../../../product/manager/product_details_cubit.dart';
import '../../../product/view/product_datails.dart';
import '../../manager/search_cubit.dart';
import '../../manager/search_state.dart';

class SearchDetailsScreen extends StatelessWidget {
  final String searchQuery;
  const SearchDetailsScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9), // لون الخلفية الكريمي من التصميم
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: TextEditingController(text: searchQuery),
            onChanged: (value) {
              context.read<SearchCubit>().fetchSearchResults(value);
            },
            decoration: InputDecoration(
              hintText: searchQuery,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          )
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: Colors.grey), // أيقونة الفلتر
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 20),
            // قائمة التصنيفات العلوية (Horizontal Categories)
             //CategoryFilterBar(initialSearchQuery: searchQuery),
            const SizedBox(height: 20),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                int count = (state is SearchSuccess) ? state.products.length : 0;
                return Padding(
                  padding:  EdgeInsets.only(bottom: 10),
                  child: Text(
                    LocaleKeys.showing_products.tr(args: [count.toString()]),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.brown));
                  } else if (state is SearchSuccess) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return _buildProductCard(context,state.products[index]);
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(child: Text(state.errMessage));
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

  // Widget لتصميم زر التصنيفات
  /*Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF7B5B4D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }*/

  // Widget لتصميم الكارت الخاص بكل منتج (كما في الصورة)
  Widget _buildProductCard(BuildContext context, dynamic product) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) =>
                ProductDetailsCubit(ProductDetailsRepo())
                  ..fetchProductDetails(product.id),
                child: ProductDetails(productId: product.id),
              ),
            ),
          );
        },
    child:  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  product.image, // الصورة القادمة من API
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
                  child:  Text(LocaleKeys.handmade_label.tr(), style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(" 4.9", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(product.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                const Text("\$45", // السعر يمكن تحديثه إذا توفر في API
                    style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
            )
    );
  }
}