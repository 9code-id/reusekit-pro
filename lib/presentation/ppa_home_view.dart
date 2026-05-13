import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaHomeView extends StatefulWidget {
  const PpaHomeView({super.key});

  @override
  State<PpaHomeView> createState() => _PpaHomeViewState();
}

class _PpaHomeViewState extends State<PpaHomeView> {
  int currentTab = 0;

  List<Map<String, dynamic>> recentPhotos = [
    {
      "id": "1",
      "image": "https://picsum.photos/400/600?random=1&keyword=portrait",
      "title": "Golden Hour Portrait",
      "location": "Central Park, NYC",
      "date": "2024-12-16",
      "likes": 245,
      "isLiked": true,
      "camera": "iPhone 15 Pro",
      "settings": "f/1.8 • 1/120s • ISO 100"
    },
    {
      "id": "2",
      "image": "https://picsum.photos/600/400?random=2&keyword=landscape",
      "title": "Mountain Sunrise",
      "location": "Rocky Mountains, CO",
      "date": "2024-12-15",
      "likes": 189,
      "isLiked": false,
      "camera": "Canon EOS R5",
      "settings": "f/8.0 • 1/250s • ISO 200"
    },
    {
      "id": "3",
      "image": "https://picsum.photos/400/400?random=3&keyword=architecture",
      "title": "Modern Architecture",
      "location": "Downtown LA",
      "date": "2024-12-14",
      "likes": 156,
      "isLiked": true,
      "camera": "Sony A7R IV",
      "settings": "f/11 • 1/60s • ISO 400"
    },
    {
      "id": "4",
      "image": "https://picsum.photos/600/600?random=4&keyword=street",
      "title": "Street Photography",
      "location": "Brooklyn, NYC",
      "date": "2024-12-13",
      "likes": 298,
      "isLiked": false,
      "camera": "Fujifilm X-T5",
      "settings": "f/2.8 • 1/500s • ISO 800"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Camera",
      "subtitle": "Take photos",
      "icon": Icons.camera_alt,
      "color": Color(0xFF4CAF50),
      "route": "PpaCameraView"
    },
    {
      "title": "Gallery",
      "subtitle": "View photos",
      "icon": Icons.photo_library,
      "color": Color(0xFF2196F3),
      "route": "PpaGalleryView"
    },
    {
      "title": "Edit",
      "subtitle": "Photo editor",
      "icon": Icons.edit,
      "color": Color(0xFFFF9800),
      "route": "PpaEditorView"
    },
    {
      "title": "Share",
      "subtitle": "Share photos",
      "icon": Icons.share,
      "color": Color(0xFF9C27B0),
      "route": "PpaShareView"
    }
  ];

  List<Map<String, dynamic>> featuredTools = [
    {
      "title": "AI Portrait Mode",
      "description": "Professional portrait effects with background blur",
      "icon": Icons.face_retouching_natural,
      "isPremium": true,
      "image": "https://picsum.photos/300/200?random=11&keyword=portrait-blur"
    },
    {
      "title": "Night Mode",
      "description": "Capture stunning low-light photography",
      "icon": Icons.nightlight,
      "isPremium": false,
      "image": "https://picsum.photos/300/200?random=12&keyword=night"
    },
    {
      "title": "HDR Processing",
      "description": "Merge multiple exposures for perfect lighting",
      "icon": Icons.hdr_on,
      "isPremium": true,
      "image": "https://picsum.photos/300/200?random=13&keyword=hdr"
    },
    {
      "title": "Color Grading",
      "description": "Professional color correction and grading tools",
      "icon": Icons.palette,
      "isPremium": true,
      "image": "https://picsum.photos/300/200?random=14&keyword=colors"
    }
  ];

  List<Map<String, dynamic>> stats = [
    {
      "title": "Photos Taken",
      "value": "1,247",
      "icon": Icons.camera,
      "color": Color(0xFF4CAF50)
    },
    {
      "title": "Photos Edited",
      "value": "892",
      "icon": Icons.edit,
      "color": Color(0xFF2196F3)
    },
    {
      "title": "Storage Used",
      "value": "2.4 GB",
      "icon": Icons.storage,
      "color": Color(0xFFFF9800)
    },
    {
      "title": "Likes Received",
      "value": "15.2K",
      "icon": Icons.favorite,
      "color": Color(0xFFE91E63)
    }
  ];

  void toggleLike(String photoId) {
    final photoIndex = recentPhotos.indexWhere((photo) => photo["id"] == photoId);
    if (photoIndex != -1) {
      final isLiked = recentPhotos[photoIndex]["isLiked"] as bool;
      recentPhotos[photoIndex]["isLiked"] = !isLiked;
      recentPhotos[photoIndex]["likes"] = (recentPhotos[photoIndex]["likes"] as int) + (isLiked ? -1 : 1);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhotoPro"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('PpaNotificationsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              //navigateTo('PpaProfileView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning!",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Ready to capture amazing photos today?",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.camera_alt,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('PpaCameraView')
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickActions.map((action) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: InkWell(
                    onTap: () {
                      //navigateTo(action["route"])
                    },
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            action["icon"] as IconData,
                            size: 28,
                            color: action["color"] as Color,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${action["subtitle"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Stats Row
            Text(
              "Your Stats",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: stats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        stat["icon"] as IconData,
                        size: 24,
                        color: stat["color"] as Color,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Featured Tools
            Row(
              children: [
                Text(
                  "Featured Tools",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    //navigateTo('PpaPremiumFeaturesView')
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            QHorizontalScroll(
              children: featuredTools.map((tool) {
                return Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tool Image
                      Container(
                        height: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                "${tool["image"]}",
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                              if (tool["isPremium"] as bool)
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "PRO",
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
                      ),

                      // Tool Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  tool["icon"] as IconData,
                                  size: 20,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${tool["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${tool["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: tool["isPremium"] as bool ? "Upgrade to Pro" : "Try Now",
                                size: bs.sm,
                                onPressed: () {
                                  if (tool["isPremium"] as bool) {
                                    //navigateTo('PpaSubscriptionView')
                                  } else {
                                    //navigateTo('PpaCameraView')
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Photos
            Row(
              children: [
                Text(
                  "Recent Photos",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    //navigateTo('PpaGalleryView')
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: recentPhotos.map((photo) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Header
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${photo["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${photo["location"]} • ${photo["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),

                      // Photo Image
                      Container(
                        height: 300,
                        child: ClipRRect(
                          child: Image.network(
                            "${photo["image"]}",
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Photo Actions
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => toggleLike(photo["id"]),
                                  child: Row(
                                    children: [
                                      Icon(
                                        photo["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                                        color: photo["isLiked"] as bool ? dangerColor : disabledBoldColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${photo["likes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.share,
                                  size: 20,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${photo["camera"]} • ${photo["settings"]}",
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
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
