import 'package:flutter/material.dart';
import 'detail_article_view.dart'; // Pastikan untuk mengimpor halaman detail artikel

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  // Contoh data artikel dengan masing-masing kategori memiliki 5 artikel
  final List<Map<String, String>> articles = [
    // Artikel kategori 'terbaru'
    {
      'title': 'Daun Kemangi Bisa Buat Kaya...',
      'content':
          'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet.',
      'category': 'terbaru',
      'imageUrl': 'images/kemangi.jpg',
    },
    {
      'title': 'Manfaat Teh Hijau',
      'content': 'Vivamus lacinia odio vitae vestibulum.',
      'category': 'terbaru',
      'imageUrl': 'images/teh_hijau.png',
    },
    {
      'title': 'Mengelola Stres untuk Kesehatan',
      'content': 'Curabitur gravida arcu ac tortor.',
      'category': 'terbaru',
      'imageUrl': 'images/Stres.png',
    },
    {
      'title': 'Cara Meningkatkan Imunitas',
      'content': 'Sed do eiusmod tempor incididunt ut labore.',
      'category': 'terbaru',
      'imageUrl': 'images/imunitas.jpg',
    },
    {
      'title': 'Pola Makan Sehat',
      'content': 'Ut enim ad minim veniam.',
      'category': 'terbaru',
      'imageUrl': 'images/makanan_sehat.jpg',
    },

    // Artikel kategori 'populer'
    {
      'title': 'Olahraga untuk Kebugaran',
      'content': 'Consectetur adipiscing elit.',
      'category': 'populer',
      'imageUrl': 'images/olahraga.jpg',
    },
    {
      'title': 'Manfaat Yoga',
      'content': 'Praesent tristique magna.',
      'category': 'populer',
      'imageUrl': 'images/yoga.jpg',
    },
    {
      'title': 'Cara Tidur Nyenyak',
      'content': 'Phasellus egestas tellus rutrum.',
      'category': 'populer',
      'imageUrl': 'images/Tidur-Nyenyak.jpg',
    },
    {
      'title': 'Efek Meditasi pada Kesehatan Mental',
      'content': 'Suspendisse potenti.',
      'category': 'populer',
      'imageUrl': 'images/meditasi.jpg',
    },
    {
      'title': 'Diet Seimbang',
      'content': 'Maecenas sed enim ut sem.',
      'category': 'populer',
      'imageUrl': 'images/diet.jpg',
    },

    // Artikel kategori 'paling lama'
    {
      'title': 'Cara Mengatasi Insomnia',
      'content': 'Integer nec odio.',
      'category': 'paling lama',
      'imageUrl': 'images/insomnia.jpg',
    },
    {
      'title': 'Panduan Hidup Sehat',
      'content': 'Vestibulum ante ipsum primis.',
      'category': 'paling lama',
      'imageUrl': 'images/hidup_sehat.jpg',
    },
    {
      'title': 'Menjaga Kesehatan Mental',
      'content': 'Aenean euismod elementum nisi.',
      'category': 'paling lama',
      'imageUrl': 'images/mental_health.jpeg',
    },
    {
      'title': 'Pengaruh Makanan pada Mood',
      'content': 'Pellentesque eget nunc.',
      'category': 'paling lama',
      'imageUrl': 'images/makanan_mood.jpg',
    },
    {
      'title': 'Kebiasaan Baik di Pagi Hari',
      'content': 'Fusce ac felis sit amet.',
      'category': 'paling lama',
      'imageUrl': 'images/kebiasaan_pagi.jpg',
    },
  ];

  String selectedFilter = 'terbaru'; // Set default filter to 'terbaru'
  String searchKeyword = ''; // Variabel untuk kata kunci pencarian

  // Fungsi untuk mendapatkan artikel yang difilter
  List<Map<String, String>> get filteredArticles {
    return articles
        .where((article) =>
            article['category'] == selectedFilter &&
            article['title']!
                .toLowerCase()
                .contains(searchKeyword.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Artikel Kesehatan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchKeyword = value; // Set kata kunci pencarian
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari artikel...',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'terbaru';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedFilter == 'terbaru'
                          ? Colors.green
                          : const Color.fromARGB(255, 213, 213, 213),
                    ),
                    child: Text(
                      'Terbaru',
                      style: TextStyle(
                        color: selectedFilter == 'terbaru'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'populer';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedFilter == 'populer'
                          ? Colors.green
                          : const Color.fromARGB(255, 213, 213, 213),
                    ),
                    child: Text(
                      'Populer',
                      style: TextStyle(
                        color: selectedFilter == 'populer'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedFilter = 'paling lama';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedFilter == 'paling lama'
                          ? Colors.green
                          : const Color.fromARGB(255, 213, 213, 213),
                    ),
                    child: Text(
                      'Paling Lama',
                      style: TextStyle(
                        color: selectedFilter == 'paling lama'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredArticles.length,
                itemBuilder: (context, index) {
                  final article = filteredArticles[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: const Color(0xFFE7F9E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailView(
                              title: article['title']!,
                              content: article['content']!,
                              imageUrl: article['imageUrl']!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              article['imageUrl']!,
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['title']!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  article['content']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
