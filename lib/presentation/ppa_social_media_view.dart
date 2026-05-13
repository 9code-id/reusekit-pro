import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaSocialMediaView extends StatefulWidget {
  const PpaSocialMediaView({super.key});

  @override
  State<PpaSocialMediaView> createState() => _PpaSocialMediaViewState();
}

class _PpaSocialMediaViewState extends State<PpaSocialMediaView> {
  String selectedPlatform = "Instagram";
  String postCaption = "";
  bool addWatermark = false;
  bool autoHashtags = true;
  String selectedAspectRatio = "Square (1:1)";
  
  List<Map<String, dynamic>> platforms = [
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": Color(0xFFE4405F),
      "connected": true,
      "followers": "2.5K",
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Color(0xFF1877F2),
      "connected": true,
      "followers": "1.8K",
    },
    {
      "name": "Twitter",
      "icon": Icons.flutter_dash,
      "color": Color(0xFF1DA1F2),
      "connected": false,
      "followers": "0",
    },
    {
      "name": "TikTok",
      "icon": Icons.music_video,
      "color": Color(0xFF000000),
      "connected": false,
      "followers": "0",
    },
    {
      "name": "Pinterest",
      "icon": Icons.push_pin,
      "color": Color(0xFFBD081C),
      "connected": true,
      "followers": "950",
    },
    {
      "name": "LinkedIn",
      "icon": Icons.work,
      "color": Color(0xFF0A66C2),
      "connected": false,
      "followers": "0",
    },
  ];

  List<Map<String, dynamic>> aspectRatios = [
    {"label": "Square (1:1)", "value": "Square (1:1)"},
    {"label": "Portrait (4:5)", "value": "Portrait (4:5)"},
    {"label": "Landscape (16:9)", "value": "Landscape (16:9)"},
    {"label": "Story (9:16)", "value": "Story (9:16)"},
    {"label": "Original", "value": "Original"},
  ];

  List<Map<String, dynamic>> recentPosts = [
    {
      "id": "post_001",
      "platform": "Instagram",
      "caption": "Beautiful sunset at the beach 🌅 #photography #sunset",
      "photoCount": 3,
      "publishDate": "2024-06-16",
      "publishTime": "6:30 PM",
      "status": "Published",
      "likes": 245,
      "comments": 18,
      "shares": 12,
    },
    {
      "id": "post_002",
      "platform": "Facebook",
      "caption": "Weekend family gathering memories 📸 #family #weekend",
      "photoCount": 8,
      "publishDate": "2024-06-15",
      "publishTime": "2:15 PM",
      "status": "Published",
      "likes": 89,
      "comments": 25,
      "shares": 7,
    },
    {
      "id": "post_003",
      "platform": "Pinterest",
      "caption": "Wedding photography inspiration ✨ #wedding #photography",
      "photoCount": 1,
      "publishDate": "2024-06-14",
      "publishTime": "10:00 AM",
      "status": "Scheduled",
      "likes": 0,
      "comments": 0,
      "shares": 0,
    },
  ];

  List<String> suggestedHashtags = [
    "#photography", "#photooftheday", "#instagood", "#picoftheday",
    "#nature", "#beautiful", "#love", "#happy", "#art", "#life"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              _showSchedulePost();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSocialSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.share,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Social Media Manager",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Share your photos across multiple social media platforms",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Connected Accounts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: platforms.map((platform) {
                return _buildPlatformCard(platform);
              }).toList(),
            ),

            Text(
              "Create Post",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
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
                        child: QButton(
                          label: "Select Photos",
                          size: bs.md,
                          icon: Icons.photo_library,
                          onPressed: () {
                            _selectPhotosForPost();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "3 selected",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Platform",
                    items: platforms
                        .where((p) => p["connected"] == true)
                        .map((p) => {"label": p["name"], "value": p["name"]})
                        .toList(),
                    value: selectedPlatform,
                    onChanged: (value, label) {
                      selectedPlatform = value;
                      setState(() {});
                    },
                  ),

                  QDropdownField(
                    label: "Aspect Ratio",
                    items: aspectRatios,
                    value: selectedAspectRatio,
                    onChanged: (value, label) {
                      selectedAspectRatio = value;
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Caption",
                    value: postCaption,
                    hint: "Write your post caption...",
                    onChanged: (value) {
                      postCaption = value;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Auto Hashtags",
                    items: [
                      {
                        "label": "Add suggested hashtags automatically",
                        "value": true,
                        "checked": autoHashtags,
                      }
                    ],
                    value: [
                      if (autoHashtags)
                        {
                          "label": "Add suggested hashtags automatically",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoHashtags = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    label: "Add Watermark",
                    items: [
                      {
                        "label": "Add watermark to photos",
                        "value": true,
                        "checked": addWatermark,
                      }
                    ],
                    value: [
                      if (addWatermark)
                        {
                          "label": "Add watermark to photos",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      addWatermark = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            if (autoHashtags) ...[
              Text(
                "Suggested Hashtags",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: suggestedHashtags.map((hashtag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Text(
                      hashtag,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Post Now",
                    size: bs.md,
                    icon: Icons.send,
                    onPressed: () {
                      _postNow();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule",
                    size: bs.md,
                    icon: Icons.schedule,
                    onPressed: () {
                      _showSchedulePost();
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Recent Posts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentPosts.length,
              itemBuilder: (context, index) {
                final post = recentPosts[index];
                return _buildPostCard(post);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCard(Map<String, dynamic> platform) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: platform["connected"] 
              ? (platform["color"] as Color).withAlpha(50)
              : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (platform["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  platform["icon"],
                  color: platform["color"],
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: platform["connected"] 
                      ? successColor.withAlpha(20)
                      : disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  platform["connected"] ? "Connected" : "Disconnected",
                  style: TextStyle(
                    color: platform["connected"] ? successColor : disabledBoldColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${platform["name"]}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          if (platform["connected"]) ...[
            Text(
              "${platform["followers"]} followers",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ] else ...[
            Text(
              "Not connected",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: platform["connected"] ? "Disconnect" : "Connect",
              size: bs.sm,
              onPressed: () {
                _togglePlatformConnection(platform["name"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    Color statusColor = post["status"] == "Published" ? successColor : warningColor;
    Color platformColor = _getPlatformColor(post["platform"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: platformColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getPlatformIcon(post["platform"]),
                color: platformColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${post["platform"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${post["publishDate"]} at ${post["publishTime"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${post["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${post["caption"]}",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.photo,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${post["photoCount"]} photos",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              if (post["status"] == "Published") ...[
                Spacer(),
                Text(
                  "❤️ ${post["likes"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "💬 ${post["comments"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "🔗 ${post["shares"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              QButton(
                label: "View",
                size: bs.sm,
                icon: Icons.visibility,
                onPressed: () {
                  _viewPost(post["id"]);
                },
              ),
              SizedBox(width: spSm),
              if (post["status"] == "Scheduled") ...[
                QButton(
                  label: "Edit",
                  size: bs.sm,
                  icon: Icons.edit,
                  onPressed: () {
                    _editScheduledPost(post["id"]);
                  },
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                label: "Repost",
                size: bs.sm,
                icon: Icons.repeat,
                onPressed: () {
                  _repost(post["id"]);
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _deletePost(post["id"]);
                },
                child: Icon(
                  Icons.delete,
                  color: dangerColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case "Instagram":
        return Color(0xFFE4405F);
      case "Facebook":
        return Color(0xFF1877F2);
      case "Twitter":
        return Color(0xFF1DA1F2);
      case "Pinterest":
        return Color(0xFFBD081C);
      default:
        return primaryColor;
    }
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case "Instagram":
        return Icons.camera_alt;
      case "Facebook":
        return Icons.facebook;
      case "Twitter":
        return Icons.flutter_dash;
      case "Pinterest":
        return Icons.push_pin;
      default:
        return Icons.share;
    }
  }

  void _selectPhotosForPost() {
    ss("3 photos selected for social media post");
  }

  void _postNow() {
    if (postCaption.isEmpty) {
      se("Please add a caption before posting");
      return;
    }
    
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Posted to $selectedPlatform successfully!");
    });
  }

  void _showSchedulePost() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Schedule Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDatePicker(
                label: "Publish Date",
                value: DateTime.now().add(Duration(days: 1)),
                onChanged: (value) {},
              ),
              SizedBox(height: spSm),
              QTimePicker(
                label: "Publish Time",
                value: TimeOfDay.now(),
                onChanged: (value) {},
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Schedule",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Post scheduled successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showSocialSettings() {
    si("Opening social media settings");
  }

  void _togglePlatformConnection(String platformName) {
    ss("$platformName connection toggled");
  }

  void _viewPost(String postId) {
    si("Viewing post details");
  }

  void _editScheduledPost(String postId) {
    si("Editing scheduled post");
  }

  void _repost(String postId) {
    si("Reposting to social media");
  }

  void _deletePost(String postId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this post?");
    if (isConfirmed) {
      ss("Post deleted successfully");
    }
  }
}
