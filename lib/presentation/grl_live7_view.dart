import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive7View extends StatefulWidget {
  @override
  State<GrlLive7View> createState() => _GrlLive7ViewState();
}

class _GrlLive7ViewState extends State<GrlLive7View> {
  int currentTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> liveCategories = [
    {"name": "Gaming", "count": 12847, "icon": Icons.sports_esports},
    {"name": "Music", "count": 8932, "icon": Icons.music_note},
    {"name": "Talk Shows", "count": 5643, "icon": Icons.mic},
    {"name": "Sports", "count": 4521, "icon": Icons.sports_soccer},
    {"name": "Education", "count": 3289, "icon": Icons.school},
    {"name": "Cooking", "count": 2156, "icon": Icons.restaurant},
  ];

  List<Map<String, dynamic>> liveStreams = [
    {
      "title": "Epic Gaming Session - Come Join!",
      "streamer": "ProGamer_Alex",
      "viewers": 15420,
      "category": "Gaming",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=gaming",
      "avatar": "https://picsum.photos/50/50?random=101",
      "isLive": true,
      "tags": ["gaming", "fps", "competitive"],
    },
    {
      "title": "Live Music Performance 🎵",
      "streamer": "MusicMaster_Sarah",
      "viewers": 8945,
      "category": "Music", 
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=music",
      "avatar": "https://picsum.photos/50/50?random=102",
      "isLive": true,
      "tags": ["music", "live", "acoustic"],
    },
    {
      "title": "Cooking Masterclass",
      "streamer": "ChefMike_Official",
      "viewers": 6732,
      "category": "Cooking",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=cooking",
      "avatar": "https://picsum.photos/50/50?random=103",
      "isLive": true,
      "tags": ["cooking", "tutorial", "recipe"],
    },
    {
      "title": "Morning Yoga & Meditation",
      "streamer": "ZenMaster_Emma",
      "viewers": 4568,
      "category": "Wellness",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=yoga",
      "avatar": "https://picsum.photos/50/50?random=104",
      "isLive": true,
      "tags": ["yoga", "meditation", "wellness"],
    },
    {
      "title": "Tech Talk: Latest Gadgets",
      "streamer": "TechReviewer_John",
      "viewers": 3421,
      "category": "Technology",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=technology",
      "avatar": "https://picsum.photos/50/50?random=105",
      "isLive": true,
      "tags": ["tech", "review", "gadgets"],
    },
    {
      "title": "Art & Drawing Session",
      "streamer": "ArtistLily",
      "viewers": 2987,
      "category": "Art",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=art",
      "avatar": "https://picsum.photos/50/50?random=106",
      "isLive": true,
      "tags": ["art", "drawing", "creative"],
    },
  ];

  List<Map<String, dynamic>> featuredStreamers = [
    {
      "name": "ProGamer_Alex",
      "followers": "1.2M",
      "avatar": "https://picsum.photos/80/80?random=201",
      "isVerified": true,
      "category": "Gaming",
    },
    {
      "name": "MusicMaster_Sarah", 
      "followers": "890K",
      "avatar": "https://picsum.photos/80/80?random=202",
      "isVerified": true,
      "category": "Music",
    },
    {
      "name": "ChefMike_Official",
      "followers": "654K",
      "avatar": "https://picsum.photos/80/80?random=203",
      "isVerified": true,
      "category": "Cooking",
    },
    {
      "name": "TechReviewer_John",
      "followers": "543K",
      "avatar": "https://picsum.photos/80/80?random=204",
      "isVerified": false,
      "category": "Technology",
    },
  ];

  void _joinStream(Map<String, dynamic> stream) {
    si("Joining ${stream["streamer"]}'s stream...");
    // Navigate to live stream view
  }

  void _followStreamer(Map<String, dynamic> streamer) {
    ss("Started following ${streamer["name"]}!");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Live Streams",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Discover", icon: Icon(Icons.explore)),
        Tab(text: "Following", icon: Icon(Icons.people)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
      ],
      tabChildren: [
        _buildDiscoverTab(),
        _buildFollowingTab(),
        _buildCategoriesTab(),
      ],
    );
  }

  Widget _buildDiscoverTab() {
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
                      hintText: "Search live streams...",
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

          // Featured streamers
          Text(
            "Featured Streamers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: featuredStreamers.map((streamer) {
              return Container(
                width: 120,
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
                              color: successColor,
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
                        if (streamer["isVerified"] as bool)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 12,
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
                    SizedBox(height: spSm),
                    QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () => _followStreamer(streamer),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spMd),

          // Live now section
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

          // Live streams grid
          ...liveStreams.map((stream) {
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
                  // Thumbnail with live indicator
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
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spSm,
                        right: spSm,
                        child: GestureDetector(
                          onTap: () => _joinStream(stream),
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
                                    "${stream["category"]}",
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
                  Icons.people_outline,
                  size: 80,
                  color: disabledColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No Live Streamers",
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
            "Browse Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),

          // Categories grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: liveCategories.map((category) {
              return Container(
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
                        category["icon"] as IconData,
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
                        label: "Explore",
                        size: bs.sm,
                        onPressed: () {
                          si("Exploring ${category["name"]} category");
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
