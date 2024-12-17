import 'package:flutter/material.dart';

class LeafCard extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final String? status;
  final String? date;

  const LeafCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.status,
      required this.date});

  @override
  State<LeafCard> createState() => _LeafCardState();
}

class _LeafCardState extends State<LeafCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 8,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            // color: Colors.grey[300],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              // Image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.network(
                  height: 280,
                  widget.imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/not-found.png',
                      height: 280,
                    );
                  },
                ),
              ),

              // Mask grey
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              // Text Information
              Positioned(
                left: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.status!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.date!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
