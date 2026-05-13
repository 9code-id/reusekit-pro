import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery10View extends StatefulWidget {
  @override
  State<GrlGallery10View> createState() => _GrlGallery10ViewState();
}

class _GrlGallery10ViewState extends State<GrlGallery10View> {
  int currentTab = 0;
  bool loading = false;

  final List<Map<String, dynamic>> collections = [
    {
      "id": 1,
      "title": "Nature's Beauty",
      "description": "Stunning landscapes and natural wonders",
      "count": 45,
      "cover": "https://picsum.photos/400/300?random=120&keyword=nature",
      "created": "2024-01-15",
      "isPublic": true,
    },
    {
      "id": 2,
      "title": "Urban Life",
      "description": "City scenes and street photography",
      "count": 32,
      "cover": "https://picsum.photos/400/300?random=121&keyword=city",
      "created": "2024-01-10",
      "isPublic": false,
    },
    {
      "id": 3,
      "title": "Portraits",
      "description": "Professional portrait photography",
      "count": 28,
      "cover": "https://picsum.photos/400/300?random=122&keyword=portrait",
      "created": "2024-01-05",
      "isPublic": true,
    },
  ];

  final List<Map<String, dynamic>> favorites = [
    {
      "id": 1,
      "title": "Golden Hour",
      "url": "https://picsum.photos/400/500?random=123&keyword=golden",
      "author": "Alex Thompson",
      "dateAdded": "2024-01-20",
      "category": "Landscape"
    },
    {
      "id": 2,
      "title": "Street Art",
      "url": "https://picsum.photos/300/400?random=124&keyword=art",
      "author": "Maria Santos",
      "dateAdded": "2024-01-19",
      "category": "Urban"
    },
    {
      "id": 3,
      "title": "Ocean Waves",
      "url": "https://picsum.photos/400/400?random=125&keyword=ocean",
      "author": "David Chen",
      "dateAdded": "2024-01-18",
      "category": "Nature"
    },
    {
      "id": 4,
      "title": "Architecture",
      "url": "https://picsum.photos/400/600?random=126&keyword=building",
      "author": "Sarah Wilson",
      "dateAdded": "2024-01-17",
      "category": "Architecture"
    },
  ];

  final List<Map<String, dynamic>> recentlyViewed = [
    {
      "id": 1,
      "title": "Mountain Peak",
      "url": "https://picsum.photos/400/500?random=127&keyword=mountain",
      "viewedAt": "2 hours ago",
      "duration": "00:45"
    },
    {
      "id": 2,
      "title": "Forest Path",
      "url": "https://picsum.photos/400/400?random=128&keyword=forest",
      "viewedAt": "1 day ago",
      "duration": "01:23"
    },
    {
      "id": 3,
      "title": "City Lights",
      "url": "https://picsum.photos/400/600?random=129&keyword=lights",
      "viewedAt": "2 days ago",
      "duration": "02:15"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "My Gallery",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Collections", icon: Icon(Icons.photo_library)),
        Tab(text: "Favorites", icon: Icon(Icons.favorite)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        // Collections Tab
        _buildCollectionsTab(),
        
        // Favorites Tab
        _buildFavoritesTab(),
        
        // Recent Tab
        _buildRecentTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildCollectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Collections",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Organize your photos into custom collections",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // navigateTo(CreateCollectionView());
                },
              ),
            ],
          ),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${collections.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Collections",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${collections.fold(0, (sum, collection) => sum + (collection["count"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
              ),
            ],
          ),

          // Collections List
          ...collections.map((collection) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Collection Cover
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusLg),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusLg),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${collection["cover"]}",
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),

                          // Privacy Badge
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: collection["isPublic"] == true 
                                    ? successColor 
                                    : warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    collection["isPublic"] == true 
                                        ? Icons.public 
                                        : Icons.lock,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    collection["isPublic"] == true ? "PUBLIC" : "PRIVATE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Photo Count
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${collection["count"]} photos",
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

                  // Collection Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${collection["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "Created ${collection["created"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "${collection["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),

                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Collection",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(CollectionDetailView(collection: collection));
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {
                                si("Edit collection feature coming soon!");
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                if (collection["isPublic"] == true) {
                                  ss("Collection link copied!");
                                } else {
                                  sw("Make collection public to share");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Create Collection Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: primaryColor.withAlpha(30),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color: primaryColor,
                ),
                Text(
                  "Create New Collection",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Organize your photos into themed collections",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Get Started",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(CreateCollectionView());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Favorite Photos",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  si("Clear all favorites feature coming soon!");
                },
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Photos you've liked and saved for later viewing",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Favorites Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: favorites.map((favorite) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Stack(
                    children: [
                      Image.network(
                        "${favorite["url"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),

                      // Gradient Overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(180),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Photo Info
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        right: spSm,
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${favorite["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "by ${favorite["author"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${favorite["dateAdded"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Favorite Button
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: GestureDetector(
                          onTap: () {
                            se("Removed from favorites!");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(200),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 18,
                              color: dangerColor,
                            ),
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
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${favorite["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Empty State (if no favorites)
          if (favorites.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXl),
              child: Column(
                spacing: spMd,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 60,
                    color: disabledColor,
                  ),
                  Text(
                    "No Favorites Yet",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Start exploring and tap the heart icon to save your favorite photos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                  QButton(
                    label: "Explore Gallery",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(ExploreView());
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Recently Viewed",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  bool isConfirmed = await confirm("Clear all viewing history?");
                  if (isConfirmed) {
                    ss("Viewing history cleared!");
                  }
                },
                child: Text(
                  "Clear History",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Photos and videos you've recently viewed",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Recent Items List
          ...recentlyViewed.map((item) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  // Thumbnail
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Stack(
                        children: [
                          Image.network(
                            "${item["url"]}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          if (item["duration"] != null)
                            Positioned(
                              bottom: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(180),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["duration"]}",
                                  style: TextStyle(
                                    fontSize: 10,
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

                  SizedBox(width: spMd),

                  // Item Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Viewed ${item["viewedAt"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions
                  Column(
                    spacing: spXs,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // navigateTo(PhotoDetailView(item: item));
                        },
                        child: Icon(
                          Icons.open_in_new,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Removed from history!");
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: dangerColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // View All History
          Center(
            child: QButton(
              label: "View Full History",
              size: bs.md,
              onPressed: () {
                // navigateTo(FullHistoryView());
              },
            ),
          ),

          // Privacy Note
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      size: 20,
                      color: infoColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Privacy Information",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Your viewing history is stored locally on your device and is not shared with others. You can clear it anytime.",
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
    );
  }
}
