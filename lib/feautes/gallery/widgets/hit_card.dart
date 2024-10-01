import 'package:flutter/material.dart';
import 'package:gallery_app/feautes/gallery/models/hit.dart';
import 'package:gallery_app/feautes/gallery/widgets/full_image_preview.dart';

class HitCard extends StatelessWidget {
  final Hit hit;
  const HitCard({super.key, required this.hit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullImagePreview(hit: hit),
          ),
        );
      },
      child: Hero(
        tag: hit.largeImageURL,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    hit.largeImageURL,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.visibility, size: 16),
                        const SizedBox(width: 4),
                        Text(hit.views.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up, size: 16),
                        const SizedBox(width: 4),
                        Text(hit.likes.toString()),
                      ],
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
