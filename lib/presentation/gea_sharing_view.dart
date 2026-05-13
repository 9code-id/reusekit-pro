import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSharingView extends StatefulWidget {
  const GeaSharingView({super.key});

  @override
  State<GeaSharingView> createState() => _GeaSharingViewState();
}

class _GeaSharingViewState extends State<GeaSharingView> {
  int selectedTab = 0;
  String shareText = "";
  List<String> selectedPlatforms = [];

  List<Map<String, dynamic>> sharePlatforms = [
    {
      "name": "Discord",
      "icon": Icons.discord,
      "color": Colors.indigo,
      "enabled": true,
      "connected": true,
    },
    {
      "name": "Twitter",
      "icon": Icons.alternate_email,
      "color": Colors.blue,
      "enabled": true,
      "connected": true,
    },
    {
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Colors.blue[800]!,
      "enabled": true,
      "connected": false,
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": Colors.pink,
      "enabled": true,
      "connected": true,
    },
    {
      "name": "YouTube",
      "icon": Icons.play_circle,
      "color": Colors.red,
      "enabled": true,
      "connected": false,
    },
    {
      "name": "TikTok",
      "icon": Icons.music_video,
      "color": Colors.black,
      "enabled": true,
      "connected": false,
    },
  ];

  List<Map<String, dynamic>> recentShares = [
    {
      "id": "1",
      "type": "screenshot",
      "title": "Epic Victory!",
      "game": "Dragon's Quest",
      "platforms": ["Discord", "Twitter"],
      "timestamp": "2024-06-15T14:30:00",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=victory",
      "likes": 324,
      "comments": 45,
      "shares": 78,
    },
    {
      "id": "2",
      "type": "achievement",
      "title": "Level 50 Reached!",
      "game": "Space Warriors",
      "platforms": ["Discord"],
      "timestamp": "2024-06-15T12:15:00",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=achievement",
      "likes": 156,
      "comments": 23,
      "shares": 34,
    },
    {
      "id": "3",
      "type": "video",
      "title": "Amazing Boss Fight",
      "game": "Mystery Manor",
      "platforms": ["YouTube", "Twitter"],
      "timestamp": "2024-06-14T18:45:00",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=boss",
      "likes": 892,
      "comments": 156,
      "shares": 234,
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "name": "Victory Template",
      "description": "Perfect for sharing your wins",
      "preview": "🏆 Just achieved victory in {game}! {achievement} #Gaming #Victory",
      "tags": ["victory", "achievement", "gaming"],
    },
    {
      "id": "2",
      "name": "Level Up",
      "description": "Celebrate reaching new levels",
      "preview": "🎉 Level {level} reached in {game}! The journey continues... #LevelUp #Gaming",
      "tags": ["levelup", "progress", "gaming"],
    },
    {
      "id": "3",
      "name": "Funny Moment",
      "description": "Share those hilarious gaming moments",
      "preview": "😂 This just happened in {game}! You won't believe this... #Gaming #Funny",
      "tags": ["funny", "moment", "gaming"],
    },
    {
      "id": "4",
      "name": "Epic Gameplay",
      "description": "For showcasing amazing gameplay",
      "preview": "🔥 Check out this epic gameplay from {game}! What do you think? #Epic #Gaming",
      "tags": ["epic", "gameplay", "showcase"],
    },
  ];

  void _shareContent() async {
    if (shareText.isEmpty) {
      se("Please add some text to share");
      return;
    }
    
    if (selectedPlatforms.isEmpty) {
      se("Please select at least one platform");
      return;
    }
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    setState(() {
      recentShares.insert(0, {
        "id": "${recentShares.length + 1}",
        "type": "text",
        "title": shareText.length > 20 ? "${shareText.substring(0, 20)}..." : shareText,
        "game": "Current Game",
        "platforms": List.from(selectedPlatforms),
        "timestamp": DateTime.now().toIso8601String(),
        "thumbnail": "https://picsum.photos/300/200?random=${recentShares.length + 4}&keyword=gaming",
        "likes": 0,
        "comments": 0,
        "shares": 0,
      });
    });
    
    shareText = "";
    selectedPlatforms.clear();
    ss("Content shared successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share & Connect"),
        actions: [
          QButton(
            icon: Icons.history,
            size: bs.sm,
            onPressed: () {
              si("View sharing history");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          bottomLeft: Radius.circular(radiusSm),
                        ),
                        border: Border.all(
                          color: selectedTab == 0 ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Create Share",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        border: Border.all(
                          color: selectedTab == 1 ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Recent Shares",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radiusSm),
                          bottomRight: Radius.circular(radiusSm),
                        ),
                        border: Border.all(
                          color: selectedTab == 2 ? primaryColor : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Platforms",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildTabContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildCreateShareTab();
      case 1:
        return _buildRecentSharesTab();
      case 2:
        return _buildPlatformsTab();
      default:
        return _buildCreateShareTab();
    }
  }

  Widget _buildCreateShareTab() {
    return Column(
      spacing: spMd,
      children: [
        // Share Text Input
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Create Your Share",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              QMemoField(
                label: "What's happening in your game?",
                value: shareText,
                hint: "Share your gaming moment, achievement, or thoughts...",
                onChanged: (value) {
                  shareText = value;
                  setState(() {});
                },
              ),
              Text(
                "${shareText.length}/280 characters",
                style: TextStyle(
                  fontSize: 10,
                  color: shareText.length > 250 ? dangerColor : disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        // Templates
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Quick Templates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Choose a template to get started quickly",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              ...List.generate(templates.length, (index) {
                final template = templates[index];
                return GestureDetector(
                  onTap: () {
                    shareText = template["preview"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: disabledBoldColor,
                              size: 12,
                            ),
                          ],
                        ),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${template["preview"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Platform Selection
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.share,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Select Platforms",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: sharePlatforms.where((platform) => platform["connected"] as bool).map((platform) {
                  final isSelected = selectedPlatforms.contains(platform["name"]);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedPlatforms.remove(platform["name"]);
                      } else {
                        selectedPlatforms.add(platform["name"]);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (platform["color"] as Color).withAlpha(25)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected 
                              ? platform["color"] as Color
                              : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            platform["icon"] as IconData,
                            color: isSelected 
                                ? platform["color"] as Color
                                : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${platform["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected 
                                  ? platform["color"] as Color
                                  : disabledBoldColor,
                            ),
                          ),
                          if (isSelected) ...[
                            SizedBox(width: spXs),
                            Icon(
                              Icons.check_circle,
                              color: platform["color"] as Color,
                              size: 14,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Share Button
        Container(
          width: double.infinity,
          child: QButton(
            label: "Share Now",
            size: bs.md,
            onPressed: _shareContent,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSharesTab() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Recent Shares",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${recentShares.length} shares",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              ...List.generate(recentShares.length, (index) {
                final share = recentShares[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${share["thumbnail"]}",
                          width: 60,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${share["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${share["game"]} • ${DateTime.parse(share["timestamp"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                ...(share["platforms"] as List<String>).take(3).map((platform) {
                                  final platformData = sharePlatforms.firstWhere(
                                    (p) => p["name"] == platform,
                                    orElse: () => {"name": platform, "color": Colors.grey},
                                  );
                                  return Container(
                                    margin: EdgeInsets.only(right: 4),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (platformData["color"] as Color).withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      platform,
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: platformData["color"] as Color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${share["likes"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.comment,
                                  color: primaryColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${share["comments"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.share,
                                  color: successColor,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${share["shares"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("More options for ${share["title"]}");
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformsTab() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Connected Platforms",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Manage your social media connections",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              ...List.generate(sharePlatforms.length, (index) {
                final platform = sharePlatforms[index];
                final isConnected = platform["connected"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isConnected 
                        ? (platform["color"] as Color).withAlpha(25)
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isConnected 
                          ? platform["color"] as Color
                          : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (platform["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          platform["icon"] as IconData,
                          color: platform["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${platform["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              isConnected 
                                  ? "Connected and ready to share"
                                  : "Connect to share content",
                              style: TextStyle(
                                fontSize: 12,
                                color: isConnected ? successColor : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isConnected) ...[
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Disconnect",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              platform["connected"] = false;
                            });
                            sw("Disconnected from ${platform["name"]}");
                          },
                        ),
                      ] else ...[
                        QButton(
                          label: "Connect",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              platform["connected"] = true;
                            });
                            ss("Connected to ${platform["name"]}!");
                          },
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
