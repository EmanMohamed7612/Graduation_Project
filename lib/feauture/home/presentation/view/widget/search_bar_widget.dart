/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/rescources/colors.dart';
import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';

class SearchBarWidget extends StatefulWidget {

  const SearchBarWidget({super.key});



  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final LayerLink _layerLink = LayerLink(); // للربط بين الحقل والقائمة المنبثقة
  OverlayEntry? _overlayEntry;
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();

  // وظيفة لإظهار قائمة النتائج
  void _showOverlay(BuildContext context, ProductState state) {
    _hideOverlay(); // إخفاء القائمة القديمة إن وجدت

    if (state is ProductSuccess && _controller.text.isNotEmpty) {
      final filteredList = state.products
          .where((p) => p.name.toLowerCase().contains(_controller.text.toLowerCase()))
          .toList();

      if (filteredList.isEmpty) return;

      _overlayEntry = _createOverlayEntry(context, filteredList);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(BuildContext context, List products) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(item.name),
                    subtitle: Text(item.categoryName ?? "Product"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Product", style: TextStyle(fontSize: 10)),
                    ),
                    onTap: () {
                      _controller.text = item.name;
                      _hideOverlay();
                      // انتقلي هنا لصفحة تفاصيل المنتج
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          _showOverlay(context, state);
        },
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            if (value.isEmpty) {
              _hideOverlay();
            } else {
              context.read<ProductCubit>().searchProducts(value);
            }
          },
          decoration: InputDecoration(
            hintText: "Search crafts & materials...",
            prefixIcon: Icon(Icons.search, color: AppColors.kTextLight),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
              _controller.clear();
              _hideOverlay();
            })
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../product_screens/manager/product_cubit.dart';




class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search crafts & materials...",
        prefixIcon: Icon(Icons.search, color:AppColors.kTextLight),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/rescources/colors.dart';
import '../../../../product_screens/manager/product_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<ProductCubit>().searchProducts(value);
      },
      decoration: InputDecoration(
        hintText: "Search crafts & materials...",
        prefixIcon: Icon(Icons.search, color: AppColors.kTextLight),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/rescources/colors.dart';
import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../../generated/locale_keys.g.dart'; // عدل المسار حسب مشروعك

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // اتأكد إن الـ ProductCubit متوفر (Provided) فوق الـ Screen دي في الـ Tree
        context.read<ProductCubit>().searchProducts(value);
      },
      decoration: InputDecoration(
        hintText: "Search crafts & materials...",
        prefixIcon: const Icon(Icons.search, color: AppColors.kTextLight),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}*/

 import 'dart:async'; // ضروري جداً لحل مشكلة التايمر
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// استورد ملفات الـ Cubit والـ Model والـ Colors

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce; // تعريف التايمر بشكل صحيح

  void _showOverlay(BuildContext context, List<SearchProductModel> products) {
    _hideOverlay();
    if (products.isEmpty) return;

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(item.name),
                    subtitle: const Text("Product"),
                    onTap: () {
                      _controller.text = item.name;
                      _hideOverlay();
                      // انتقل لصفحة التفاصيل هنا
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _debounce?.cancel(); // إغلاق التايمر عند الخروج
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccess) {
            _showOverlay(context, state.products);
          } else if (state is SearchInitial) {
            _hideOverlay();
          }
        },
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();

            if (value.isEmpty) {
              _hideOverlay();
            } else {
              // حل مشكلة الـ Timer: استدعاء التايمر كـ Statement وليس داخل if
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<SearchCubit>().fetchSearchResults(value);
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Search handmade products...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
              ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
                  _controller.clear();
                  _hideOverlay();
                })
              : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}*/
/*import 'dart:async'; // ضروري جداً لحل مشكلة التايمر
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/search_model.dart';
import '../../../manager/search_cubit.dart';
import '../../../manager/search_state.dart';
import '../searchdateils_screen.dart';
// استورد ملفات الـ Cubit والـ Model والـ Colors

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce; // تعريف التايمر بشكل صحيح

  void _showOverlay(BuildContext context, List<SearchProductModel> products) {
    _hideOverlay();
    if (products.isEmpty) return;

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(item.name),
                    subtitle: const Text("Product"),
                    onTap: () {
                      _controller.text = item.name;
                      _hideOverlay();
                      // انتقل لصفحة التفاصيل هنا
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _debounce?.cancel(); // إغلاق التايمر عند الخروج
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccess) {
            _showOverlay(context, state.products);
          } else if (state is SearchInitial) {
            _hideOverlay();
          }
        },
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();

            if (value.isEmpty) {
              _hideOverlay();
            } else {
              // حل مشكلة الـ Timer: استدعاء التايمر كـ Statement وليس داخل if
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<SearchCubit>().fetchSearchResults(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchDetailsScreen(searchQuery: query),
                  ),
                );
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Search handmade products...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
              _controller.clear();
              _hideOverlay();
            })
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
*/
/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// استبدلي هذه المسارات بالمسارات الصحيحة في مشروعك إذا كانت مختلفة
import '../../../data/search_model.dart';
import '../../../manager/search_cubit.dart';
import '../../../manager/search_state.dart';
import '../searchdateils_screen.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce;

  // وظيفة الانتقال لصفحة النتائج الكاملة
  void _navigateToDetails(String query) {
    if (query.trim().isEmpty) return;
    _hideOverlay();

    // نقوم بتخزين الـ Cubit الحالي قبل الانتقال
    final searchCubit = context.read<SearchCubit>();
    searchCubit.fetchSearchResults(query);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: searchCubit, // نمرر نفس النسخة للصفحة الجديدة
          child: SearchDetailsScreen(searchQuery: query),
        ),
      ),
    );
  }
  void _showOverlay(BuildContext context, List<SearchProductModel> products) {
    _hideOverlay();
    if (products.isEmpty) return;

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(item.name),
                    subtitle: const Text("Product", style: TextStyle(fontSize: 12)),
                    onTap: () {
                      _controller.text = item.name;
                      _navigateToDetails(item.name); // انتقال عند الضغط على المقترح
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _hideOverlay(); // إغلاق القائمة عند الخروج من الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccess) {
            _showOverlay(context, state.products);
          } else if (state is SearchInitial) {
            _hideOverlay();
          }
        },
        child: TextField(
          controller: _controller,
          // البحث عند الضغط على Enter في الكيبورد
          onSubmitted: (value) {
            _navigateToDetails(value);
          },
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();

            if (value.isEmpty) {
              _hideOverlay();
            } else {
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<SearchCubit>().fetchSearchResults(value);
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Search handmade products...",
            // جعل أيقونة البحث قابلة للضغط أيضاً
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _navigateToDetails(_controller.text),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _hideOverlay();
                })
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}*/
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// تأكدي أن المسارات أدناه صحيحة حسب مشروعك
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/search_model.dart';
import '../../../manager/search_cubit.dart';
import '../../../manager/search_state.dart';
import '../searchdateils_screen.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounce;

  // إخفاء القائمة المنبثقة
  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  // وظيفة الانتقال لصفحة النتائج الكاملة
  void _navigateToDetails(BuildContext context, String query) {
    if (query.trim().isEmpty) return;

    _hideOverlay();
    _debounce?.cancel();

    final searchCubit = BlocProvider.of<SearchCubit>(context);
    searchCubit.fetchSearchResults(query);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: searchCubit,
          child: SearchDetailsScreen(searchQuery: query),
        ),
      ),
    );
  }

  // إظهار قائمة المقترحات
  void _showOverlay(BuildContext context, List<SearchProductModel> products) {
    _hideOverlay();
    if (products.isEmpty) return;

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final item = products[index];
                  return ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey),
                    title: Text(item.name),
                    subtitle: Text(LocaleKeys.products.tr(), style: const TextStyle(fontSize: 12)),
                    onTap: () {
                      _controller.text = item.name;
                      _navigateToDetails(context, item.name);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccess) {
            _showOverlay(context, state.products);
          } else if (state is SearchInitial || state is SearchLoading) {
            _hideOverlay();
          }
        },
        child: TextField(
          controller: _controller,
          onSubmitted: (value) => _navigateToDetails(context, value),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            if (value.isEmpty) {
              _hideOverlay();
            } else {
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<SearchCubit>().fetchSearchResults(value);
              });
            }
            setState(() {}); // لتحديث أيقونة الـ Clear
          },
          decoration: InputDecoration(
            hintText: LocaleKeys.search_crafts_materials.tr(),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _navigateToDetails(context, _controller.text),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _hideOverlay();
                  setState(() {});
                })
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}