/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';


class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return SizedBox(
                  width: 170,
                  child: TopProductCard(
                    rank: index + 1,
                    name: product.name,
                    price: product.price.toString(),
                    rating: product.rating.toString(),
                    imageUrl: product.imageUrl,
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

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';

import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../manager/card_cubit.dart';
import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),

              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {

                    final isFav = context
                        .read<FavoriteCubit>()
                        .isFavorite(product.id);

                    return SizedBox(
                      width: 170,
                      child: GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().addToCart(product.id);
                        },
                        child: Stack(
                          children: [

                            TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                            ),

                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<FavoriteCubit>().toggleFavorite(product.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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
*/
/*return SizedBox(
width: 170,
child: Stack(
children: [

TopProductCard(
rank: index + 1,
name: product.name,
price: product.price.toString(),
rating: product.rating.toString(),
imageUrl: product.imageUrl,
),

Positioned(
top: 8,
right: 8,
child: GestureDetector(
onTap: () {
context
    .read<FavoriteCubit>()
    .toggleFavorite(product.id);
},
child: Container(
padding: const EdgeInsets.all(6),
decoration: const BoxDecoration(
color: Colors.white,
shape: BoxShape.circle,
),
child: Icon(
isFav
? Icons.favorite
    : Icons.favorite_border,
color: Colors.red,
size: 18,
),
),
),
)
],
),
);*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../manager/card_cubit.dart';
import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {
                    final isFav = favorites.contains(product.id);

                    return SizedBox(
                      width: 150,
                      child: Stack(
                        children: [
                          // 1. الكارت الأساسي مع تفعيل الضغط للإضافة للعربة
                          GestureDetector(
                            behavior: HitTestBehavior.opaque, // يضمن التقاط الضغط في كل المساحة
                            onTap: () {
                              debugPrint("Add to Cart Pressed for product: ${product.id}");
                              // استخدام context.read مباشرة هنا سليم طالما الـ Provider فوق الـ HomeScreen
                              context.read<CartCubit>().addToCart(product.id);
                            },
                            child: TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                            ),
                          ),

                          // 2. زر المفضلة (منفصل تماماً فوق الكارت)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                debugPrint("Toggle Favorite Pressed");
                                context.read<FavoriteCubit>().toggleFavorite(product.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 4)
                                  ],
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../../review/manager/cart_cubit.dart';

import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),

              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {

                    final isFav = favorites.contains(product.id);

                    return SizedBox(
                      width: 150,
                      child: Stack(
                        children: [

                          /// الكارت (الضغط عليه يضيف للكارت)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context.read<CartCubit>().toggleCartItem(product.id);
                            },
                            child: TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                              onTap: () {
                                context.read<CartCubit>().toggleCartItem(product.id);
                              },
                            ),
                          ),

                          /// زر المفضلة
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  context.read<FavoriteCubit>().toggleFavorite(product.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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

/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../../review/manager/cart_cubit.dart';

import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),

              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {

                    final isFav = favorites.contains(product.id);

                    return SizedBox(
                      width: 150,
                      child: Stack(
                        children: [

                          /// الكارت (الضغط عليه يضيف للكارت)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context.read<CartCubit>().toggleCartItem(product.id);
                            },
                            child: TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                            ),
                          ),

                          /// زر المفضلة
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  context.read<FavoriteCubit>().toggleFavorite(product.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';


class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return SizedBox(
                  width: 170,
                  child: TopProductCard(
                    rank: index + 1,
                    name: product.name,
                    price: product.price.toString(),
                    rating: product.rating.toString(),
                    imageUrl: product.imageUrl,
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

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';

import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../manager/card_cubit.dart';
import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),

              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {

                    final isFav = context
                        .read<FavoriteCubit>()
                        .isFavorite(product.id);

                    return SizedBox(
                      width: 170,
                      child: GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().addToCart(product.id);
                        },
                        child: Stack(
                          children: [

                            TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                            ),

                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<FavoriteCubit>().toggleFavorite(product.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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
*/
/*return SizedBox(
width: 170,
child: Stack(
children: [

TopProductCard(
rank: index + 1,
name: product.name,
price: product.price.toString(),
rating: product.rating.toString(),
imageUrl: product.imageUrl,
),

Positioned(
top: 8,
right: 8,
child: GestureDetector(
onTap: () {
context
    .read<FavoriteCubit>()
    .toggleFavorite(product.id);
},
child: Container(
padding: const EdgeInsets.all(6),
decoration: const BoxDecoration(
color: Colors.white,
shape: BoxShape.circle,
),
child: Icon(
isFav
? Icons.favorite
    : Icons.favorite_border,
color: Colors.red,
size: 18,
),
),
),
)
],
),
);*/
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';
import '../../../../review/manager/cart_cubit.dart';
import '../../../manager/card_cubit.dart';
import '../../../manager/fav_cubit.dart';

class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {
                    final isFav = favorites.contains(product.id);

                    return SizedBox(
                      width: 150,
                      child: Stack(
                        children: [
                          // 1. الكارت الأساسي مع تفعيل الضغط للإضافة للعربة
                          GestureDetector(
                            behavior: HitTestBehavior.opaque, // يضمن التقاط الضغط في كل المساحة
                            onTap: () {
                              debugPrint("Add to Cart Pressed for product: ${product.id}");
                              // استخدام context.read مباشرة هنا سليم طالما الـ Provider فوق الـ HomeScreen
                              context.read<CartCubit>().addToCart(product.id);
                            },
                            child: TopProductCard(
                              rank: index + 1,
                              name: product.name,
                              price: product.price.toString(),
                              rating: product.rating.toString(),
                              imageUrl: product.imageUrl,
                            ),
                          ),

                          // 2. زر المفضلة (منفصل تماماً فوق الكارت)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                debugPrint("Toggle Favorite Pressed");
                                context.read<FavoriteCubit>().toggleFavorite(product.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 4)
                                  ],
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
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
*/