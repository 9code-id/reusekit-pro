import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaVideoPlaylistView extends StatefulWidget {
  const NmaVideoPlaylistView({super.key});

  @override
  State<NmaVideoPlaylistView> createState() => _NmaVideoPlaylistViewState();
}

class _NmaVideoPlaylistViewState extends State<NmaVideoPlaylistView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool isLoading = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "My Playlists", "value": "My Playlists"},
    {"label": "Favorites", "value": "Favorites"},
    {"label": "Watch Later", "value": "Watch Later"},
    {"label": "Recently Created", "value": "Recently Created"},
  ];

  List<Map<String, dynamic>> playlists = [
    {
      "id": "1",
      "title": "Marketing Fundamentals",
      "description": "Essential marketing concepts and strategies for beginners",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=marketing",
      "videoCount": 12,
      "totalDuration": "4h 25m",
      "isPublic": true,
      "createdDate": "2024-01-01",
      "updatedDate": "2024-01-10",
      "views": 2450,
      "likes": 89,
      "creator": "You",
      "videos": [
        {
          "id": "v1",
          "title": "Introduction to Marketing",
          "duration": "15:30",
          "thumbnail": "https://picsum.photos/160/90?random=11&keyword=intro",
        },
        {
          "id": "v2", 
          "title": "Target Audience Analysis",
          "duration": "22:45",
          "thumbnail": "https://picsum.photos/160/90?random=12&keyword=audience",
        },
        {
          "id": "v3",
          "title": "Content Strategy Basics",
          "duration": "18:20",
          "thumbnail": "https://picsum.photos/160/90?random=13&keyword=content",
        },
      ],
    },
    {
      "id": "2",
      "title": "Advanced SEO Techniques",
      "description": "Deep dive into advanced search engine optimization strategies",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=seo",
      "videoCount": 8,
      "totalDuration": "3h 12m",
      "isPublic": false,
      "createdDate": "2024-01-05",
      "updatedDate": "2024-01-12",
      "views": 1230,
      "likes": 45,
      "creator": "You",
      "videos": [
        {
          "id": "v4",
          "title": "Technical SEO Audit",
          "duration": "28:15",
          "thumbnail": "https://picsum.photos/160/90?random=14&keyword=audit",
        },
        {
          "id": "v5",
          "title": "Link Building Strategies",
          "duration": "24:30",
          "thumbnail": "https://picsum.photos/160/90?random=15&keyword=links",
        },
      ],
    },
    {
      "id": "3",
      "title": "Social Media Mastery",
      "description": "Complete guide to social media marketing across all platforms",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=social",
      "videoCount": 15,
      "totalDuration": "6h 18m",
      "isPublic": true,
      "createdDate": "2023-12-20",
      "updatedDate": "2024-01-08",
      "views": 3850,
      "likes": 152,
      "creator": "Sarah Johnson",
      "videos": [
        {
          "id": "v6",
          "title": "Instagram Marketing 2024",
          "duration": "32:45",
          "thumbnail": "https://picsum.photos/160/90?random=16&keyword=instagram",
        },
        {
          "id": "v7",
          "title": "TikTok for Business",
          "duration": "19:20",
          "thumbnail": "https://picsum.photos/160/90?random=17&keyword=tiktok",
        },
        {
          "id": "v8",
          "title": "LinkedIn Strategy",
          "duration": "25:15",
          "thumbnail": "https://picsum.photos/160/90?random=18&keyword=linkedin",
        },
      ],
    },
    {
      "id": "4",
      "title": "Watch Later",
      "description": "Videos saved for later viewing",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=watch",
      "videoCount": 23,
      "totalDuration": "8h 45m",
      "isPublic": false,
      "createdDate": "2024-01-01",
      "updatedDate": "2024-01-13",
      "views": 0,
      "likes": 0,
      "creator": "You",
      "videos": [],
    },
    {
      "id": "5",
      "title": "Content Creation Workshop",
      "description": "Hands-on content creation techniques and tools",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=creation",
      "videoCount": 10,
      "totalDuration": "4h 55m",
      "isPublic": true,
      "createdDate": "2024-01-03",
      "updatedDate": "2024-01-11",
      "views": 1895,
      "likes": 67,
      "creator": "Mike Chen",
      "videos": [
        {
          "id": "v9",
          "title": "Video Editing Basics",
          "duration": "35:12",
          "thumbnail": "https://picsum.photos/160/90?random=19&keyword=editing",
        },
        {
          "id": "v10",
          "title": "Thumbnail Design Tips",
          "duration": "18:45",
          "thumbnail": "https://picsum.photos/160/90?random=20&keyword=thumbnail",
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPlaylists();
  }

  void _loadPlaylists() {
    isLoading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
  }

  List<Map<String, dynamic>> get filteredPlaylists {
    var filtered = playlists;
    
    if (selectedCategory != "All") {
      if (selectedCategory == "My Playlists") {
        filtered = filtered.where((playlist) => playlist["creator"] == "You").toList();
      } else if (selectedCategory == "Favorites") {
        filtered = filtered.where((playlist) => (playlist["likes"] as int) > 50).toList();
      } else if (selectedCategory == "Watch Later") {
        filtered = filtered.where((playlist) => playlist["title"] == "Watch Later").toList();
      } else if (selectedCategory == "Recently Created") {
        filtered = filtered.where((playlist) => 
          DateTime.parse(playlist["createdDate"] as String)
            .isAfter(DateTime.now().subtract(Duration(days: 14)))
        ).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((playlist) => 
        (playlist["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (playlist["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (playlist["creator"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Playlists"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Create new playlist
              _showCreatePlaylistDialog();
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Search and Filter
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search playlists...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.sort,
                        size: bs.sm,
                        onPressed: () {
                          // Show sort options
                        },
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter Playlists",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Stats Overview
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Playlists",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${playlists.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Total Videos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${playlists.map((p) => p["videoCount"] as int).reduce((a, b) => a + b)}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "My Playlists",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${playlists.where((p) => p["creator"] == "You").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Playlists List
                  Text(
                    "Playlists (${filteredPlaylists.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredPlaylists.length,
                    itemBuilder: (context, index) {
                      final playlist = filteredPlaylists[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${playlist["thumbnail"]}",
                              width: 80,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${playlist["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (playlist["isPublic"] == true)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "PUBLIC",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: successColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "PRIVATE",
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: warningColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${playlist["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: spXs),
                            child: Row(
                              children: [
                                Text(
                                  "${playlist["videoCount"]} videos",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${playlist["totalDuration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "by ${playlist["creator"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              _showPlaylistOptions(playlist);
                            },
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spSm,
                                children: [
                                  // Playlist Stats
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Views",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${playlist["views"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Likes",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${playlist["likes"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Updated",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${playlist["updatedDate"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Video Preview (if available)
                                  if ((playlist["videos"] as List).isNotEmpty) ...[
                                    Text(
                                      "Preview Videos",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (playlist["videos"] as List).length,
                                        itemBuilder: (context, videoIndex) {
                                          final video = (playlist["videos"] as List)[videoIndex];
                                          return Container(
                                            width: 160,
                                            margin: EdgeInsets.only(right: spSm),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(10),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(radiusXs),
                                                    topRight: Radius.circular(radiusXs),
                                                  ),
                                                  child: Image.network(
                                                    "${video["thumbnail"]}",
                                                    width: 160,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(spXs),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${video["title"]}",
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: primaryColor,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Text(
                                                        "${video["duration"]}",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: disabledBoldColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "Play All",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Play all videos in playlist
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.shuffle,
                                        size: bs.sm,
                                        onPressed: () {
                                          // Shuffle playlist
                                        },
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        onPressed: () {
                                          // Share playlist
                                        },
                                      ),
                                      if (playlist["creator"] == "You") ...[
                                        SizedBox(width: spSm),
                                        QButton(
                                          icon: Icons.edit,
                                          size: bs.sm,
                                          onPressed: () {
                                            // Edit playlist
                                          },
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
                    },
                  ),
                ],
              ),
            ),
    );
  }

  void _showCreatePlaylistDialog() {
    String playlistName = "";
    String playlistDescription = "";
    bool isPublic = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Playlist"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Playlist Name",
              value: playlistName,
              onChanged: (value) {
                playlistName = value;
              },
            ),
            QTextField(
              label: "Description",
              value: playlistDescription,
              onChanged: (value) {
                playlistDescription = value;
              },
            ),
            QSwitch(
              items: [
                {
                  "label": "Make playlist public",
                  "value": true,
                  "checked": isPublic,
                }
              ],
              value: [if (isPublic) {"label": "Make playlist public", "value": true, "checked": true}],
              onChanged: (values, ids) {
                isPublic = values.isNotEmpty;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (playlistName.isNotEmpty) {
                Navigator.pop(context);
                ss("Playlist created successfully!");
              }
            },
          ),
        ],
      ),
    );
  }

  void _showPlaylistOptions(Map<String, dynamic> playlist) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${playlist["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Play All",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                // Play all videos
              },
            ),
            QButton(
              label: "Share Playlist",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                // Share playlist
              },
            ),
            if (playlist["creator"] == "You") ...[
              QButton(
                label: "Edit Playlist",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  // Edit playlist
                },
              ),
              QButton(
                label: "Delete Playlist",
                size: bs.md,
                onPressed: () async {
                  Navigator.pop(context);
                  bool isConfirmed = await confirm("Are you sure you want to delete this playlist?");
                  if (isConfirmed) {
                    setState(() {
                      playlists.removeWhere((p) => p["id"] == playlist["id"]);
                    });
                    ss("Playlist deleted successfully!");
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
