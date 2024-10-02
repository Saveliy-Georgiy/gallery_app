import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery_app/feautes/gallery/models/hit.dart';
import 'package:gallery_app/feautes/gallery/services/index.dart';
import 'package:gallery_app/feautes/gallery/widgets/hit_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final PixabayService pixabayService = PixabayService();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  List<Hit> hits = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadMoreHits();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  Future<void> loadMoreHits() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newHits = await pixabayService.getHits(
        page: currentPage,
        searchQuery: searchQuery,
      );

      setState(() {
        hits.addAll(newHits);
        isLoading = false;
        hasMore = newHits.isNotEmpty;
        currentPage++;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreHits();
    }
  }

  void onSearchChanged(String value) {
    debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        hits.clear();
        currentPage = 1;
        hasMore = true;
        searchQuery = value;
      });
      loadMoreHits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search for images...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  int crossAxisCount;

                  if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.mobile) {
                    crossAxisCount = 1;
                  } else if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.tablet) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount = 5;
                  }

                  if (isLoading && hits.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: hits.length,
                    itemBuilder: (context, index) {
                      final hit = hits[index];
                      return HitCard(hit: hit);
                    },
                  );
                },
              ),
            ),
            if (isLoading && hits.isNotEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
