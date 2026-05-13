import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery2View extends StatefulWidget {
  @override
  State<GrlGallery2View> createState() => _GrlGallery2ViewState();
}

class _GrlGallery2ViewState extends State<GrlGallery2View> {
  String searchQuery = "";
  bool loading = false;
  int selectedImageIndex = 0;

  final List<Map<String, dynamic>> images = [
    {
      "id": 1,
      "title": "Sunset Beach",
      "url": "https://picsum.photos/800/600?random=10&keyword=sunset",
      "description": "Beautiful sunset at the beach with golden hour lighting",
      "tags": ["sunset", "beach", "golden", "nature"],
      "views": 1420,
      "downloads": 89,
      "date": "2024-01-20"
    },
    {
      "id": 2,
      "title": "Urban Night",
      "url": "https://picsum.photos/800/600?random=11&keyword=city",
      "description": "Vibrant city lights illuminating the night sky",
      "tags": ["city", "night", "lights", "urban"],
      "views": 2156,
      "downloads": 156,
      "date": "2024-01-19"
    },
    {
      "id": 3,
      "title": "Forest Path",
      "url": "https://picsum.photos/800/600?random=12&keyword=forest",
      "description": "Peaceful walking path through lush green forest",
      "tags": ["forest", "path", "nature", "green"],
      "views": 892,
      "downloads": 67,
      "date": "2024-01-18"
    },
    {
      "id": 4,
      "title": "Mountain Peak",
      "url": "https://picsum.photos/800/600?random=13&keyword=mountain",
      "description": "Majestic mountain peak covered in morning mist",
      "tags": ["mountain", "peak", "mist", "landscape"],
      "views": 3421,
      "downloads": 234,
      "date": "2024-01-17"
    },
    {
      "id": 5,
      "title": "Ocean Waves",
      "url": "https://picsum.photos/800/600?random=14&keyword=ocean",
      "description": "Powerful ocean waves crashing against the shore",
      "tags": ["ocean", "waves", "water", "power"],
      "views": 1876,
      "downloads": 112,
      "date": "2024-01-16"
    },
    {
      "id": 6,
      "title": "Desert Dunes",
      "url": "https://picsum.photos/800/600?random=15&keyword=desert",
      "description": "Endless sand dunes under clear blue sky",
      "tags": ["desert", "sand", "dunes", "sky"],
      "views": 1234,
      "downloads": 78,
      "date": "2024-01-15"
    },
  ];

  List<Map<String, dynamic>> get filteredImages {
    if (searchQuery.isEmpty) return images;
    return images.where((img) {
      final title = (img["title"] as String).toLowerCase();
      final description = (img["description"] as String).toLowerCase();
      final tags = (img["tags"] as List).join(" ").toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) || description.contains(query) || tags.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Viewer"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Share feature coming soon!");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Image downloaded!");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Section
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Images",
                          value: searchQuery,
                          hint: "Search by title, description, or tags...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.filter_list,
                        size: bs.sm,
                        onPressed: () {
                          si("Filter options coming soon!");
                        },
                      ),
                    ],
                  ),

                  // Main Image Display
                  if (filteredImages.isNotEmpty)
                    Column(
                      spacing: spMd,
                      children: [
                        // Large Image Preview
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${filteredImages[selectedImageIndex]["url"]}",
                                  width: double.infinity,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                                
                                // Navigation Arrows
                                if (filteredImages.length > 1) ...[
                                  Positioned(
                                    left: spSm,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedImageIndex > 0) {
                                            selectedImageIndex--;
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            borderRadius: BorderRadius.circular(radiusLg),
                                          ),
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  Positioned(
                                    right: spSm,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedImageIndex < filteredImages.length - 1) {
                                            selectedImageIndex++;
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(spSm),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            borderRadius: BorderRadius.circular(radiusLg),
                                          ),
                                          child: Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                // Image Counter
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${selectedImageIndex + 1}/${filteredImages.length}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Image Info
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            spacing: spSm,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${filteredImages[selectedImageIndex]["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH5,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${filteredImages[selectedImageIndex]["date"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Text(
                                "${filteredImages[selectedImageIndex]["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),

                              // Tags
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (filteredImages[selectedImageIndex]["tags"] as List).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "#${tag}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${filteredImages[selectedImageIndex]["views"]} views",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.download,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${filteredImages[selectedImageIndex]["downloads"]} downloads",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  // Thumbnail Gallery
                  if (filteredImages.length > 1)
                    Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All Images",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        QHorizontalScroll(
                          children: List.generate(filteredImages.length, (index) {
                            final isSelected = index == selectedImageIndex;
                            return GestureDetector(
                              onTap: () {
                                selectedImageIndex = index;
                                setState(() {});
                              },
                              child: Container(
                                width: 100,
                                height: 80,
                                margin: EdgeInsets.only(
                                  right: index < filteredImages.length - 1 ? spSm : 0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: isSelected ? [shadowSm] : [],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${filteredImages[index]["url"]}",
                                    width: 100,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),

                  // Action Buttons
                  if (filteredImages.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add to Favorites",
                            icon: Icons.favorite_border,
                            size: bs.md,
                            onPressed: () {
                              ss("Added to favorites!");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Download HD",
                            icon: Icons.download,
                            size: bs.md,
                            onPressed: () {
                              sw("HD download requires premium!");
                            },
                          ),
                        ),
                      ],
                    ),

                  // No Results
                  if (filteredImages.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        spacing: spMd,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: disabledColor,
                          ),
                          Text(
                            "No images found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search terms",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
