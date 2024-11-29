import 'package:flutter/material.dart';

import 'package:get/get.dart';

// class FavoriteView extends GetView {
//   const FavoriteView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FavoriteView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'FavoriteView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk artikel
    final List<Map<String, String>> articles = [
      {
        "title": "Daun Kemangi Bisa Buat Kaya...",
        "image": "assets/basil_leaf.png"
      },
      {
        "title": "Daun Kemangi Bisa Buat Kaya...",
        "image": "assets/aloe_vera.png"
      },
      {
        "title": "Daun Kemangi Bisa Buat Kaya...",
        "image": "assets/papaya_leaf.png"
      },
      {
        "title": "Daun Kemangi Bisa Buat Kaya...",
        "image": "assets/aloe_vera.png"
      },
      {
        "title": "Daun Kemangi Bisa Buat Kaya...",
        "image": "assets/papaya_leaf.png"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         CircleAvatar(
            //           radius: 24,
            //           backgroundColor: Colors.green.shade200,
            //           child: Icon(Icons.person, color: Colors.white),
            //         ),
            //         const SizedBox(width: 8),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: const [
            //             Text(
            //               "Hai!",
            //               style: TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Text(
            //               "Selamat pagi",
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Colors.green.shade200,
            //       ),
            //       child: const Icon(Icons.qr_code, color: Colors.white),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 24),

            // Tab Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton("Beranda", false, context, null),
                _buildTabButton("Riwayat", false, context, null),
                _buildTabButton("Favorit", true, context, null),
              ],
            ),
            const SizedBox(height: 24),

            // List Artikel
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: index == 3
                          ? Border.all(color: Colors.blue, width: 2)
                          : null, // Highlight untuk item ke-4
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          article["image"]!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article["title"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Daun kemangi bisa buat kaya lho karena dugaan...",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
    String label,
    bool isActive,
    BuildContext context,
    Widget? targetPage,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (targetPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade200 : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: isActive ? null : Border.all(color: Colors.green.shade200),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
