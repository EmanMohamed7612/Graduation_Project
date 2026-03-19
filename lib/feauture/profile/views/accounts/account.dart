// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
// import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
// import 'package:graduation2/feauture/profile/manager/account_state.dart';
// import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
// import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
// import 'package:graduation2/feauture/profile/manager/profile_state.dart'
//     hide UserAccountLoading;
// import 'package:graduation2/feauture/profile/views/accounts/junior_account.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/customer_profile.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/expert_profile.dart';

// import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/supplier_profile.dart';

// class Account extends StatelessWidget {
//   const Account({super.key});
//   // final VoidCallback? onGoHome;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //  backgroundColor: Color(0xffEFEBE9),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new_outlined,
//             color: Color(0xff6D4C41),
//           ),
//         ),
//         title: Text(
//           'My Profile',
//           style: TextStyle(
//             color: const Color(0xFF3E2723),
//             fontSize: 16,
//             fontFamily: 'Arimo',
//             fontWeight: FontWeight.w400,
//             height: 1.50,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Navigator.pop(context);
//             },
//             icon: Icon(Icons.settings_outlined, color: Color(0xff6D4C41)),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,

//       body: SafeArea(
//         child: BlocBuilder<UserAccountCubit, UserAccountState>(
//           builder: (context, state) {
//             if (state is UserAccountLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is UserAccountFailure) {
//               return Center(child: Text(state.message));
//             }

//             if (state is UserAccountSuccess) {
//               final user = state.profile;
//               // if (user.roleType == 'Expert') {
//               //   return BlocProvider(
//               //     create: (_) =>
//               //         ProductCountCubit(ProductApiService())
//               //           ..fetchMyProductsCount(),
//               //     child: ExpertProfile(user: user, onGoHome: onGoHome),
//               //   );
//               // }
//               if (user.role == 'Expert') {
//                 return BlocProvider(
//                   create: (_) =>
//                       ProductCountCubit(ProductApiService())
//                         ..fetchMyProductsCount(user.id),
//                   child: JuniorAccount(user: user),
//                 );
//               }
//               //else if (user.role == 'Expert') {
//               //   return BlocProvider(
//               //     create: (_) =>
//               //         ProductCountCubit(ProductApiService())
//               //           ..fetchMyProductsCount(user.id),
//               //     child: ExpertProfile(user: user),
//               //   );
//               // }
//               else if (user.role == 'Supplier') {
//                 return BlocProvider(
//                   create: (_) =>
//                       ProductCountCubit(ProductApiService())
//                         ..fetchMyProductsCount(user.id),
//                   child: Supplierprofile(user: user),
//                 );
//               } else if (user.role == 'Customer') {
//                 return BlocProvider(
//                   create: (_) =>
//                       ProductCountCubit(ProductApiService())
//                         ..fetchMyProductsCount(user.id),
//                   child: CustomerProfile(user: user),
//                 );
//               }
//             }
//             return const Center(child: SizedBox());
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
// import 'package:graduation2/feauture/profile/manager/account_state.dart';
// import 'package:graduation2/feauture/profile/views/accounts/junior_account.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/customer_profile.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
// import 'package:graduation2/feauture/profile/views/myprofile/supplier_profile.dart';

// class AccountScreen extends StatelessWidget {
//   const AccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AccountCubit, AccountState>(
//       builder: (context, state) {

//         if (state is AccountLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state is AccountFailure) {
//           return Scaffold(
//             body: Center(child: Text(state.message)),
//           );
//         }

//         if (state is AccountSuccess) {
//           final user = state.user;

//           if (user.role == 'Seller') {
//             return SellerProfile(user: user);
//           }
//           else if (user.role == 'Expert') {
//             return JuniorAccount(user: user);
//           }
//           else if (user.role == 'Supplier') {
//             return Supplierprofile(user: user);
//           }
//           else {
//             return CustomerProfile(user: user);
//           }
//         }

//         return const SizedBox();
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
import 'package:graduation2/feauture/profile/manager/account.cubit.dart';
import 'package:graduation2/feauture/profile/manager/account_state.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_state.dart';
import 'package:graduation2/feauture/profile/views/accounts/expert_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/junior_account.dart';
import 'package:graduation2/feauture/profile/views/accounts/supplier_account.dart';
import 'package:graduation2/feauture/profile/views/myprofile/customer_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/expert_profile.dart';

import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/supplier_profile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // //  backgroundColor: Color(0xffEFEBE9),
    // appBar: AppBar(
    //   leading: IconButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     icon: Icon(
    //       Icons.arrow_back_ios_new_outlined,
    //       color: Color(0xff6D4C41),
    //     ),
    //   ),
    //   title: Text(
    //     'My Profile',
    //     style: TextStyle(
    //       color: const Color(0xFF3E2723),
    //       fontSize: 16,
    //       fontFamily: 'Arimo',
    //       fontWeight: FontWeight.w400,
    //       height: 1.50,
    //     ),
    //   ),
    //   centerTitle: true,
    //   actions: [
    //     IconButton(
    //       onPressed: () {
    //         // Navigator.pop(context);
    //       },
    //       icon: Icon(Icons.settings_outlined, color: Color(0xff6D4C41)),
    //     ),
    //   ],
    // ),
    // backgroundColor: Colors.white,
    BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is AccountSuccess) {
          final user = state.user;
          // if (user.roleType == 'Expert') {
          //   return BlocProvider(
          //     create: (_) =>
          //         ProductCountCubit(ProductApiService())
          //           ..fetchMyProductsCount(),
          //     child: ExpertProfile(user: user, onGoHome: onGoHome),
          //   );
          // }
          if (user.role == 'Beginner') {
            return BlocProvider(
              create: (_) =>
                  ProductCountCubit(ProductApiService())
                    ..fetchMyProductsCount(user.id),

              child: SellerProfile(user: user),


            );
          } else if (user.role == 'Expert') {
            return BlocProvider(
              create: (_) =>
                  ProductCountCubit(ProductApiService())
                    ..fetchMyProductsCount(user.id),
              child: ExpertAccount(user: user),
            );
          } else if (user.role == 'Supplier') {
            return BlocProvider(
              create: (_) =>
                  ProductCountCubit(ProductApiService())
                    ..fetchMyRawMaterialsCount(user.id),
              child: SupplierAccount(user: user),
            );
          } else if (user.role == 'Customer') {
            return BlocProvider(
              create: (_) =>
                  ProductCountCubit(ProductApiService())
                    ..fetchMyProductsCount(user.id),
              child: CustomerProfile(user: user),
            );
          }
        }
        return const Center(child: SizedBox());
      },
    );
  }
}
