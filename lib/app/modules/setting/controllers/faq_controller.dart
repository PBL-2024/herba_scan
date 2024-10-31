import 'package:get/get.dart';
import 'package:herba_scan/app/data/faq_item.dart';
import 'package:herba_scan/app/modules/setting/providers/faq_provider.dart';

import '../../../data/models/faq.dart';

class FaqController extends GetxController {
  final RxList<FAQItem> faqItems = <FAQItem>[].obs;
  final _faqProvider = Get.put(FaqProvider());
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getFaqs();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getFaqs() async {
    try {
      final response = await _faqProvider.getFaqs();
      final data = FaqResponse.fromJson(response.body);
      // insert data to faqItems
      faqItems.value = data.data
          .map((faq) => FAQItem(title: faq.title, content: faq.content))
          .toList();
    } catch (e) {
      Get.snackbar(
          'Terjadi Kesalahan', 'Periksa koneksi internet anda dan coba lagi');
    } finally {
      isLoading.value = false;
    }
  }
}
