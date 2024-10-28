import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ArticleController extends GetxController {
  var articles = <Map<String, String>>[].obs;
  var isLoading = true.obs;
  var selectedImage = Rxn<File>();
  var articleTitle = ''.obs;
  var articleDescription = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      // Simulasi data artikel (atau bisa ambil dari provider)
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
    } finally {
      isLoading(false);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage(File(pickedFile.path));
    }
  }

  void submitArticle() {
    if (articleTitle.isNotEmpty && articleDescription.isNotEmpty && selectedImage.value != null) {
      // Tambahkan artikel baru ke dalam daftar
      articles.add({
        "title": articleTitle.value,
        "description": articleDescription.value,
        "imageUrl": selectedImage.value!.path, // Path gambar yang dipilih
      });

      // Reset form setelah submit
      selectedImage.value = null;
      articleTitle.value = '';
      articleDescription.value = '';
    }
  }
}
