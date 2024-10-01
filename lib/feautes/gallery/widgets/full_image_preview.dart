import 'package:flutter/material.dart';
import 'package:gallery_app/feautes/gallery/models/hit.dart';

class FullImagePreview extends StatelessWidget {
  final Hit hit;

  const FullImagePreview({super.key, required this.hit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: hit.id,
          child: ClipRRect(
            child: Image.network(
              hit.largeImageURL,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
