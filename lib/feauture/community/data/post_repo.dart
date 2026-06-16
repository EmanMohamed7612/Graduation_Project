import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/community/data/comment_model.dart';
import 'package:graduation2/feauture/community/data/post_model.dart';

class PostsRepo {
  final ApiService _apiService = ApiService();

  Future<void> createPost({required String content, File? imageFile}) async {
    try {
      // تجهيز الـ Map للبيانات
      Map<String, dynamic> data = {
        "Content": content,
      };

      // إضافة الصورة لو موجودة
      if (imageFile != null) {
        data["Image"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      // تحويل لـ FormData لإرسال multipart/form-data
      FormData formData = FormData.fromMap(data);

      final response = await _apiService.post('/api/Posts', formData);

      if (response != null && response['success'] == true) {
        return;
      } else {
        throw Exception(response['message'] ?? "Failed to create post");
      }
    } catch (e) {
      rethrow;
    }
  }


Future<List<PostModel>> getAllPosts({int pageNumber = 1, int pageSize = 10}) async {
  try {
    final response = await _apiService.get('/api/Posts', {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    });

    if (response is Map<String, dynamic> && response['success'] == true) {
      List<dynamic> data = response['data'];
      return data.map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw Exception(response['message'] ?? "Failed to fetch posts");
    }
  } catch (e) {
    rethrow;
  }
}

Future<bool> toggleLike(int postId) async {
  try {
    // الـ endpoint: /api/Posts/{id}/like
    final response = await _apiService.post('/api/Posts/$postId/like', null);

    if (response is Map<String, dynamic> && response['success'] == true) {
      // الـ API بيرجع true لو اتعمل لايك و false لو اتلغى في الـ data object
      return response['data'] ?? false;
    } else {
      throw Exception("Failed to toggle like");
    }
  } catch (e) {
    rethrow;
  }
}

// داخل كلاس PostsRepo
Future<CommentModel> addComment(int postId, String commentText) async {
  try {
    // إرسال النص مباشرة كـ Object بين علامتين تنصيص
    final response = await _apiService.post(
      '/api/Posts/$postId/comments',
      '"$commentText"', 
    );

    if (response is Map<String, dynamic> && response['success'] == true) {
      return CommentModel.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? "Failed to add comment");
    }
  } catch (e) {
    rethrow;
  }
}

// داخل كلاس PostsRepo
Future<List<CommentModel>> getComments(int postId, {int pageNumber = 1, int pageSize = 10}) async {
  try {
    final response = await _apiService.get(
      '/api/Posts/$postId/comments',
      {
        'pageNumber': pageNumber,
        'pageSize': pageSize,
      },
    );

    if (response is Map<String, dynamic> && response['success'] == true) {
      List<dynamic> data = response['data'];
      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } else {
      throw Exception(response['message'] ?? "Failed to fetch comments");
    }
  } catch (e) {
    rethrow;
  }
}

// داخل كلاس PostsRepo
Future<List<PostModel>> getUserPosts(String userId, {int pageNumber = 1, int pageSize = 10}) async {
  try {
    // التعديل هنا: إضافة /user/ قبل الـ id وتمرير الـ query parameters
    final response = await _apiService.get('/api/Posts/user/$userId', {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    });

    if (response is Map<String, dynamic> && response['success'] == true) {
      List<dynamic> data = response['data'];
      return data.map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw Exception(response['message'] ?? "Failed to fetch user posts");
    }
  } catch (e) {
    rethrow;
  }
}
}