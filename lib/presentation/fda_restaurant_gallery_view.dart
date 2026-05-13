import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRestaurantGalleryView extends StatefulWidget {
  const FdaRestaurantGalleryView({super.key});

  @override
  State<FdaRestaurantGalleryView> createState() => _FdaRestaurantGalleryViewState();
}

class _FdaRestaurantGalleryViewState extends State<FdaRestaurantGalleryView> {
  String selectedCategory = "All";
  bool isGridView = true;

  List<Map<String, dynamic>> galleryCategories = [
    {"label": "All", "count": 48},
    {"label": "Food", "count": 24},
    {"label": "Interior", "count": 12},
    {"label": "Kitchen", "count": 8},
    {"label": "Events", "count": 4},
  ];

  List<Map<String, dynamic>> galleryImages = [
    {
      "id": 1,
      "url": "https://picsum.photos/400/300?random=1&keyword=gourmet+food",
      "category": "Food",
      "title": "Signature Wagyu Steak",
      "description": "Premium wagyu beef cooked to perfection with seasonal vegetables",
      "uploadDate": "2024-01-15",
      "likes": 245,
      "isLiked": false
    },
    {
      "id": 2,
      "url": "https://picsum.photos/400/300?random=2&keyword=restaurant+interior",
      "category": "Interior",
      "title": "Main Dining Room",
      "description": "Elegant dining space with panoramic city views",
      "uploadDate": "2024-01-12",
      "likes": 189,
      "isLiked": true
    },
    {
      "id": 3,
      "url": "https://picsum.photos/400/300?random=3&keyword=chef+kitchen",
      "category": "Kitchen",
      "title": "Open Kitchen",
      "description": "Watch our chefs create culinary masterpieces",
      "uploadDate": "2024-01-10",
      "likes": 167,
      "isLiked": false
    },
    {
      "id": 4,
      "url": "https://picsum.photos/400/300?random=4&keyword=fine+dining",
      "category": "Food",
      "title": "Tasting Menu Course",
      "description": "Seven-course tasting menu with wine pairing",
      "uploadDate": "2024-01-08",
      "likes": 312,
      "isLiked": true
    },
    {
      "id": 5,
      "url": "https://picsum.photos/400/300?random=5&keyword=private+dining",
      "category": "Interior",
      "title": "Private Dining Room",
      "description": "Intimate space for special occasions",
      "uploadDate": "2024-01-05",
      "likes": 98,
      "isLiked": false
    },
    {
      "id": 6,
      "url": "https://picsum.photos/400/300?random=6&keyword=dessert",
      "category": "Food",
      "title": "Chocolate Soufflé",
      "description": "Decadent chocolate soufflé with vanilla ice cream",
      "uploadDate": "2024-01-03",
      "likes": 276,
      "isLiked": false
    },
    {
      "id": 7,
      "url": "https://picsum.photos/400/300?random=7&keyword=wine+cellar",
      "category": "Interior",
      "title": "Wine Cellar",
      "description": "Temperature-controlled wine storage with rare vintages",
      "uploadDate": "2024-01-01",
      "likes": 134,
      "isLiked": true
    },
    {
      "id": 8,
      "url": "https://picsum.photos/400/300?random=8&keyword=event+dining",
      "category": "Events",
      "title": "Wedding Reception",
      "description": "Beautiful wedding celebration in our main hall",
      "uploadDate": "2023-12-28",
      "likes": 425,
      "isLiked": false
    },
    {
      "id": 9,
      "url": "https://picsum.photos/400/300?random=9&keyword=appetizer",
      "category": "Food",
      "title": "Seafood Platter",
      "description": "Fresh oysters, lobster, and seasonal seafood",
      "uploadDate": "2023-12-25",
      "likes": 198,
      "isLiked": true
    },
    {
      "id": 10,
      "url": "https://picsum.photos/400/300?random=10&keyword=bar+area",
      "category": "Interior",
      "title": "Cocktail Bar",
      "description": "Craft cocktails and premium spirits",
      "uploadDate": "2023-12-22",
      "likes": 156,
      "isLiked": false
    },
    {
      "id": 11,
      "url": "https://picsum.photos/400/300?random=11&keyword=chef+preparing",
      "category": "Kitchen",
      "title": "Chef at Work",
      "description": "Executive chef preparing the evening menu",
      "uploadDate": "2023-12-20",
      "likes": 203,
      "isLiked": false
    },
    {
      "id": 12,
      "url": "https://picsum.photos/400/300?random=12&keyword=terrace+dining",
      "category": "Interior",
      "title": "Outdoor Terrace",
      "description": "Al fresco dining with garden views",
      "uploadDate": "2023-12-18",
      "likes": 289,
      "isLiked": true
    },
  ];

  List<Map<String, dynamic>> get filteredImages {
    if (selectedCategory == "All") {
      return galleryImages;
    }
    return galleryImages.where((image) => image["category"] == selectedCategory).toList();
  }

  void toggleLike(int imageId) {
    int index = galleryImages.indexWhere((image) => image["id"] == imageId);
    if (index != -1) {
      galleryImages[index]["isLiked"] = !galleryImages[index]["isLiked"];
      if (galleryImages[index]["isLiked"]) {
        galleryImages[index]["likes"]++;
      } else {
        galleryImages[index]["likes"]--;
      }
      setState(() {});
    }  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Gallery"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share gallery
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Gallery Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${galleryImages.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Photos",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${galleryImages.map((img) => img["likes"] as int).reduce((a, b) => a + b)}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Total Likes",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${galleryCategories.length - 1}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Filter by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QHorizontalScroll(
                    children: galleryCategories.map((category) => Container(
                      margin: EdgeInsets.only(right: spSm),
                      child: GestureDetector(
                        onTap: () {
                          selectedCategory = category["label"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: selectedCategory == category["label"]
                                ? primaryColor
                                : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${category["label"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: selectedCategory == category["label"]
                                      ? Colors.white
                                      : disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCategory == category["label"]
                                      ? Colors.white.withAlpha(50)
                                      : disabledBoldColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${category["count"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: selectedCategory == category["label"]
                                        ? Colors.white
                                        : disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Gallery Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredImages.map((image) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with overlay
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${image["url"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // Category Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
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
                        ),

                        // Like Button
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: GestureDetector(
                            onTap: () => toggleLike(image["id"]),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(100),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                image["isLiked"] ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: image["isLiked"] ? dangerColor : Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // View Full Size Button
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: GestureDetector(
                            onTap: () {
                              // Open full size image
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(100),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.fullscreen,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Image Details
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${image["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${image["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite, size: 12, color: dangerColor),
                              SizedBox(width: spXs),
                              Text(
                                "${image["likes"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse(image["uploadDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
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
              )).toList(),
            ),

            // Load More Button
            QButton(
              label: "Load More Photos",
              size: bs.md,
              onPressed: () {
                // Load more images
              },
            ),
          ],
        ),
      ),
    );
  }
}
