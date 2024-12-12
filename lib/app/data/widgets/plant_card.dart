import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PlantCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap; // Fungsi navigasi sebagai parameter

  const PlantCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap, // Menerima fungsi navigasi
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Memanggil fungsi navigasi saat card ditekan
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePath.startsWith('http')
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(width: 12.0),
            // Info Tanaman
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    constraints: BoxConstraints(maxHeight: 50),
                    // Adjust the height as needed
                    child: HtmlWidget(
                      description,
                      textStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
