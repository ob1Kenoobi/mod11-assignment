import 'package:flutter/material.dart';
import 'package:mod11_assignment/photo.dart';


class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(photo.url),
          const SizedBox(height: 16),
          Text('Title: ${photo.title}'),
          Text('ID: ${photo.id.toString()}'),
        ],
      ),
    );
  }
}
