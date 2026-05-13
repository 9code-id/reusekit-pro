import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery3View extends StatefulWidget {
  @override
  State<GrlGallery3View> createState() => _GrlGallery3ViewState();
}

class _GrlGallery3ViewState extends State<GrlGallery3View> {
  int currentTab = 0;
  bool loading = false;

  final List<Map<String, dynamic>> albums = [
    {
      "id": 1,
      "title": "Travel Adventures",
      "description": "Breathtaking moments from around the world",
      "cover": "https://picsum.photos/400/300?random=20&keyword=travel",
      "count": 24,
      "images": [
        "https://picsum.photos/300/400?random=21&keyword=mountain",
        "https://picsum.photos/300/400?random=22&keyword=beach",
        "https://picsum.photos/300/400?random=23&keyword=city",
        "https://picsum.photos/300/400?random=24&keyword=forest",
      ]
    },
    {
      "id": 2,
      "title": "Street Photography",
      "description": "Urban life captured in candid moments",
      "cover": "https://picsum.photos/400/300?random=25&keyword=street",
      "count": 18,
      "images": [
        "https://picsum.photos/300/400?random=26&keyword=people",
        "https://picsum.photos/300/400?random=27&keyword=urban",
        "https://picsum.photos/300/400?random=28&keyword=architecture",
        "https://picsum.photos/300/400?random=29&keyword=night",
      ]
    },
    {
      "id": 3,
      "title": "Nature Collection",
      "description": "The beauty of natural landscapes",
      "cover": "https://picsum.photos/400/300?random=30&keyword=nature",
      "count": 32,
      "images": [
        "https://picsum.photos/300/400?random=31&keyword=flower",
        "https://picsum.photos/300/400?random=32&keyword=wildlife",
        "https://picsum.photos/300/400?random=33&keyword=sunset",
        "https://picsum.photos/300/400?random=34&keyword=water",
      ]
    },
  ];

  final List<Map<String, dynamic>> featured = [
    {
      "id": 1,
      "title": "Golden Hour Magic",
      "artist": "Alex Thompson",
      "url": "https://picsum.photos/600/400?random=35&keyword=golden",
      "likes": 1245,
      "featured": true
    },
    {
      "id": 2,
      "title": "Urban Reflections",
      "artist": "Sarah Mitchell",
      "url": "https://picsum.photos/600/400?random=36&keyword=reflection",
      "likes": 987,
      "featured": true
    },
    {
      "id": 3,
      "title": "Mountain Serenity",
      "artist": "David Chen",
      "url": "https://picsum.photos/600/400?random=37&keyword=mountain",
      "likes": 1876,
      "featured": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Photo Albums",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Albums", icon: Icon(Icons.photo_library)),
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        // Albums Tab
        _buildAlbumsTab(),
        
        // Featured Tab  
        _buildFeaturedTab(),
        
        // Recent Tab
        _buildRecentTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildAlbumsTab() {
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
                      "My Photo Albums",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Organize your memories in beautiful collections",
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
                  si("Create new album feature coming soon!");
                },
              ),
            ],
          ),

          // Albums Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: albums.map((album) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Album Cover
                    Container(
                      width: double.infinity,
                      height: 150,
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
                              "${album["cover"]}",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            
                            // Photo Count Badge
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
                                  "${album["count"]} photos",
                                  style: TextStyle(
                                    fontSize: 11,
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

                    // Album Info
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${album["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${album["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Preview Images
                          QHorizontalScroll(
                            children: (album["images"] as List).map((imageUrl) {
                              return Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: spXs),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: disabledColor,
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  child: Image.network(
                                    "$imageUrl",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Action Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Album",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(AlbumDetailView(album: album));
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: spSm),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Header
          Row(
            children: [
              Icon(
                Icons.star,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Featured Photography",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Text(
            "Discover exceptional photos selected by our community",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Featured Images
          ...featured.map((photo) {
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
                  // Image
                  Container(
                    width: double.infinity,
                    height: 200,
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
                            "${photo["url"]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          
                          // Featured Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "FEATURED",
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
                        ],
                      ),
                    ),
                  ),

                  // Photo Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${photo["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "by ${photo["artist"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 14,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${photo["likes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(PhotoDetailView(photo: photo));
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.favorite_border,
                              size: bs.sm,
                              onPressed: () {
                                ss("Added to favorites!");
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                si("Share feature coming soon!");
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
          // Recent Header
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Recently Added",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Recent Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: List.generate(12, (index) {
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
                        "https://picsum.photos/300/200?random=${40 + index}&keyword=recent",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      
                      // Time Badge
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
                            "${index + 1}h ago",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          // Load More
          Center(
            child: QButton(
              label: "Load More",
              size: bs.md,
              onPressed: () async {
                loading = true;
                setState(() {});
                
                await Future.delayed(Duration(seconds: 1));
                
                loading = false;
                setState(() {});
                
                si("More photos loaded!");
              },
            ),
          ),
        ],
      ),
    );
  }
}
