import 'package:flutter/material.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  child: Image.asset(
                    'assets/images/ImageWithFallback.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .04,
                    vertical: size.height * .01,
                  ),
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  height: size.height * .25,
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
                            'Handcrafted Ceramic Bowl',
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
                          '\$45',
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
                          'Beautiful handmade ceramic bowl, perfect for serving or decoration. Each piece is unique with natural variations.',
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
                              'Sarah Williams',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
