import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: User Info
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFF6D4C41), const Color(0xFF8D6E63)],
                ),
              ),
              child: Center(
                child: Text(
                  "EC",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ),
            title: const Text(
              "Emma Craft",
              style: TextStyle(
                color: const Color(0xFF3E2723),
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            subtitle: const Text(
              "2h ago",
              style: TextStyle(
                color: const Color(0xFF8D6E63),
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),

          // Post Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Just finished this beautiful ceramic bowl set!",
              style: TextStyle(
                color: const Color(0xFF3E2723),
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),

          // Post Image (Responsive with AspectRatio)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 16 / 9, // يحافظ على تناسق الصورة في أي شاشة
                child: Image.network(
                  'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?q=80&w=500',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Footer: Actions (Likes, Comments, Share)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildStatItem(Icons.favorite_border, "124"),
                const SizedBox(width: 20),
                _buildStatItem(Icons.chat_bubble_outline, "18"),
                const Spacer(),
                const Icon(Icons.share_outlined, color: Color(0xFF8D6E63)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF8D6E63)),
        const SizedBox(width: 5),
        Text(
          count,
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }
}
