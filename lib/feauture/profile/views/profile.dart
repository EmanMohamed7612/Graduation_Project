import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_state.dart';
import 'package:graduation2/feauture/profile/views/expert_profile.dart';

import 'package:graduation2/feauture/profile/views/seller_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff7A4A32),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserProfileFailure) {
              return Center(child: Text(state.message));
            }

            if (state is UserProfileSuccess) {
              final user = state.profile;
              if (user.roleType == 'Expert') {
                return BlocProvider(
                  create: (_) =>
                      ProductCountCubit(ProductApiService())
                        ..fetchMyProductsCount(),
                  child: ExpertProfile(user: user),
                );
              } else if (user.roleType == 'Beginner' ||user.roleType=='Customer') {
                return BlocProvider(
                  create: (_) =>
                      ProductCountCubit(ProductApiService())
                        ..fetchMyProductsCount(),
                  child: SellerProfile(user: user),
                );
              }
            }
            return const Center(child: SizedBox());
          },
        ),
      ),
    );
  }
}
