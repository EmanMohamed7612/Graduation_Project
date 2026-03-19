
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
