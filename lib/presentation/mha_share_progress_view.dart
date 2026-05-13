import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaShareProgressView extends StatefulWidget {
  const MhaShareProgressView({super.key});

  @override
  State<MhaShareProgressView> createState() => _MhaShareProgressViewState();
}

class _MhaShareProgressViewState extends State<MhaShareProgressView> {
  int selectedTab = 0;
  String shareType = "Progress Update";
  String visibility = "Public";
  String caption = "";
  List<String> selectedImages = [];
  List<String> selectedMetrics = [];
  bool includeLocation = false;
  bool allowComments = true;
  String encouragementMessage = "";

  List<Map<String, dynamic>> shareTypes = [
    {"label": "Progress Update", "value": "progress"},
    {"label": "Achievement", "value": "achievement"},
    {"label": "Milestone", "value": "milestone"},
    {"label": "Workout Complete", "value": "workout"},
    {"label": "Health Goal", "value": "goal"},
    {"label": "Before/After", "value": "comparison"},
  ];

  List<Map<String, dynamic>> visibilityOptions = [
    {"label": "Public", "value": "public"},
    {"label": "Friends Only", "value": "friends"},
    {"label": "Groups", "value": "groups"},
    {"label": "Private", "value": "private"},
  ];

  List<Map<String, dynamic>> availableMetrics = [
    {"label": "Weight", "value": "weight", "unit": "kg", "current": "72.5"},
    {"label": "Body Fat %", "value": "body_fat", "unit": "%", "current": "18.2"},
    {"label": "Steps Today", "value": "steps", "unit": "steps", "current": "8,542"},
    {"label": "Calories Burned", "value": "calories", "unit": "cal", "current": "425"},
    {"label": "Heart Rate", "value": "heart_rate", "unit": "bpm", "current": "68"},
    {"label": "Sleep Hours", "value": "sleep", "unit": "hrs", "current": "7.5"},
    {"label": "Water Intake", "value": "water", "unit": "L", "current": "2.1"},
    {"label": "Blood Pressure", "value": "bp", "unit": "mmHg", "current": "120/80"},
  ];

  List<Map<String, dynamic>> recentPosts = [
    {
      "id": "1",
      "type": "achievement",
      "title": "Lost 10kg in 3 months!",
      "caption": "Finally reached my first major milestone! Feeling stronger and more confident than ever. Thank you to everyone for the support! 💪",
      "author": "Sarah Johnson",
      "authorAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "images": ["https://picsum.photos/400/300?random=10&keyword=fitness"],
      "metrics": ["weight", "body_fat"],
      "likes": 156,
      "comments": 23,
      "shares": 8,
      "createdAt": "2024-06-14T10:30:00Z",
      "visibility": "public",
    },
    {
      "id": "2",
      "type": "workout",
      "title": "Morning Run Complete! 🏃‍♀️",
      "caption": "5km done! Beautiful sunrise and perfect weather. Starting the day with endorphins always makes everything better!",
      "author": "Mike Chen",
      "authorAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "images": ["https://picsum.photos/400/300?random=11&keyword=running"],
      "metrics": ["steps", "calories"],
      "likes": 89,
      "comments": 12,
      "shares": 3,
      "createdAt": "2024-06-14T07:15:00Z",
      "visibility": "public",
    },
    {
      "id": "3",
      "type": "milestone",
      "title": "100 Days Smoke-Free! 🚭",
      "caption": "Can't believe it's been 100 days since my last cigarette. My breathing is so much better and I've saved over \$800!",
      "author": "Emma Wilson",
      "authorAvatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "images": [],
      "metrics": ["heart_rate", "bp"],
      "likes": 234,
      "comments": 45,
      "shares": 15,
      "createdAt": "2024-06-13T18:20:00Z",
      "visibility": "public",
    },
    {
      "id": "4",
      "type": "progress",
      "title": "Flexibility Progress Update",
      "caption": "6 months of yoga practice paying off! Still can't touch my toes easily, but look at this progress! 🧘‍♀️",
      "author": "Lisa Rodriguez",
      "authorAvatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "images": [
        "https://picsum.photos/400/300?random=12&keyword=yoga",
        "https://picsum.photos/400/300?random=13&keyword=stretch"
      ],
      "metrics": ["sleep"],
      "likes": 67,
      "comments": 18,
      "shares": 5,
      "createdAt": "2024-06-13T14:45:00Z",
      "visibility": "friends",
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "name": "Weight Loss Update",
      "type": "progress",
      "caption": "Another week, another step closer to my goal! 💪 #weightloss #progress #healthy",
      "metrics": ["weight", "body_fat"],
      "icon": Icons.trending_down,
    },
    {
      "name": "Workout Achievement",
      "type": "workout",
      "caption": "Just crushed my workout! Feeling stronger every day 🔥 #workout #fitness #strong",
      "metrics": ["calories", "heart_rate"],
      "icon": Icons.fitness_center,
    },
    {
      "name": "Healthy Habit",
      "type": "milestone",
      "caption": "Celebrating another milestone in my health journey! 🎉 #healthylifestyle #goals",
      "metrics": ["steps", "water"],
      "icon": Icons.emoji_events,
    },
    {
      "name": "Sleep Success",
      "type": "achievement",
      "caption": "Finally getting consistent 8 hours of sleep! Sleep is so underrated 😴 #sleep #recovery",
      "metrics": ["sleep", "heart_rate"],
      "icon": Icons.bedtime,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showSharingTips();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Share Templates
            Text(
              "Quick Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: templates.map((template) {
                return GestureDetector(
                  onTap: () {
                    _useTemplate(template);
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            template["icon"] as IconData,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Share Form
            Text(
              "Create Post",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Share Type and Visibility
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Post Type",
                    items: shareTypes,
                    value: shareType,
                    onChanged: (value, label) {
                      shareType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Visibility",
                    items: visibilityOptions,
                    value: visibility,
                    onChanged: (value, label) {
                      visibility = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Caption
            QMemoField(
              label: "Caption",
              value: caption,
              hint: "Share your thoughts, achievements, or progress...",
              onChanged: (value) {
                caption = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Images
            QMultiImagePicker(
              label: "Add Photos",
              value: selectedImages,
              hint: "Add before/after photos or progress pictures",
              maxImages: 4,
              onChanged: (value) {
                selectedImages = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Health Metrics Selection
            Text(
              "Include Health Metrics",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Select metrics to showcase with your post",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),

            // Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: availableMetrics.map((metric) {
                bool isSelected = selectedMetrics.contains(metric["value"]);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedMetrics.remove(metric["value"]);
                    } else {
                      selectedMetrics.add(metric["value"] as String);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledBoldColor.withAlpha(30),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${metric["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 16,
                              ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${metric["current"]} ${metric["unit"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Additional Options
            QSwitch(
              items: [
                {
                  "label": "Include Location",
                  "value": true,
                  "checked": includeLocation,
                }
              ],
              value: [if (includeLocation) {"label": "Include Location", "value": true, "checked": true}],
              onChanged: (values, ids) {
                includeLocation = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            QSwitch(
              items: [
                {
                  "label": "Allow Comments",
                  "value": true,
                  "checked": allowComments,
                }
              ],
              value: [if (allowComments) {"label": "Allow Comments", "value": true, "checked": true}],
              onChanged: (values, ids) {
                allowComments = values.isNotEmpty;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Encouragement Message
            QTextField(
              label: "Encouragement Message",
              value: encouragementMessage,
              hint: "Add a motivational message for others",
              onChanged: (value) {
                encouragementMessage = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Share Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Progress",
                size: bs.md,
                onPressed: () {
                  _shareProgress();
                },
              ),
            ),

            SizedBox(height: spLg),

            // Recent Posts
            Text(
              "Your Recent Posts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Posts List
            ...recentPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${post["authorAvatar"]}"),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${post["author"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(post["createdAt"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTypeColor(post["type"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${post["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: _getTypeColor(post["type"] as String),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: post["visibility"] == "public" 
                                ? primaryColor.withAlpha(20) 
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${post["visibility"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: post["visibility"] == "public" ? primaryColor : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Post Title
                    Text(
                      "${post["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),

                    // Post Caption
                    Text(
                      "${post["caption"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Images (if any)
                    if ((post["images"] as List).isNotEmpty)
                      Container(
                        height: 120,
                        child: QHorizontalScroll(
                          children: (post["images"] as List).map((imageUrl) {
                            return Container(
                              width: 160,
                              margin: EdgeInsets.only(right: spXs),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("$imageUrl"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    if ((post["images"] as List).isNotEmpty)
                      SizedBox(height: spSm),

                    // Metrics (if any)
                    if ((post["metrics"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        children: (post["metrics"] as List).map((metricValue) {
                          var metric = availableMetrics.firstWhere(
                            (m) => m["value"] == metricValue,
                            orElse: () => {"label": metricValue, "current": "N/A", "unit": ""},
                          );
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["label"]}: ${metric["current"]} ${metric["unit"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    if ((post["metrics"] as List).isNotEmpty)
                      SizedBox(height: spSm),

                    // Post Stats
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.comment_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["comments"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.share_outlined,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${post["shares"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _showPostOptions(post);
                          },
                          child: Icon(
                            Icons.more_vert,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'achievement':
        return warningColor;
      case 'milestone':
        return successColor;
      case 'workout':
        return infoColor;
      case 'progress':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    setState(() {
      shareType = template["type"];
      caption = template["caption"];
      selectedMetrics = List<String>.from(template["metrics"]);
    });
    ss("Template applied!");
  }

  void _shareProgress() {
    if (caption.isEmpty) {
      se("Please add a caption for your post");
      return;
    }

    ss("Progress shared successfully!");
    
    // Reset form
    setState(() {
      caption = "";
      selectedImages = [];
      selectedMetrics = [];
      encouragementMessage = "";
      includeLocation = false;
      allowComments = true;
    });
  }

  void _showSharingTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sharing Tips"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "• Be authentic and honest about your journey\n"
              "• Include specific details about what worked for you\n"
              "• Add encouraging messages to inspire others\n"
              "• Use relevant health metrics to show progress\n"
              "• Consider your privacy settings before posting\n"
              "• Engage with comments and support others",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: primaryColor),
              title: Text("Edit Post"),
              onTap: () {
                Navigator.pop(context);
                ss("Edit post feature coming soon");
              },
            ),
            ListTile(
              leading: Icon(Icons.visibility, color: infoColor),
              title: Text("Change Visibility"),
              onTap: () {
                Navigator.pop(context);
                _showVisibilityOptions(post);
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: successColor),
              title: Text("Share Again"),
              onTap: () {
                Navigator.pop(context);
                ss("Post shared!");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Post"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this post?");
                if (isConfirmed) {
                  ss("Post deleted");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVisibilityOptions(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Visibility"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: visibilityOptions.map((option) {
            return RadioListTile<String>(
              title: Text("${option["label"]}"),
              value: option["value"] as String,
              groupValue: post["visibility"] as String,
              onChanged: (value) {
                Navigator.pop(context);
                ss("Visibility changed to ${option["label"]}");
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
