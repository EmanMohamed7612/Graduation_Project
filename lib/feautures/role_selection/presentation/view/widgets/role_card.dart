import 'package:flutter/material.dart';
import 'package:project_craftoria/feautures/auth/presentation/view/sign_up_view.dart';

class RoleCard extends StatelessWidget {
  // final IconData icon;
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const RoleCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
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
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Box
            Container(
              height: size.width * 0.14,
              width: size.width * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [const Color(0xFF6D4C41), const Color(0xFF8D6E63)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          
            SizedBox(width: size.width * 0.04),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF3E2723),
                      fontSize: 20,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0xFF8D6E63),
                      fontSize: 16,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
