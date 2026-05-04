import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation2/feauture/chat_bot/data/chat_bot_repo.dart';
import 'package:graduation2/feauture/chat_bot/manager/chat_bot_cubit.dart';
import 'package:graduation2/feauture/home/manager/fav_cubit.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/views/check_email.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
import 'package:graduation2/feauture/product/view/product_datails.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/write_review.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/view/book_sconsultation_screen.dart';

import 'package:graduation2/feauture/session/view/my_consultation.dart';
import 'package:graduation2/feauture/settings/manager/user_profile_cubit.dart';

import 'package:graduation2/feauture/splash_screen/presentation/view/splash.dart';

import 'core/utils/pref_helpers.dart';

import 'feauture/favourite/manager/favourite_cubit.dart';
import 'feauture/home/manager/category_cubit.dart';
import 'feauture/home/manager/fav_apiserves.dart';
import 'feauture/home/manager/fav_cubit.dart';
import 'feauture/language/lnguage_view.dart';
import 'feauture/material_screen/manager/cubit_materialcategory.dart';
import 'feauture/material_screen/manager/material_api_services.dart';
import 'feauture/material_screen/manager/material_cubit.dart';
import 'feauture/material_screen/manager/repo_material_imp.dart';
import 'feauture/home/manager/category_cubit.dart';
import 'feauture/home/manager/fav_apiserves.dart';
import 'feauture/language/lnguage_view.dart';

import 'feauture/order_screen/add_address_screens/manager/add_address_apiservces.dart';
import 'feauture/order_screen/add_address_screens/manager/add_address_cubit.dart';
import 'feauture/order_screen/deliver_screen/manager/getuseraddress_apiserves.dart';
import 'feauture/order_screen/deliver_screen/manager/getuseraddress_cubit.dart';
import 'feauture/product/data/product_details_repo.dart';
import 'feauture/product/manager/product_details_cubit.dart';
import 'feauture/product_screens/data/repo/repo_product.dart';
import 'feauture/product_screens/data/repo/repo_product_imple.dart';
import 'feauture/product_screens/manager/prodect_apiservice.dart';
import 'feauture/product_screens/manager/product_cubit.dart';
import 'feauture/product_screens/presentation/view/addprodect_screen/creatprodect.dart';
import 'feauture/review/manager/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedLang = await PrefHelpers.getLanguage() ?? 'en';
  final userId = await PrefHelpers.getUserId() ?? 'temp_cart_id';

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLang),
      //child: const CratoriaApp(),
      child: CratoriaApp(userId: userId),
    ),
  );
}

class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient(); // أو حسب ما بتعرفيه عندك
    final favoriteApiService = FavoriteApiService(dioClient);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartCubit(
            repo: CartRepo(),
            cartId: userId, // ⚡ استخدام userId
          )..loadCart(), // 🔹 نحمّل الكارت فورًا
        ),
        BlocProvider(
          create: (context) => DeleteProductCubit(
            repoProduct: RepoProductImple(
              productApiService: ProductApiService(),
            ),
          ),
        ),
        BlocProvider(
  create: (context) => UpdateProfileCubit(UserProfileRepo()), 
),

        BlocProvider(
          create: (context) => DeletematerialCubit(
            repomaterial: RepomaterialImple(
              materialApiService: MaterialApiService(),
            ),
          ),
        ),

        BlocProvider(create: (_) => AuthCubit(ApiService())),
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit(favoriteApiService),
          // الـ Cubit ده هينادي على loadFavorites() تلقائياً أول ما يفتح الأبلكيشن
          // زي ما إنتِ كاتبة في الـ Constructor بتاعه.
        ),
        BlocProvider(
          create: (context) =>
              UserProfileCubit(UserProfileRepo())..fetchProfile(),
        ),
        BlocProvider(
          create: (context) => CreateProductCubit(
            repoProduct: RepoProductImple(
              productApiService: ProductApiService(),
            ),
          ),
        ),
        BlocProvider(create: (context) => ExpertServiceCubit()),
        BlocProvider(create: (context) => ChatBotCubit(ChatBotRepo())),
        BlocProvider(
          create: (context) => CreatematerialCubit(
            repomaterial: RepomaterialImple(
              materialApiService: MaterialApiService(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) =>
              CategoryCubit(ProductApiService())..fetchCategories(),
        ),
        BlocProvider(
          create: (context) => UpdateProductCubit(
            repoProduct: RepoProductImple(
              productApiService: ProductApiService(),
            ),
          ),
        ),

        BlocProvider(
          create: (context) => UpdatematerialCubit(
            repomaterial: RepomaterialImple(
              materialApiService: MaterialApiService(),
            ),
          ),
        ),

        BlocProvider<ProductDetailsCubit>(
          create: (_) => ProductDetailsCubit(ProductDetailsRepo()),
        ),

        BlocProvider(
          create: (context) =>
              CategorymaterialCubit(MaterialApiService())
                ..fetchmaterialCategories(),
        ),

        BlocProvider(
          create: (context) => FavoriteCubit(FavoriteApiService(DioClient())),
        ),
        // BlocProvider<CartCubit>(create: (_) => CartCubit(repo: CartRepo(), cartId: 0)),
        BlocProvider<AddAddressCubit>(
          create: (context) =>
              AddAddressCubit(AddAddressApiService(DioClient())),
        ),

        // BlocProvider<CartCubit>(create: (_) => CartCubit(repo: CartRepo(), cartId: 0)),
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit(
            AddressApiService(DioClient()),
          )..fetchAddresses(), // ضيفي السطر ده عشان يحمل العناوين أول ما التطبيق يفتح
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFEFEBE9),
              textTheme: GoogleFonts.arimoTextTheme(),
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF3E2723),
                secondary: Color(0xFF8D6E63),
              ),
            ),
            home: SplashView(),
          );
        },
      ),
    );
  }
}
