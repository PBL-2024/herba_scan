import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ArticleController extends GetxController {
  var articles = <Map<String, String>>[].obs;
  var isLoading = true.obs;
  var selectedImage = Rxn<File>();
  var articleTitle = ''.obs;
  var articleDescription = ''.obs;
  var selectedFilter = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  // Fetch articles data (simulate or connect to API)
  void fetchArticles() async {
    try {
      isLoading(true);
      // Simulate data fetching delay
      await Future.delayed(Duration(seconds: 1));

      // Assigning fetched articles data
      articles.assignAll([
        {
          "title": "Daun Kemangi Bisa Buat Kaya Lho...",
          "description": "Daun Kemangi kaya manfaat...",
          "imageUrl": "assets/images/kemangi.png",
        },
        {
          "title": "Aloe Vera untuk Kesehatan Kulit...",
          "description": "Aloe Vera memberikan banyak manfaat...",
          "imageUrl": "assets/images/aloe_vera.png",
        }
      ]);
    } catch (error) {
      // Log or show error messages if necessary
      print("Error fetching articles: $error");
    } finally {
      isLoading(false);
    }
  }

  // Image picker function
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage(File(pickedFile.path));
    }
  }

  // Submit new article
  void submitArticle() {
    if (articleTitle.isNotEmpty &&
        articleDescription.isNotEmpty &&
        selectedImage.value != null) {
      articles.add({
        "title": articleTitle.value,
        "description": articleDescription.value,
        "imageUrl": selectedImage.value!.path,
      });

      // Reset form fields after submission
      resetForm();
    } else {
      // Log error or show validation feedback if necessary
      print("Please fill all fields and select an image.");
    }
  }

  // Reset form fields
  void resetForm() {
    articleTitle.value = '';
    articleDescription.value = '';
    selectedImage.value = null;
  }
}
