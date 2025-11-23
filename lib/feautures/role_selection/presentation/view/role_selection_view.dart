import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/role_selection/presentation/view/widgets/role_card.dart';
import 'package:project_craftoria/feautures/signup/presentation/view/sign_up_view.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
            vertical: size.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),

       
              Text(
                "Join Craftoria",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4B2E20),
                ),
              ),
              SizedBox(height: size.height * 0.008),

             
              Text(
                "Select your role to continue",
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: const Color(0xff8A6E63),
                ),
              ),

              SizedBox(height: size.height * 0.06),

          
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoleCard(
                      image: 'assets/images/iconcustomer.png',
                      title: "Customer",
                      subtitle: "Browse and buy unique handmade items",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpView();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.025),
                    RoleCard(
                      image: 'assets/images/seller.png',
                      title: "Seller",
                      subtitle: "Sell your handcrafted creations",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpView();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.025),
                    RoleCard(
                      image: 'assets/images/supplier.png',
                      title: "Supplier",
                      subtitle: "Provide materials and resources",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpView();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

