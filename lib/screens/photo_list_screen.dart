import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mod11_assignment/photo.dart';
import 'package:mod11_assignment/screens/photo_detail_screen.dart';
import 'package:http/http.dart' as http;


class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<Photo> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Photo> loadedPhotos = [];
      data.forEach((item) {
        loadedPhotos.add(Photo.fromJson(item));
      });
      setState(() {
        photos = loadedPhotos;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo List'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(photos[index].title),
                  leading: Image.network(photos[index].thumbnailUrl),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoDetailScreen(photo: photos[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
