import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaDestinationGalleryView extends StatefulWidget {
  const TtaDestinationGalleryView({super.key});

  @override
  State<TtaDestinationGalleryView> createState() => _TtaDestinationGalleryViewState();
}

class _TtaDestinationGalleryViewState extends State<TtaDestinationGalleryView> {
  String selectedCategory = "All";
  
  final List<String> categories = [
    "All",
    "Nature",
    "Cultural",
    "Adventure",
    "Beach",
    "Mountains",
    "Cities"
  ];

  final List<Map<String, dynamic>> galleryImages = [
    {
      "id": 1,
      "title": "Bali Temple",
      "category": "Cultural",
      "image": "https://picsum.photos/400/300?random=1&keyword=temple",
      "location": "Bali, Indonesia",
      "likes": 234,
      "isLiked": false,
    },
    {
      "id": 2,
      "title": "Mount Fuji",
      "category": "Mountains",
      "image": "https://picsum.photos/400/300?random=2&keyword=mountain",
      "location": "Japan",
      "likes": 567,
      "isLiked": true,
    },
    {
      "id": 3,
      "title": "Maldives Beach",
      "category": "Beach",
      "image": "https://picsum.photos/400/300?random=3&keyword=beach",
      "location": "Maldives",
      "likes": 890,
      "isLiked": false,
    },
    {
      "id": 4,
      "title": "Safari Adventure",
      "category": "Adventure",
      "image": "https://picsum.photos/400/300?random=4&keyword=safari",
      "location": "Kenya",
      "likes": 345,
      "isLiked": true,
    },
    {
      "id": 5,
      "title": "Amazon Rainforest",
      "category": "Nature",
      "image": "https://picsum.photos/400/300?random=5&keyword=forest",
      "location": "Brazil",
      "likes": 456,
      "isLiked": false,
    },
    {
      "id": 6,
      "title": "Paris City",
      "category": "Cities",
      "image": "https://picsum.photos/400/300?random=6&keyword=city",
      "location": "France",
      "likes": 678,
      "isLiked": true,
    },
    {
      "id": 7,
      "title": "Swiss Alps",
      "category": "Mountains",
      "image": "https://picsum.photos/400/300?random=7&keyword=alps",
      "location": "Switzerland",
      "likes": 789,
      "isLiked": false,
    },
    {
      "id": 8,
      "title": "Thai Temple",
      "category": "Cultural",
      "image": "https://picsum.photos/400/300?random=8&keyword=thailand",
      "location": "Thailand",
      "likes": 432,
      "isLiked": true,
    },
  ];

  List<Map<String, dynamic>> get filteredImages {
    if (selectedCategory == "All") {
      return galleryImages;
    }
    return galleryImages.where((image) => image["category"] == selectedCategory).toList();
  }

  void toggleLike(int imageId) {
    setState(() {
      final imageIndex = galleryImages.indexWhere((image) => image["id"] == imageId);
      if (imageIndex != -1) {
        galleryImages[imageIndex]["isLiked"] = !galleryImages[imageIndex]["isLiked"];
        if (galleryImages[imageIndex]["isLiked"]) {
          galleryImages[imageIndex]["likes"] = (galleryImages[imageIndex]["likes"] as int) + 1;
        } else {
          galleryImages[imageIndex]["likes"] = (galleryImages[imageIndex]["likes"] as int) - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destination Gallery"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Gallery Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredImages.map((image) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Stack(
                        children: [
                          // Image
                          AspectRatio(
                            aspectRatio: 4/3,
                            child: Image.network(
                              "${image["image"]}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          // Gradient Overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Like Button
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => toggleLike(image["id"] as int),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  image["isLiked"] ? Icons.favorite : Icons.favorite_border,
                                  color: image["isLiked"] ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),

                          // Image Info
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${image["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${image["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white.withValues(alpha: 0.9),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: dangerColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${image["likes"]} likes",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withValues(alpha: 0.9),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${image["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
