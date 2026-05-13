import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaScreenshotsView extends StatefulWidget {
  const GeaScreenshotsView({super.key});

  @override
  State<GeaScreenshotsView> createState() => _GeaScreenshotsViewState();
}

class _GeaScreenshotsViewState extends State<GeaScreenshotsView> {
  int selectedIndex = 0;
  bool isZoomed = false;
  String selectedCategory = "All";
  
  List<String> categories = [
    "All",
    "Gameplay",
    "Characters", 
    "Environment",
    "Combat",
    "Vehicles",
    "UI/Menus"
  ];

  List<Map<String, dynamic>> screenshots = [
    {
      "id": 1,
      "url": "https://picsum.photos/800/600?random=1&keyword=cyberpunk",
      "thumbnailUrl": "https://picsum.photos/400/300?random=1&keyword=cyberpunk",
      "title": "Night City Overview",
      "description": "Breathtaking view of the neon-lit metropolis at night",
      "category": "Environment",
      "resolution": "3840x2160",
      "uploadDate": "2024-05-15",
      "likes": 2450,
      "downloads": 1200,
      "tags": ["Night City", "Neon", "Cyberpunk", "Skyline"],
    },
    {
      "id": 2,
      "url": "https://picsum.photos/800/600?random=2&keyword=character",
      "thumbnailUrl": "https://picsum.photos/400/300?random=2&keyword=character",
      "title": "Character Customization",
      "description": "Detailed character creation system with extensive options",
      "category": "Characters",
      "resolution": "2560x1440",
      "uploadDate": "2024-05-14",
      "likes": 1890,
      "downloads": 850,
      "tags": ["Character", "Customization", "RPG", "Avatar"],
    },
    {
      "id": 3,
      "url": "https://picsum.photos/800/600?random=3&keyword=combat",
      "thumbnailUrl": "https://picsum.photos/400/300?random=3&keyword=combat",
      "title": "Combat System in Action",
      "description": "Fast-paced combat with futuristic weapons and abilities",
      "category": "Combat",
      "resolution": "3840x2160",
      "uploadDate": "2024-05-13",
      "likes": 3200,
      "downloads": 1800,
      "tags": ["Combat", "Action", "Weapons", "Fighting"],
    },
    {
      "id": 4,
      "url": "https://picsum.photos/800/600?random=4&keyword=vehicle",
      "thumbnailUrl": "https://picsum.photos/400/300?random=4&keyword=vehicle",
      "title": "Futuristic Vehicles",
      "description": "High-tech vehicles for traversing the urban landscape",
      "category": "Vehicles",
      "resolution": "2560x1440",
      "uploadDate": "2024-05-12",
      "likes": 1650,
      "downloads": 720,
      "tags": ["Vehicles", "Cars", "Flying", "Transportation"],
    },
    {
      "id": 5,
      "url": "https://picsum.photos/800/600?random=5&keyword=gameplay",
      "thumbnailUrl": "https://picsum.photos/400/300?random=5&keyword=gameplay",
      "title": "Open World Exploration",
      "description": "Vast open world with countless secrets to discover",
      "category": "Gameplay",
      "resolution": "3840x2160",
      "uploadDate": "2024-05-11",
      "likes": 2100,
      "downloads": 1100,
      "tags": ["Open World", "Exploration", "Adventure", "Discovery"],
    },
    {
      "id": 6,
      "url": "https://picsum.photos/800/600?random=6&keyword=interface",
      "thumbnailUrl": "https://picsum.photos/400/300?random=6&keyword=interface",
      "title": "User Interface Design",
      "description": "Sleek and intuitive UI design for enhanced gaming experience",
      "category": "UI/Menus",
      "resolution": "1920x1080",
      "uploadDate": "2024-05-10",
      "likes": 980,
      "downloads": 420,
      "tags": ["UI", "Interface", "Menu", "Design"],
    },
    {
      "id": 7,
      "url": "https://picsum.photos/800/600?random=7&keyword=npc",
      "thumbnailUrl": "https://picsum.photos/400/300?random=7&keyword=npc",
      "title": "NPC Interactions",
      "description": "Dynamic conversations with realistic non-player characters",
      "category": "Characters",
      "resolution": "2560x1440",
      "uploadDate": "2024-05-09",
      "likes": 1350,
      "downloads": 680,
      "tags": ["NPC", "Dialogue", "Characters", "Interaction"],
    },
    {
      "id": 8,
      "url": "https://picsum.photos/800/600?random=8&keyword=building",
      "thumbnailUrl": "https://picsum.photos/400/300?random=8&keyword=building",
      "title": "Architectural Wonders",
      "description": "Impressive futuristic architecture and building designs",
      "category": "Environment",
      "resolution": "3840x2160",
      "uploadDate": "2024-05-08",
      "likes": 1750,
      "downloads": 920,
      "tags": ["Architecture", "Buildings", "Futuristic", "Design"],
    },
  ];

  List<Map<String, dynamic>> get filteredScreenshots {
    if (selectedCategory == "All") return screenshots;
    return screenshots.where((screenshot) => 
        screenshot["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Screenshots"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              si("Downloaded screenshot to gallery");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Screenshot link copied to clipboard");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Screenshot Display
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      isZoomed = !isZoomed;
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        "${filteredScreenshots[selectedIndex]["url"]}",
                        fit: isZoomed ? BoxFit.contain : BoxFit.cover,
                      ),
                    ),
                  ),
                  // Navigation Arrows
                  if (filteredScreenshots.length > 1) ...[
                    Positioned(
                      left: spMd,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (selectedIndex > 0) {
                              selectedIndex--;
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
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: spMd,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (selectedIndex < filteredScreenshots.length - 1) {
                              selectedIndex++;
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
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Screenshot Counter
                  Positioned(
                    bottom: spMd,
                    right: spMd,
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
                        "${selectedIndex + 1} / ${filteredScreenshots.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Zoom Indicator
                  if (isZoomed)
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Screenshot Info and Actions
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Screenshot Title and Info
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${filteredScreenshots[selectedIndex]["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${filteredScreenshots[selectedIndex]["description"]}",
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
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor.withAlpha(100),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "${filteredScreenshots[selectedIndex]["resolution"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${filteredScreenshots[selectedIndex]["likes"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${filteredScreenshots[selectedIndex]["downloads"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Download HD",
                        size: bs.sm,
                        onPressed: () {
                          ss("Downloading high resolution image...");
                        },
                      ),
                    ],
                  ),

                  // Tags
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tags",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: (filteredScreenshots[selectedIndex]["tags"] as List<String>).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      selectedIndex = 0;
                      setState(() {});
                    },
                  ),

                  // Thumbnail Gallery
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "All Screenshots",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${filteredScreenshots.length} images",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: filteredScreenshots.asMap().entries.map((entry) {
                          final index = entry.key;
                          final screenshot = entry.value;
                          final isSelected = index == selectedIndex;
                          
                          return GestureDetector(
                            onTap: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: isSelected ? [shadowMd] : [shadowSm],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusMd),   
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "${screenshot["thumbnailUrl"]}",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    if (isSelected)
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(50),
                                        ),
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(spSm),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(radiusLg),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withAlpha(150),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${screenshot["title"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${screenshot["likes"]}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${screenshot["downloads"]}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
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
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Statistics
                  Container(
                    padding: EdgeInsets.all(spSm),
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
                              Icon(
                                Icons.photo_library,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${screenshots.length}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Screenshots",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: dangerColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((screenshots.fold(0, (sum, s) => sum + (s["likes"] as int))) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 18,
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
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.download,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((screenshots.fold(0, (sum, s) => sum + (s["downloads"] as int))) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Downloads",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
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
