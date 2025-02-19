import 'package:flutter/material.dart';

class EventImage extends StatelessWidget {
  final String imageUrl;
  final String title;

  const EventImage({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 6.0,
                  color: Colors.black54,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
