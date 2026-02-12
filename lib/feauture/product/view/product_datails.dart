import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/product_screens/data/model/creatprodect_model.dart';
import 'package:graduation2/feauture/profile/data/user_profile_model.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product, required this.user});
  final ProductModel product;
  final UserProfileModel user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        actions: [
          CustomIcon(icon: Icons.share_outlined),
          SizedBox(width: size.width * .02),
          CustomIcon(icon: Icons.favorite_border_outlined),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.02,
            ),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  height: size.height * .24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.network(
                    product.imagePath ?? 'assets/images/person.png',
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .04,
                    vertical: size.height * .01,
                  ),
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  height: size.height * .24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              color: const Color(0xFF3E2723),
                              fontSize: 18,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: size.width * .02,
                              right: size.width * .02,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffFFF8E1),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Color(0xffFFD700)),
                                Text(
                                  ' 4.8',
                                  style: TextStyle(
                                    color: const Color(0xFF3E2723),
                                    fontSize: 14.50,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w400,
                                    height: 1.33,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.price,
                          style: TextStyle(
                            color: const Color(0xFF6D4C41),
                            fontSize: 26,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.012),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.description,
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 14,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.63,
                          ),
                        ),
                      ),
                      Divider(
                        height: size.height * .02,
                        thickness: 1,
                        color: const Color(0xFF8D6E63),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              'Seller :',
                              style: TextStyle(
                                color: const Color(0xFF8D6E63),
                                fontSize: 14,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                            Text(
                              user.fullName,
                              style: TextStyle(
                                color: const Color(0xFF3E2723),
                                fontSize: 16,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .015),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),

                      gradient: const LinearGradient(
                        begin: Alignment(0.50, 0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
                      ),
                    ),
                    width: size.width,
                    height: size.height * .05,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            '  Chat with seller',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .015),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffFAF8F5),
                      border: Border.all(color: Color(0xff6D4C41)),
                    ),
                    width: size.width,
                    height: size.height * .05,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text(
                            '  View reviews  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff6D4C41),
                              fontSize: 18,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'You May Also Like',
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 14,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'See More →',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFC9A875),
                          fontSize: 14,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .01),
                SizedBox(
                  height: size.height * .12,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        width: size.width * .3,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(
                          'assets/images/ImageWithFallback.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff6D4C41)),
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFAF8F5),
                        ),
                        width: size.width * .4,
                        height: size.height * .05,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Color(0xff6D4C41),
                              ),
                              Text(
                                '  Add to cart',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff6D4C41),
                                  fontSize: 18,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),

                          gradient: const LinearGradient(
                            begin: Alignment(0.50, 0.00),
                            end: Alignment(0.50, 1.00),
                            colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)],
                          ),
                        ),
                        width: size.width * .4,
                        height: size.height * .05,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '  Buy',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
