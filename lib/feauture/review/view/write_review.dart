import 'package:flutter/material.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/product_screens/data/model/creatprodect_model.dart';
import 'package:graduation2/feauture/product_screens/data/model/prodect_model_explore.dart';
import 'package:graduation2/feauture/review/data/add_review_model.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';
import 'package:graduation2/feauture/review/view/widgets/rating_star.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
    this.productId,
    this.targetUserId,
    this.rawMaterialId,
  });
  final int? productId;
  final String? targetUserId;
  final int? rawMaterialId;
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final ReviewApiService _reviewApiService = ReviewApiService();
  int selectedRating = 0;
  bool isLoading = false;
  Future<void> submitReview() async {
    if (selectedRating == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select rating')));
      return;
    }

    setState(() => isLoading = true);

    try {
      await _reviewApiService.addOrUpdateReview(
        AddReviewRequest(
          productId: widget.productId,
          targetUserId: widget.targetUserId,
          rawMaterialId: widget.rawMaterialId,
          rating: selectedRating,
          review: _reviewController.text,
        ),
      );

      // 1. التأكد إن الشاشة لسه مفتوحة قبل ما نظهر السناك بار أو نقفلها
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Review submitted successfully')),
      );

      // 2. قفل الشاشة وإرجاع true
      Navigator.pop(context, true);
    } on ApiError catch (e) {
      if (!mounted) return; // حماية إضافية
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return; // لو حصل أي إيرور غير متوقع
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      // 3. المشكلة الأساسية كانت هنا: لازم تتأكد إن الشاشة موجودة قبل الـ setState
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
  // Future<void> submitReview() async {
  //   if (selectedRating == 0) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Please select rating')));
  //     return;
  //   }

  //   setState(() => isLoading = true);

  //   try {
  //     await _reviewApiService.addOrUpdateReview(
  //       AddReviewRequest(
  //         productId: widget.productId,
  //         targetUserId: widget.targetUserId,
  //         rawMaterialId: widget.rawMaterialId,
  //         rating: selectedRating,
  //         review: _reviewController.text,
  //       ),
  //     );

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('✅ Review submitted successfully')),
  //     );

  //     Navigator.pop(context, true);
  //   } on ApiError catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.message)));
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          'Reviews & Ratings',
          style: TextStyle(color: Color(0xff3E2723)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: height * .5,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Write Your Review',
                  style: TextStyle(
                    color: Color(0xFF3E2723),
                    fontSize: 20,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Your Rating',
                  style: TextStyle(
                    color: Color(0xFF3E2723),
                    fontSize: 18,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                BuildRatingScreen(
                  onRatingChanged: (value) {
                    selectedRating = value;
                  },
                ),

                const SizedBox(height: 16),
                const Text(
                  "Your Review",
                  style: TextStyle(
                    color: const Color(0xFF3E2723),
                    fontSize: 18,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  controller: _reviewController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Share your experience with this product...",
                    filled: true,
                    fillColor: Color(0xffFAF8F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xffEFEBE9)),
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * .4,
                      height: height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          side: const BorderSide(color: Color(0xff6D4C41)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: OutlinedButton(
                    //     onPressed: () => Navigator.pop(context),
                    //     style: OutlinedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(24),
                    //       ),
                    //       side: const BorderSide(color: Color(0xff6D4C41)),
                    //     ),
                    //     child: const Text("Cancel"),
                    //   ),
                    // ),
                    const SizedBox(width: 12),
                    Container(
                      width: width * .4,
                      height: height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment(0.50, 0.00),
                          end: Alignment(0.50, 1.00),
                          colors: [
                            const Color(0xFF6D4C41),
                            const Color(0xFF8D6E63),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: isLoading ? null : submitReview,
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Center(
                                child: Text(
                                  "Submit Review",
                                  style: TextStyle(color: Colors.white),
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
