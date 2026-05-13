import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBookmark4View extends StatefulWidget {
  @override
  State<GrlBookmark4View> createState() => _GrlBookmark4ViewState();
}

class _GrlBookmark4ViewState extends State<GrlBookmark4View> {
  int currentTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> collections = [
    {
      "id": 1,
      "name": "Web Development",
      "description": "Resources for modern web development",
      "image": "https://picsum.photos/400/300?random=31&keyword=coding",
      "bookmarkCount": 32,
      "isPrivate": false,
      "color": primaryColor,
      "tags": ["web", "javascript", "css"],
      "lastUpdated": "2 hours ago"
    },
    {
      "id": 2,
      "name": "Design Inspiration",
      "description": "Beautiful designs and creative ideas",
      "image": "https://picsum.photos/400/300?random=32&keyword=design",
      "bookmarkCount": 28,
      "isPrivate": false,
      "color": warningColor,
      "tags": ["design", "ui", "inspiration"],
      "lastUpdated": "1 day ago"
    },
    {
      "id": 3,
      "name": "Personal Notes",
      "description": "Private collection of important links",
      "image": "https://picsum.photos/400/300?random=33&keyword=notes",
      "bookmarkCount": 15,
      "isPrivate": true,
      "color": dangerColor,
      "tags": ["private", "notes", "personal"],
      "lastUpdated": "3 days ago"
    },
    {
      "id": 4,
      "name": "Travel Planning",
      "description": "Places to visit and travel guides",
      "image": "https://picsum.photos/400/300?random=34&keyword=travel",
      "bookmarkCount": 20,
      "isPrivate": false,
      "color": infoColor,
      "tags": ["travel", "vacation", "guides"],
      "lastUpdated": "1 week ago"
    },
  ];

  List<Map<String, dynamic>> recentBookmarks = [
    {
      "id": 1,
      "title": "Flutter State Management Guide",
      "url": "https://flutter.dev/state-management",
      "description": "Comprehensive guide to managing state in Flutter applications",
      "image": "https://picsum.photos/100/100?random=41&keyword=flutter",
      "collection": "Web Development",
      "timeAdded": "2 minutes ago",
      "isRead": false
    },
    {
      "id": 2,
      "title": "Material Design 3.0",
      "url": "https://material.io/design",
      "description": "Latest Material Design guidelines and components",
      "image": "https://picsum.photos/100/100?random=42&keyword=material",
      "collection": "Design Inspiration",
      "timeAdded": "1 hour ago",
      "isRead": true
    },
    {
      "id": 3,
      "title": "Iceland Travel Guide",
      "url": "https://example.com/iceland",
      "description": "Complete guide to exploring Iceland's natural wonders",
      "image": "https://picsum.photos/100/100?random=43&keyword=iceland",
      "collection": "Travel Planning",
      "timeAdded": "3 hours ago",
      "isRead": false
    },
    {
      "id": 4,
      "title": "JavaScript ES2024 Features",
      "url": "https://example.com/js2024",
      "description": "New JavaScript features and syntax improvements",
      "image": "https://picsum.photos/100/100?random=44&keyword=javascript",
      "collection": "Web Development",
      "timeAdded": "1 day ago",
      "isRead": true
    },
  ];

  List<Map<String, dynamic>> get filteredCollections {
    List<Map<String, dynamic>> items = [];
    
    switch (currentTabIndex) {
      case 0: // All Collections
        items = collections;
        break;
      case 1: // Public Collections
        items = collections.where((c) => !(c["isPrivate"] as bool)).toList();
        break;
      case 2: // Private Collections
        items = collections.where((c) => c["isPrivate"] as bool).toList();
        break;
    }
    
    if (searchQuery.isNotEmpty) {
      items = items.where((collection) {
        return "${collection["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${collection["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               (collection["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + spMd,
              left: spMd,
              right: spMd,
              bottom: spMd,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, primaryColor.withAlpha(200)],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Collections",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(Icons.more_vert, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: spLg),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search collections...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: spMd),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Tab Navigation
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildTabButton("All", 0),
                _buildTabButton("Public", 1),
                _buildTabButton("Private", 2),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Collections Grid
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: filteredCollections.map((collection) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                  child: Image.network(
                                    "${collection["image"]}",
                                    width: double.infinity,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      (collection["isPrivate"] as bool) ? Icons.lock : Icons.public,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: (collection["color"] as Color),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${collection["bookmarkCount"]} items",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${collection["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${collection["description"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spMd),
                                  Wrap(
                                    spacing: spXs,
                                    children: (collection["tags"] as List).take(2).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "#$tag",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: spMd),
                                  Row(
                                    children: [
                                      Text(
                                        "Updated ${collection["lastUpdated"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.more_horiz, color: disabledBoldColor, size: 16),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Recent Activity Section
                  Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...recentBookmarks.map((bookmark) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: (bookmark["isRead"] as bool) ? Colors.grey[200]! : primaryColor.withAlpha(100),
                          width: (bookmark["isRead"] as bool) ? 1 : 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${bookmark["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${bookmark["title"]}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${bookmark["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spSm),
                                Row(
                                  children: [
                                    Text(
                                      "${bookmark["collection"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " • ${bookmark["timeAdded"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: (bookmark["isRead"] as bool) ? Colors.grey[300] : primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Icon(Icons.arrow_forward_ios, color: disabledBoldColor, size: 14),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = currentTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTabIndex = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spSm),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? primaryColor : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
