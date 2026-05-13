import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream6View extends StatefulWidget {
  @override
  State<GrlStream6View> createState() => _GrlStream6ViewState();
}

class _GrlStream6ViewState extends State<GrlStream6View> {
  String selectedFilter = "All";
  String selectedCategory = "Gaming";
  bool isLiveNow = true;
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> streamCategories = [
    {
      "label": "Gaming",
      "value": "Gaming",
    },
    {
      "label": "Music",
      "value": "Music",
    },
    {
      "label": "Sports",
      "value": "Sports",
    },
    {
      "label": "Talk Shows",
      "value": "Talk Shows",
    },
    {
      "label": "Education",
      "value": "Education",
    },
  ];

  List<Map<String, dynamic>> streamData = [
    {
      "id": 1,
      "title": "Pro Gaming Tournament - Championship Finals",
      "streamer": "GamerPro_Elite",
      "viewers": 15420,
      "thumbnail": "https://picsum.photos/400/250?random=1&keyword=gaming",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "category": "Gaming",
      "duration": "3:45:12",
      "isLive": true,
      "tags": ["Tournament", "FPS", "Championship"],
      "followers": 125000,
      "description": "Live championship finals with top players competing for \$50,000 prize pool",
    },
    {
      "id": 2,
      "title": "Chill Music Session - Lo-Fi Beats",
      "streamer": "MusicMaker99",
      "viewers": 8950,
      "thumbnail": "https://picsum.photos/400/250?random=2&keyword=music",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "category": "Music",
      "duration": "2:15:30",
      "isLive": true,
      "tags": ["Lo-Fi", "Chill", "Study Music"],
      "followers": 89000,
      "description": "Relaxing lo-fi beats perfect for studying and working",
    },
    {
      "id": 3,
      "title": "Football Match Analysis & Commentary",
      "streamer": "SportsAnalyst",
      "viewers": 12300,
      "thumbnail": "https://picsum.photos/400/250?random=3&keyword=sports",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "category": "Sports",
      "duration": "1:20:45",
      "isLive": true,
      "tags": ["Football", "Analysis", "Live Commentary"],
      "followers": 67000,
      "description": "Expert analysis of today's big match with live commentary",
    },
    {
      "id": 4,
      "title": "Cooking Masterclass - Italian Cuisine",
      "streamer": "ChefMario",
      "viewers": 5670,
      "thumbnail": "https://picsum.photos/400/250?random=4&keyword=cooking",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "category": "Education",
      "duration": "1:05:20",
      "isLive": true,
      "tags": ["Cooking", "Italian", "Masterclass"],
      "followers": 34000,
      "description": "Learn authentic Italian cooking techniques from a professional chef",
    },
    {
      "id": 5,
      "title": "Tech Talk - AI and Future Technology",
      "streamer": "TechGuru2024",
      "viewers": 9840,
      "thumbnail": "https://picsum.photos/400/250?random=5&keyword=technology",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "category": "Talk Shows",
      "duration": "0:45:12",
      "isLive": true,
      "tags": ["AI", "Technology", "Future"],
      "followers": 156000,
      "description": "Discussing the latest AI developments and future technology trends",
    },
    {
      "id": 6,
      "title": "Speedrun Challenge - World Record Attempt",
      "streamer": "SpeedRunner_X",
      "viewers": 22100,
      "thumbnail": "https://picsum.photos/400/250?random=6&keyword=gaming",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=person",
      "category": "Gaming",
      "duration": "0:28:15",
      "isLive": true,
      "tags": ["Speedrun", "World Record", "Challenge"],
      "followers": 78000,
      "description": "Attempting to break the world record in this challenging speedrun",
    },
  ];

  List<Map<String, dynamic>> get filteredStreams {
    return streamData.where((stream) {
      bool categoryMatch = selectedCategory == "All" || stream["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          stream["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          stream["streamer"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool liveMatch = !isLiveNow || stream["isLive"] == true;
      
      return categoryMatch && searchMatch && liveMatch;
    }).toList();
  }

  String formatViewers(int viewers) {
    if (viewers >= 1000) {
      return "${(viewers / 1000).toStringAsFixed(1)}K";
    }
    return viewers.toString();
  }

  String formatFollowers(int followers) {
    if (followers >= 1000000) {
      return "${(followers / 1000000).toStringAsFixed(1)}M";
    } else if (followers >= 1000) {
      return "${(followers / 1000).toStringAsFixed(1)}K";
    }
    return followers.toString();
  }

  Widget _buildStreamCard(Map<String, dynamic> stream) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with live indicator
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                  child: Image.network(
                    "${stream["thumbnail"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Live indicator
              if (stream["isLive"] == true)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "LIVE",
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
              // Duration
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(179),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${stream["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Viewers count
              Positioned(
                bottom: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(179),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${formatViewers(stream["viewers"] as int)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Stream info
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Streamer info
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
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
                            "${stream["streamer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${formatFollowers(stream["followers"] as int)} followers",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                // Title
                Text(
                  "${stream["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: spXs),
                // Description
                Text(
                  "${stream["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (stream["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Watch Stream",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.md,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedStream() {
    if (filteredStreams.isEmpty) return SizedBox.shrink();
    
    final featured = filteredStreams.first;
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowLg],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                "${featured["thumbnail"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(204),
                ],
              ),
            ),
          ),
          Positioned(
            top: spMd,
            left: spMd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "FEATURED",
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
            top: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${formatViewers(featured["viewers"] as int)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${featured["title"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "${featured["avatar"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${featured["streamer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Watch Now",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Streams"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.notifications,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search streams...",
                    value: searchQuery,
                    hint: "Search by title or streamer",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.md,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Category filter
            QCategoryPicker(
              label: "Categories",
              items: [
                {"label": "All", "value": "All"},
                ...streamCategories,
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            
            // Live now toggle
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Live Now Only",
                        "value": true,
                        "checked": isLiveNow,
                      }
                    ],
                    value: [
                      if (isLiveNow)
                        {
                          "label": "Live Now Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      isLiveNow = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spLg),
            
            // Featured stream
            if (filteredStreams.isNotEmpty) ...[
              Text(
                "Featured Stream",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: spMd),
              _buildFeaturedStream(),
            ],
            
            // All streams section
            Row(
              children: [
                Text(
                  "All Streams",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredStreams.length} streams",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Stream list
            if (filteredStreams.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.live_tv,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No streams found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredStreams.skip(1).map((stream) => _buildStreamCard(stream)).toList(),
          ],
        ),
      ),
    );
  }
}
