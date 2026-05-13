import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaClipsView extends StatefulWidget {
  const GeaClipsView({super.key});

  @override
  State<GeaClipsView> createState() => _GeaClipsViewState();
}

class _GeaClipsViewState extends State<GeaClipsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Recent";
  String selectedGame = "All Games";
  bool showMyClips = false;
  
  List<Map<String, dynamic>> gamesList = [
    {"label": "All Games", "value": "All Games"},
    {"label": "Battle Royale", "value": "Battle Royale"},
    {"label": "Racing Thunder", "value": "Racing Thunder"},
    {"label": "Space Combat", "value": "Space Combat"},
    {"label": "Puzzle Master", "value": "Puzzle Master"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Epic Win", "value": "Epic Win"},
    {"label": "Funny Moment", "value": "Funny Moment"},
    {"label": "Skill Shot", "value": "Skill Shot"},
    {"label": "Team Play", "value": "Team Play"},
    {"label": "Bug/Glitch", "value": "Bug/Glitch"},
    {"label": "Tutorial", "value": "Tutorial"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Recent", "value": "Recent"},
    {"label": "Popular", "value": "Popular"},
    {"label": "Most Viewed", "value": "Most Viewed"},
    {"label": "Highest Rated", "value": "Highest Rated"},
  ];

  List<Map<String, dynamic>> clipsList = [
    {
      "id": 1,
      "title": "Epic Victory Royale",
      "description": "Last player standing with 15 kills!",
      "game": "Battle Royale",
      "category": "Epic Win",
      "duration": 45,
      "views": 12500,
      "likes": 890,
      "comments": 67,
      "createdBy": "ProGamer2024",
      "createdAt": "2024-12-15T10:30:00",
      "thumbnail": "https://picsum.photos/320/180?random=1&keyword=victory",
      "isMyClip": false,
      "rating": 4.8,
      "size": "15.2 MB",
      "quality": "1080p",
      "uploaded": true,
    },
    {
      "id": 2,
      "title": "Perfect Drift Combo",
      "description": "360 degree drift around the corner - nailed it!",
      "game": "Racing Thunder",
      "category": "Skill Shot",
      "duration": 12,
      "views": 8900,
      "likes": 456,
      "comments": 23,
      "createdBy": "SpeedDemon",
      "createdAt": "2024-12-15T09:15:00",
      "thumbnail": "https://picsum.photos/320/180?random=2&keyword=racing",
      "isMyClip": false,
      "rating": 4.6,
      "size": "8.7 MB",
      "quality": "720p",
      "uploaded": true,
    },
    {
      "id": 3,
      "title": "My First Quadruple Kill",
      "description": "Can't believe I pulled this off!",
      "game": "Space Combat",
      "category": "Epic Win",
      "duration": 30,
      "views": 345,
      "likes": 67,
      "comments": 12,
      "createdBy": "You",
      "createdAt": "2024-12-15T08:45:00",
      "thumbnail": "https://picsum.photos/320/180?random=3&keyword=space",
      "isMyClip": true,
      "rating": 4.2,
      "size": "22.1 MB",
      "quality": "1080p",
      "uploaded": false,
    },
    {
      "id": 4,
      "title": "Hilarious Physics Bug",
      "description": "Character went flying across the map 😂",
      "game": "Battle Royale",
      "category": "Funny Moment",
      "duration": 8,
      "views": 45600,
      "likes": 2300,
      "comments": 234,
      "createdBy": "BugHunter",
      "createdAt": "2024-12-14T20:22:00",
      "thumbnail": "https://picsum.photos/320/180?random=4&keyword=funny",
      "isMyClip": false,
      "rating": 4.9,
      "size": "5.3 MB",
      "quality": "720p",
      "uploaded": true,
    },
    {
      "id": 5,
      "title": "Team Coordination Win",
      "description": "Perfect teamwork leads to comeback victory",
      "game": "Space Combat",
      "category": "Team Play",
      "duration": 67,
      "views": 6700,
      "likes": 334,
      "comments": 45,
      "createdBy": "TeamLeader",
      "createdAt": "2024-12-14T16:10:00",
      "thumbnail": "https://picsum.photos/320/180?random=5&keyword=team",
      "isMyClip": false,
      "rating": 4.5,
      "size": "38.9 MB",
      "quality": "1080p",
      "uploaded": true,
    },
    {
      "id": 6,
      "title": "Puzzle Solved in 3 Moves",
      "description": "Speed run tutorial for level 50",
      "game": "Puzzle Master",
      "category": "Tutorial",
      "duration": 15,
      "views": 2100,
      "likes": 145,
      "comments": 8,
      "createdBy": "You",
      "createdAt": "2024-12-14T14:30:00",
      "thumbnail": "https://picsum.photos/320/180?random=6&keyword=puzzle",
      "isMyClip": true,
      "rating": 4.3,
      "size": "12.8 MB",
      "quality": "720p",
      "uploaded": true,
    },
  ];

  List<Map<String, dynamic>> get filteredClips {
    var filtered = clipsList.where((clip) {
      bool matchesSearch = clip["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          clip["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || clip["category"] == selectedCategory;
      bool matchesGame = selectedGame == "All Games" || clip["game"] == selectedGame;
      bool matchesOwner = !showMyClips || clip["isMyClip"];
      return matchesSearch && matchesCategory && matchesGame && matchesOwner;
    }).toList();

    // Sort filtered clips
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Popular":
          return (b["likes"] as int).compareTo(a["likes"] as int);
        case "Most Viewed":
          return (b["views"] as int).compareTo(a["views"] as int);
        case "Highest Rated":
          return ((b["rating"] as double) * 100).toInt().compareTo(((a["rating"] as double) * 100).toInt());
        default:
          return DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"]));
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Clips"),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // Navigate to create clip
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
            // Stats overview
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${clipsList.where((c) => c["isMyClip"]).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "My Clips",
                          style: TextStyle(
                            fontSize: 14,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((clipsList.where((c) => c["isMyClip"]).map((c) => c["views"] as int).fold(0, (sum, views) => sum + views)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Views",
                          style: TextStyle(
                            fontSize: 14,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${clipsList.where((c) => c["isMyClip"]).map((c) => c["likes"] as int).fold(0, (sum, likes) => sum + likes)}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Total Likes",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search clips...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Game",
                          items: gamesList,
                          value: selectedGame,
                          onChanged: (value, label) {
                            selectedGame = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "My clips only",
                              "value": true,
                              "checked": showMyClips,
                            }
                          ],
                          value: [
                            if (showMyClips)
                              {
                                "label": "My clips only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showMyClips = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Clips list
            Text(
              "Clips (${filteredClips.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...filteredClips.map((clip) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video thumbnail
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${clip["thumbnail"]}",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Play button overlay
                          Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          // Duration badge
                          Positioned(
                            bottom: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${_formatDuration(clip["duration"] as int)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Quality badge
                          Positioned(
                            top: spXs,
                            left: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${clip["quality"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (clip["isMyClip"])
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "MY CLIP",
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
                    
                    // Clip details
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Title and rating
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${clip["title"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${clip["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          // Creator and game info
                          Row(
                            children: [
                              Text(
                                "by ${clip["createdBy"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${clip["game"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${clip["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Description
                          Text(
                            "${clip["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          // Stats row
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${_formatNumber(clip["views"] as int)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.thumb_up,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${clip["likes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.comment,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${clip["comments"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse(clip["createdAt"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // File info for own clips
                          if (clip["isMyClip"])
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Size: ${clip["size"]} • Quality: ${clip["quality"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  if (clip["uploaded"])
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "UPLOADED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "LOCAL",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          
                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Play",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              if (clip["isMyClip"]) ...[
                                QButton(
                                  icon: Icons.edit,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () async {
                                    bool isConfirmed = await confirm("Are you sure you want to delete this clip?");
                                    if (isConfirmed) {
                                      // Delete clip logic
                                      ss("Clip deleted successfully");
                                    }
                                  },
                                ),
                              ] else ...[
                                QButton(
                                  icon: Icons.thumb_up,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.comment,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to record new clip
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.videocam),
      ),
    );
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return "${minutes}:${remainingSeconds.toString().padLeft(2, '0')}";
    }
    return "${seconds}s";
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }
}
