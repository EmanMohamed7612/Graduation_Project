/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manager/category_cubit.dart';
import '../../../manager/category_state.dart';
import '../../../manager/search_cubit.dart';



class categorySearch extends StatefulWidget {
  final String searchQuery;
  const categorySearch({super.key, required this.searchQuery});

  @override
  State<categorySearch> createState() => _categorySearch();
}

class _categorySearch extends State<categorySearch> {
  // ✅ هذا هو السطر الذي يحل المشكلة (يجب تعريفه هنا وليس داخل build)
  String selectedCategoryId = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... باقي كود الـ Scaffold
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const SizedBox(
                      height: 40,
                      child: Center(child: CupertinoActivityIndicator())
                  );
                } else if (state is CategorySuccess) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // زر "الكل" - All
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryId = 'all';
                            });
                            context.read<SearchCubit>().fetchSearchResults(widget.searchQuery);
                          },
                          child: _buildCategoryChip("All", selectedCategoryId == 'all'),
                        ),
                        // عرض الأقسام القادمة من السيرفر
                        ...state.categories.map((category) {
                          // تحويل الـ id لنص مرة واحدة عشان نستخدمه في المقارنة والتعيين
                          final String categoryIdStr = category.id.toString();

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryId = categoryIdStr;
                              });
                              // البحث باسم القسم
                              context.read<SearchCubit>().fetchSearchResults(category.name);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _buildCategoryChip(
                                  category.name,
                                  selectedCategoryId == categoryIdStr
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                } else if (state is CategoryFailure) {
                  return const Text("Failed to load categories");
                }
                return const SizedBox();
              },
            )
            // ... باقي الكود
          ],
        ),
      ),
    );
  }

  // دالة الـ Chip
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
}*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manager/category_cubit.dart';
import '../../../manager/category_state.dart';
import '../../../manager/search_cubit.dart';

class CategoryFilterBar extends StatefulWidget {
  final String initialSearchQuery;

  const CategoryFilterBar({super.key, required this.initialSearchQuery});

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {
  String selectedCategoryId = 'all';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SizedBox(
            height: 40,
            child: Center(child: CupertinoActivityIndicator()),
          );
        } else if (state is CategorySuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // زر "All"
                _buildTab(
                  label: "All",
                  id: 'all',
                  onTap: () {
                    setState(() => selectedCategoryId = 'all');
                    context.read<SearchCubit>().fetchSearchResults(widget.initialSearchQuery);
                  },
                ),
                // الأقسام الديناميكية
                ...state.categories.map((category) {
                  final String categoryIdStr = category.id.toString();
                  return _buildTab(
                    label: category.name,
                    id: categoryIdStr,
                    onTap: () {
                      setState(() => selectedCategoryId = categoryIdStr);
                      context.read<SearchCubit>().fetchSearchResults(category.name);
                    },
                  );
                }).toList(),
              ],
            ),
          );
        } else if (state is CategoryFailure) {
          return const Text("Failed to load categories", style: TextStyle(fontSize: 12, color: Colors.red));
        }
        return const SizedBox();
      },
    );
  }

  // Widget فرعية لتصميم الـ Chip عشان الكود يبقى منظم
  Widget _buildTab({required String label, required String id, required VoidCallback onTap}) {
    bool isSelected = selectedCategoryId == id;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B5B4D) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}