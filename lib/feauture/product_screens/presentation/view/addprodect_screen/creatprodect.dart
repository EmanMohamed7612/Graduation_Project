import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:graduation2/feauture/home/data/model/categories_model_forhome.dart'
as home;


import '../../../data/model/creatprodect_model.dart';
import '../../../manager/prodect_apiservice.dart';
import '../Editprodect_screen/editprodect.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/addprodect_screen/widget/input_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Controllers
  List<home.CategoriesModel> _categories = [];
  home.CategoriesModel? _selectedCategory;


  bool _isLoadingCategories = true;
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  // Image handling
  String? selectedImagePath;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // State
  final ProductApiService _apiService = ProductApiService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        selectedImagePath = image.path;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      // افترضي أن هذه الدالة موجودة في ApiService وتجلب قائمة الأقسام
      final categories = await _apiService.fetchCategories();
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    } catch (e) {
      setState(() => _isLoadingCategories = false);
      // handle error
    }
  }

  Future<void> _addProduct() async {
    // 1. التحقق من الحقول الأساسية
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        _selectedCategory == null) { // التحقق من اختيار قسم
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category and fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. تجهيز الموديل
      final product = ProductModel(
        imagePath: selectedImagePath,
        name: nameController.text,
        price: priceController.text,
        stock: stockController.text,
        category: _selectedCategory!.id.toString(),
        
        description: descriptionController.text,
      );

      // 3. إرسال الطلب للسيرفر
      final createdProduct = await _apiService.createProduct(product);

      if (createdProduct != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully! ✅')),
        );

        // الانتقال لصفحة التعديل أو العودة
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EditProductScreen(product: createdProduct),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      // هنا سيظهر خطأ "User not authenticated" إذا لم يكن هناك توكن
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Product',
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildLabel('Product Image'),
              const SizedBox(height: 8),
              _buildImagePicker(),
              const SizedBox(height: 16),
              _buildLabel('Product Name'),
              CustomTextField(hint: 'Enter product name', controller: nameController),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildNumericField('Price (\$)', '0.00', priceController)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildNumericField('Stock', '0', stockController)),
                ],
              ),
              const SizedBox(height: 12),
              _buildLabel('Category'),
              const SizedBox(height: 6),
              _isLoadingCategories
                  ? const CircularProgressIndicator() // مؤشر تحميل لحين جلب البيانات
                  : DropdownButtonFormField<home.CategoriesModel>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                hint: const Text("Select Category"),
                items: _categories.map((category) {
                  return DropdownMenuItem<home.CategoriesModel>(
                    value: category,
                    child: Text(category.name), // يعرض الاسم للمستخدم
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value; // تخزين الكائن المختار كاملاً
                  });
                },
              ),
              const SizedBox(height: 12),
              _buildLabel('Description'),
              CustomTextField(hint: 'Describe your product...', maxLines: 4, controller: descriptionController),
              const SizedBox(height: 30),
              _buildActionButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets Helpers لتقليل تكرار الكود وتنظيفه ---

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.brown));
  }

  Widget _buildNumericField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        CustomTextField(hint: hint, controller: controller, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF3EEE7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.brown.shade200),
        ),
        child: _selectedImage == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.upload_outlined, size: 30, color: Colors.brown),
            SizedBox(height: 6),
            Text('Upload Photo', style: TextStyle(color: Colors.brown)),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(_selectedImage!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.brown.shade300),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.brown)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _isLoading ? null : _addProduct,
            child: _isLoading
                ? const SizedBox(height: 20, width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Add Product', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/addprodect_screen/widget/input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/model/creatprodect_model.dart';

import '../../../manager/prodect_apiservice.dart';
import '../Editprodect_screen/editprodect.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedImagePath;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final ProductApiService _apiService = ProductApiService();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        selectedImagePath = image.path;
      });
    }
  }

  Future<void> _addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final product = ProductModel(
        imagePath: selectedImagePath,
        name: nameController.text,
        price: priceController.text,
        stock: stockController.text,
        category: categoryController.text,
        description: descriptionController.text,
      );

      final createdProduct = await _apiService.createProduct(product);

      setState(() {
        _isLoading = false;
      });

      if (createdProduct != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully! ✅')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EditProductScreen(product: createdProduct),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add product ❌')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                'Product Image',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EEE7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.brown.shade200),
                  ),
                  child: _selectedImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.upload_outlined,
                          size: 30, color: Colors.brown),
                      SizedBox(height: 6),
                      Text('Upload Photo',
                          style: TextStyle(color: Colors.brown)),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Product Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                hint: 'Enter product name',
                controller: nameController,
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price (\$)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hint: '0.00',
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Stock',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hint: '0',
                          controller: stockController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                'Category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                controller: categoryController,
              ),

              const SizedBox(height: 12),

              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                hint: 'Describe your product...',
                maxLines: 4,
                controller: descriptionController,
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.brown.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _isLoading ? null : _addProduct,
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Add Product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
*/