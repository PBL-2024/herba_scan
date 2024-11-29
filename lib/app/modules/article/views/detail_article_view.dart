import 'package:flutter/material.dart';

class ArticleDetailView extends StatefulWidget {
  final String title;
  final String content;
  final String imageUrl; // Add a field for the image URL

  const ArticleDetailView({
    Key? key,
    required this.title,
    required this.content,
    required this.imageUrl, // Include the image URL in the constructor
  }) : super(key: key);

  @override
  _ArticleDetailViewState createState() => _ArticleDetailViewState();
}

class _ArticleDetailViewState extends State<ArticleDetailView> {
  bool isLiked = false; // Track whether the article is liked
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> comments = [
    {
      'user': 'User 1',
      'time': '1 jam lalu',
      'comment': 'Lorem ipsum dolor amet, consectetur adipiscing elit.'
    },
    {
      'user': 'User 2',
      'time': '2 jam lalu',
      'comment': 'Sed do eiusmod tempor incididunt ut labore et dolore.'
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Method to handle sending a comment
  void _sendComment() {
    String commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      setState(() {
        comments.add({
          'user': 'You', // Static username for this example
          'time': 'Just now',
          'comment': commentText,
        });
        _commentController.clear(); // Clear the text field after sending
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F9E0), // Set background color
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F9E0), // AppBar background color
        title:
            const Text('Detail Artikel', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isLiked = !isLiked; // Toggle like state
              });
            },
            icon: Icon(
              isLiked
                  ? Icons.favorite
                  : Icons.favorite_border, // Change icon based on like status
              color: isLiked
                  ? Colors.red
                  : Colors.black, // Change color based on like status
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                        color: const Color(
                            0xFFCCEFCD), // Light green for image background
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget
                              .imageUrl, // Use the image URL passed from the article
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.visibility, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              '534', // Example view count
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                    Text(
                      widget.content,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Divider
              const Divider(color: Colors.grey, thickness: 1),
              // Comment Section
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
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
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendComment, // Handle sending comment
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Display comments
              for (var comment in comments)
                _buildCommentSection(
                  comment['user']!,
                  comment['time']!,
                  comment['comment']!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentSection(String username, String time, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Picture Placeholder
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Text(
              username[0], // First letter of the username
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
