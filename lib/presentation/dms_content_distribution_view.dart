import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentDistributionView extends StatefulWidget {
  const DmsContentDistributionView({super.key});

  @override
  State<DmsContentDistributionView> createState() => _DmsContentDistributionViewState();
}

class _DmsContentDistributionViewState extends State<DmsContentDistributionView> {
  int currentTab = 0;
  String selectedContent = "";
  bool autoPost = true;
  bool optimizeForPlatform = true;
  
  List<Map<String, dynamic>> contentOptions = [
    {"label": "10 Digital Marketing Trends for 2024", "value": "1"},
    {"label": "Complete Guide to Social Media Analytics", "value": "2"},
    {"label": "Customer Success Case Study - TechCorp", "value": "3"},
    {"label": "Email Marketing Best Practices 2024", "value": "4"},
  ];

  List<Map<String, dynamic>> distributionChannels = [
    {
      "id": 1,
      "name": "Facebook",
      "platform": "facebook",
      "icon": Icons.facebook,
      "color": Color(0xFF1877F2),
      "connected": true,
      "followers": 12450,
      "enabled": true,
      "postTime": "09:00",
      "customMessage": "",
      "lastPost": "2024-01-15",
      "engagement": 78.5,
      "autoOptimize": true,
    },
    {
      "id": 2,
      "name": "Twitter",
      "platform": "twitter",
      "icon": Icons.alternate_email,
      "color": Color(0xFF1DA1F2),
      "connected": true,
      "followers": 8920,
      "enabled": true,
      "postTime": "10:30",
      "customMessage": "",
      "lastPost": "2024-01-14",
      "engagement": 65.2,
      "autoOptimize": true,
    },
    {
      "id": 3,
      "name": "LinkedIn",
      "platform": "linkedin",
      "icon": Icons.work,
      "color": Color(0xFF0A66C2),
      "connected": true,
      "followers": 15670,
      "enabled": true,
      "postTime": "08:00",
      "customMessage": "",
      "lastPost": "2024-01-13",
      "engagement": 89.1,
      "autoOptimize": true,
    },
    {
      "id": 4,
      "name": "Instagram",
      "platform": "instagram",
      "icon": Icons.photo_camera,
      "color": Color(0xFFE4405F),
      "connected": false,
      "followers": 0,
      "enabled": false,
      "postTime": "12:00",
      "customMessage": "",
      "lastPost": null,
      "engagement": 0.0,
      "autoOptimize": false,
    },
    {
      "id": 5,
      "name": "YouTube",
      "platform": "youtube",
      "icon": Icons.play_circle,
      "color": Color(0xFFFF0000),
      "connected": true,
      "followers": 5430,
      "enabled": false,
      "postTime": "16:00",
      "customMessage": "",
      "lastPost": "2024-01-10",
      "engagement": 45.8,
      "autoOptimize": false,
    },
  ];

  List<Map<String, dynamic>> distributionQueue = [
    {
      "id": 1,
      "title": "10 Digital Marketing Trends for 2024",
      "platforms": ["Facebook", "Twitter", "LinkedIn"],
      "scheduledTime": "2024-01-20 09:00",
      "status": "scheduled",
      "estimatedReach": 35640,
    },
    {
      "id": 2,
      "title": "Email Marketing Best Practices 2024",
      "platforms": ["LinkedIn", "Twitter"],
      "scheduledTime": "2024-01-21 10:30",
      "status": "scheduled",
      "estimatedReach": 24590,
    },
    {
      "id": 3,
      "title": "Customer Success Case Study - TechCorp",
      "platforms": ["Facebook", "LinkedIn"],
      "scheduledTime": "2024-01-22 08:00",
      "status": "pending",
      "estimatedReach": 28120,
    },
  ];

  List<Map<String, dynamic>> recentDistributions = [
    {
      "title": "Complete Guide to Social Media Analytics",
      "platforms": ["Facebook", "Twitter", "LinkedIn"],
      "publishedTime": "2024-01-15 09:00",
      "totalReach": 42500,
      "totalEngagement": 1250,
      "status": "completed",
    },
    {
      "title": "Customer Success Case Study - TechCorp",
      "platforms": ["LinkedIn", "Twitter"],
      "publishedTime": "2024-01-13 08:00",
      "totalReach": 28900,
      "totalEngagement": 890,
      "status": "completed",
    },
  ];

  void _connectPlatform(String platform) {
    int index = distributionChannels.indexWhere((channel) => channel["platform"] == platform);
    if (index != -1) {
      distributionChannels[index]["connected"] = true;
      distributionChannels[index]["followers"] = 1000; // Demo value
      setState(() {});
      ss("$platform connected successfully");
    }
  }

  void _toggleChannel(int id) {
    int index = distributionChannels.indexWhere((channel) => channel["id"] == id);
    if (index != -1) {
      distributionChannels[index]["enabled"] = !(distributionChannels[index]["enabled"] as bool);
      setState(() {});
    }
  }

  void _scheduleDistribution() {
    ss("Content scheduled for distribution");
  }

  void _distributeNow() {
    ss("Content distribution started");
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Distribution",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Distribute", icon: Icon(Icons.send)),
        Tab(text: "Channels", icon: Icon(Icons.share)),
        Tab(text: "Queue", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildDistributeTab(),
        _buildChannelsTab(),
        _buildQueueTab(),
      ],
    );
  }

  Widget _buildDistributeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Distribution Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.send, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Content Distribution",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Share your content across multiple platforms",
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
          ),

          // Content Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QDropdownField(
                  label: "Choose Content to Distribute",
                  items: contentOptions,
                  value: selectedContent,
                  onChanged: (value, label) {
                    selectedContent = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Auto-post when content is published",
                            "value": true,
                            "checked": autoPost,
                          }
                        ],
                        value: [
                          if (autoPost)
                            {
                              "label": "Auto-post when content is published",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          autoPost = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Optimize content for each platform",
                            "value": true,
                            "checked": optimizeForPlatform,
                          }
                        ],
                        value: [
                          if (optimizeForPlatform)
                            {
                              "label": "Optimize content for each platform",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          optimizeForPlatform = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Platform Selection
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Platforms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...distributionChannels
                    .where((channel) => channel["connected"] == true)
                    .map((channel) => _buildPlatformSelector(channel)),
              ],
            ),
          ),

          // Distribution Actions
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
                        label: "Schedule Distribution",
                        icon: Icons.schedule,
                        size: bs.md,
                        onPressed: _scheduleDistribution,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Distribute Now",
                        icon: Icons.send,
                        size: bs.md,
                        onPressed: _distributeNow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Distributions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Distributions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ...recentDistributions.map((distribution) => _buildDistributionHistory(distribution)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Channels Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildChannelStat("Connected", "${distributionChannels.where((c) => c["connected"] == true).length}", Icons.link, successColor),
              _buildChannelStat("Active", "${distributionChannels.where((c) => c["enabled"] == true).length}", Icons.check_circle, primaryColor),
              _buildChannelStat("Total Reach", "37K", Icons.visibility, infoColor),
              _buildChannelStat("Avg Engagement", "77.6%", Icons.favorite, warningColor),
            ],
          ),

          // Platform Management
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.share, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Platform Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Connect and manage your social media accounts",
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
          ),

          // Channels List
          ...distributionChannels.map((channel) => _buildChannelCard(channel)),
        ],
      ),
    );
  }

  Widget _buildQueueTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Queue Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Distribution Queue",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Manage scheduled content distributions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Clear Queue",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Queue Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQueueStat("Scheduled", "${distributionQueue.where((q) => q["status"] == "scheduled").length}", Icons.schedule, primaryColor),
              _buildQueueStat("Pending", "${distributionQueue.where((q) => q["status"] == "pending").length}", Icons.pending, warningColor),
              _buildQueueStat("Est. Reach", "88.4K", Icons.people, successColor),
              _buildQueueStat("Next Post", "2h 45m", Icons.timer, infoColor),
            ],
          ),

          // Queue Items
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Scheduled Distributions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...distributionQueue.map((item) => _buildQueueItem(item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelector(Map<String, dynamic> channel) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: (channel["enabled"] as bool) ? (channel["color"] as Color).withAlpha(10) : Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: (channel["enabled"] as bool) ? (channel["color"] as Color).withAlpha(30) : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            channel["icon"] as IconData,
            color: channel["color"] as Color,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${channel["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${(channel["followers"] as int).toString()} followers • ${(channel["engagement"] as double).toStringAsFixed(1)}% engagement",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: channel["enabled"] as bool,
            onChanged: (value) => _toggleChannel(channel["id"] as int),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelCard(Map<String, dynamic> channel) {
    bool isConnected = channel["connected"] as bool;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (channel["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              channel["icon"] as IconData,
              color: channel["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${channel["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: isConnected ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        isConnected ? "CONNECTED" : "DISCONNECTED",
                        style: TextStyle(
                          fontSize: 10,
                          color: isConnected ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isConnected) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${(channel["followers"] as int).toString()} followers • ${(channel["engagement"] as double).toStringAsFixed(1)}% avg engagement",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (channel["lastPost"] != null)
                    Text(
                      "Last post: ${channel["lastPost"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                ] else ...[
                  SizedBox(height: spXs),
                  Text(
                    "Connect your ${channel["name"]} account to start distributing content",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              if (isConnected) ...[
                Switch(
                  value: channel["enabled"] as bool,
                  onChanged: (value) => _toggleChannel(channel["id"] as int),
                ),
              ] else ...[
                QButton(
                  label: "Connect",
                  size: bs.sm,
                  onPressed: () => _connectPlatform(channel["platform"] as String),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionHistory(Map<String, dynamic> distribution) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${distribution["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              ...(distribution["platforms"] as List<String>).map((platform) => Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  platform,
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${distribution["publishedTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(distribution["totalReach"] as int).toString()} reach • ${(distribution["totalEngagement"] as int).toString()} engagements",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> item) {
    Color statusColor = item["status"] == "scheduled" ? successColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${item["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              ...(item["platforms"] as List<String>).map((platform) => Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  platform,
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${item["scheduledTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Est. reach: ${(item["estimatedReach"] as int).toString()}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
