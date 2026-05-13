import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream1View extends StatefulWidget {
  @override
  State<GrlStream1View> createState() => _GrlStream1ViewState();
}

class _GrlStream1ViewState extends State<GrlStream1View> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> liveStreams = [
    {
      "id": "1",
      "title": "Epic Battle Royale - Road to Victory!",
      "streamer": "ProGamer_Alex",
      "viewers": 15420,
      "category": "Gaming",
      "game": "Battle Arena",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=gaming",
      "avatar": "https://picsum.photos/50/50?random=101",
      "isLive": true,
      "duration": "2h 15m",
      "tags": ["gaming", "battle royale", "competitive"],
    },
    {
      "id": "2",
      "title": "Chill Music Session 🎵 Taking Requests",
      "streamer": "MelodyMaker_Sarah",
      "viewers": 8945,
      "category": "Music",
      "game": "Music Creation",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=music",
      "avatar": "https://picsum.photos/50/50?random=102",
      "isLive": true,
      "duration": "1h 32m",
      "tags": ["music", "chill", "requests"],
    },
    {
      "id": "3",
      "title": "Cooking with Love - Italian Pasta Special",
      "streamer": "ChefMario_Official",
      "viewers": 6732,
      "category": "Cooking",
      "game": "Cooking Tutorial",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "avatar": "https://picsum.photos/50/50?random=103",
      "isLive": true,
      "duration": "45m",
      "tags": ["cooking", "italian", "pasta"],
    },
    {
      "id": "4",
      "title": "Art & Soul - Digital Painting Masterclass",
      "streamer": "ArtistLuna",
      "viewers": 4521,
      "category": "Art",
      "game": "Digital Art",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=art",
      "avatar": "https://picsum.photos/50/50?random=104",
      "isLive": true,
      "duration": "3h 20m",
      "tags": ["art", "digital", "painting"],
    },
    {
      "id": "5",
      "title": "Tech Talk - Latest Gadget Reviews",
      "streamer": "TechGuru_Mike",
      "viewers": 3289,
      "category": "Technology",
      "game": "Tech Review",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=technology",
      "avatar": "https://picsum.photos/50/50?random=105",
      "isLive": true,
      "duration": "1h 05m",
      "tags": ["tech", "review", "gadgets"],
    },
    {
      "id": "6",
      "title": "Fitness Friday - Full Body Workout",
      "streamer": "FitTrainer_Emma",
      "viewers": 2987,
      "category": "Sports",
      "game": "Fitness Training",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=fitness",
      "avatar": "https://picsum.photos/50/50?random=106",
      "isLive": true,
      "duration": "55m",
      "tags": ["fitness", "workout", "health"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 50420},
    {"name": "Gaming", "count": 25000},
    {"name": "Music", "count": 8500},
    {"name": "Art", "count": 6200},
    {"name": "Cooking", "count": 4800},
    {"name": "Technology", "count": 3200},
    {"name": "Sports", "count": 2720},
  ];

  List<Map<String, dynamic>> topStreamers = [
    {
      "name": "ProGamer_Alex",
      "followers": "1.2M",
      "avatar": "https://picsum.photos/60/60?random=201",
      "isLive": true,
      "currentViewers": 15420,
      "category": "Gaming",
    },
    {
      "name": "MelodyMaker_Sarah",
      "followers": "890K",
      "avatar": "https://picsum.photos/60/60?random=202",
      "isLive": true,
      "currentViewers": 8945,
      "category": "Music",
    },
    {
      "name": "ChefMario_Official",
      "followers": "654K",
      "avatar": "https://picsum.photos/60/60?random=203",
      "isLive": true,
      "currentViewers": 6732,
      "category": "Cooking",
    },
    {
      "name": "ArtistLuna",
      "followers": "543K",
      "avatar": "https://picsum.photos/60/60?random=204",
      "isLive": false,
      "currentViewers": 0,
      "category": "Art",
    },
  ];

  void _watchStream(Map<String, dynamic> stream) {
    si("Opening ${stream["streamer"]}'s stream...");
    // Navigate to stream view
  }

  void _followStreamer(Map<String, dynamic> streamer) {
    ss("Now following ${streamer["name"]}!");
  }

  List<Map<String, dynamic>> get filteredStreams {
    List<Map<String, dynamic>> filtered = liveStreams;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((stream) => stream["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((stream) =>
        stream["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        stream["streamer"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Live Streams",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.explore)),
        Tab(text: "Following", icon: Icon(Icons.favorite)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildFollowingTab(),
        _buildCategoriesTab(),
      ],
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search streams, streamers...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Top streamers
          Row(
            children: [
              Text(
                "Top Streamers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          QHorizontalScroll(
            children: topStreamers.map((streamer) {
              return Container(
                width: 140,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: (streamer["isLive"] as bool) ? successColor : disabledColor,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${streamer["avatar"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (streamer["isLive"] as bool)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${streamer["name"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${streamer["followers"]} followers",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (streamer["isLive"] as bool)
                      Column(
                        children: [
                          SizedBox(height: spXs),
                          Text(
                            "${streamer["currentViewers"]} watching",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Follow",
                        size: bs.sm,
                        onPressed: () => _followStreamer(streamer),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spMd),

          // Category filter
          QHorizontalScroll(
            children: categories.map((category) {
              bool isSelected = selectedCategory == category["name"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = "${category["name"]}";
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${category["count"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white.withAlpha(180) : disabledColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spMd),

          // Live streams
          Row(
            children: [
              Text(
                "Live Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${filteredStreams.length} streams",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          SizedBox(height: spSm),

          // Stream grid
          ...filteredStreams.map((stream) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stream thumbnail
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${stream["thumbnail"]}",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      // Live indicator
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Viewer count
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(160),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${stream["viewers"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Duration
                      Positioned(
                        bottom: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(160),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${stream["duration"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Play button
                      Positioned(
                        bottom: spSm,
                        right: spSm,
                        child: GestureDetector(
                          onTap: () => _watchStream(stream),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Stream info
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: successColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${stream["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${stream["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${stream["streamer"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${stream["game"]} • ${stream["category"]}",
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

                        SizedBox(height: spSm),

                        // Tags
                        Wrap(
                          spacing: spSm,
                          children: (stream["tags"] as List<String>).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(height: spSm),

                        // Watch button
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Watch Stream",
                            size: bs.sm,
                            onPressed: () => _watchStream(stream),
                          ),
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

  Widget _buildFollowingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // No following message
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No Followed Streamers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Follow your favorite streamers to see when they go live",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Discover Streamers",
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: categories.skip(1).map((category) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = "${category["name"]}";
                    currentTab = 0;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          _getCategoryIcon("${category["name"]}"),
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${category["count"]} viewers",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Browse",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              selectedCategory = "${category["name"]}";
                              currentTab = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Gaming":
        return Icons.sports_esports;
      case "Music":
        return Icons.music_note;
      case "Art":
        return Icons.palette;
      case "Cooking":
        return Icons.restaurant;
      case "Technology":
        return Icons.computer;
      case "Sports":
        return Icons.sports_soccer;
      default:
        return Icons.category;
    }
  }
}
