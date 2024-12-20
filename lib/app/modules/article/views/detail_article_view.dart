import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:herba_scan/app/data/models/response_article_comment.dart';
import 'package:herba_scan/app/data/widgets/reusable_app_bar.dart';
import 'package:herba_scan/app/modules/article/controllers/article_controllers.dart';

class ArticleDetailView extends GetView<ArticleController> {
  const ArticleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['id'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getArticleById(id!);
      controller.isFavoriteArticle(id);
      controller.fetchComments(id);
    });
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          controller.commentController.clear();
          controller.comments.clear();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE7F9E0), // Set background color
        appBar: ReusableAppBar(
          onPressed: () {
            Get.back();
          },
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.shareArticle(controller.selectedArticle.value);
              },
              icon: const Icon(Icons.share),
            ),
            IconButton(
              onPressed: () {
                controller.addFavoriteArticle(id!);
              },
              icon: Obx(
                () => Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  // Change icon based on like status
                  color: controller.isFavorite.value
                      ? Colors.red
                      : Colors.black, // Change color based on like status
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return _buildSkeleton();
            } else if (controller.selectedArticle.value.id != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article Header with Image from assets
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Load the image from assets
                            Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  controller.selectedArticle.value.coverUrl!,
                                  // Use the image URL passed from the article
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: [
                                AutoSizeText(
                                  controller.selectedArticle.value.judul!,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.remove_red_eye,
                                        color: Colors.grey, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.selectedArticle.value.totalView
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Article Content
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Isi Artikel',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            HtmlWidget(
                              controller.selectedArticle.value.isi!,
                              textStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Divider
                      const Divider(
                        color: Colors.grey,
                        thickness: 3,
                        indent: 100,
                        endIndent: 100,
                      ),
                      // Comment Section
                      const SizedBox(height: 16.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.commentController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Tulis komentar...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 48,
                                width: 48,
                                child: controller.sendCommentLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.0,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          controller.sendComment(
                                              id!,
                                              controller
                                                  .commentController.text);
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Display comments
                      ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) {
                          return _buildCommentSection(
                              controller.comments[index]);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return _emptyArticle();
            }
          },
        ),
      ),
    );
  }

  Widget _emptyArticle() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/not-found.png'),
          const SizedBox(height: 16),
          const Text(
            "Artikel tidak ditemukan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection(Comment comment) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onLongPress: comment.myComment!
          ? () {
              controller.showDialogDeleteComment(
                  controller.selectedArticle.value.id.toString(),
                  comment.id.toString());
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: comment.user?.imageUrl != null
                      ? NetworkImage(comment.user!.imageUrl!)
                      : null,
                  backgroundColor: Colors.transparent,
                  child: comment.user?.imageUrl == null
                      ? Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.person))
                      : null,
                ),
                const SizedBox(width: 8.0),
                // Comment Content
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 100.w),
                        child: Text(
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          comment.user!.name!,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600)
                                  .fontFamily),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            controller.formatDate(comment.createdAt!),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              comment.komentar!,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
