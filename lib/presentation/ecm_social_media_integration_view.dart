import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSocialMediaIntegrationView extends StatefulWidget {
  const EcmSocialMediaIntegrationView({super.key});

  @override
  State<EcmSocialMediaIntegrationView> createState() => _EcmSocialMediaIntegrationViewState();
}

class _EcmSocialMediaIntegrationViewState extends State<EcmSocialMediaIntegrationView> {
  int currentTab = 0;
  
  // Social Media Platform Data
  List<Map<String, dynamic>> socialPlatforms = [
    {
      "id": "fb",
      "name": "Facebook",
      "icon": Icons.facebook,
      "color": Color(0xFF1877F2),
      "connected": true,
      "followers": 145000,
      "engagement": 4.2,
      "posts": 256,
      "lastPost": "2024-01-15T10:30:00Z",
      "accessToken": "fb_token_xxxxx",
      "pageId": "EventMasters2024",
    },
    {
      "id": "ig",
      "name": "Instagram", 
      "icon": Icons.camera_alt,
      "color": Color(0xFFE4405F),
      "connected": true,
      "followers": 89000,
      "engagement": 6.8,
      "posts": 342,
      "lastPost": "2024-01-15T14:22:00Z",
      "accessToken": "ig_token_xxxxx",
      "pageId": "eventmasters_official",
    },
    {
      "id": "tw",
      "name": "Twitter",
      "icon": Icons.alternate_email,
      "color": Color(0xFF1DA1F2),
      "connected": true,
      "followers": 67000,
      "engagement": 3.4,
      "posts": 1205,
      "lastPost": "2024-01-15T16:45:00Z",
      "accessToken": "tw_token_xxxxx",
      "pageId": "@EventMasters2024",
    },
    {
      "id": "li",
      "name": "LinkedIn",
      "icon": Icons.business,
      "color": Color(0xFF0A66C2),
      "connected": false,
      "followers": 0,
      "engagement": 0.0,
      "posts": 0,
      "lastPost": null,
      "accessToken": null,
      "pageId": null,
    },
    {
      "id": "yt",
      "name": "YouTube",
      "icon": Icons.play_arrow,
      "color": Color(0xFFFF0000),
      "connected": false,
      "followers": 0,
      "engagement": 0.0,
      "posts": 0,
      "lastPost": null,
      "accessToken": null,
      "pageId": null,
    },
    {
      "id": "tik",
      "name": "TikTok",
      "icon": Icons.music_note,
      "color": Color(0xFF000000),
      "connected": false,
      "followers": 0,
      "engagement": 0.0,
      "posts": 0,
      "lastPost": null,
      "accessToken": null,
      "pageId": null,
    },
  ];

  // Auto-Post Settings
  List<Map<String, dynamic>> autoPostSettings = [
    {
      "id": "event_updates",
      "title": "Event Updates",
      "description": "Automatically post event announcements and updates",
      "enabled": true,
      "platforms": ["fb", "ig", "tw"],
      "frequency": "immediate",
      "template": "🎉 {{event_title}} - {{announcement}} \n\n#EventMasters #Conference2024",
    },
    {
      "id": "speaker_announcements",
      "title": "Speaker Announcements",
      "description": "Share new speaker additions and spotlights",
      "enabled": true,
      "platforms": ["fb", "ig", "li"],
      "frequency": "daily",
      "template": "🎤 Meet our speaker: {{speaker_name}} \n{{speaker_bio}} \n\n#Speakers #EventMasters",
    },
    {
      "id": "schedule_reminders",
      "title": "Schedule Reminders",
      "description": "Post session reminders and schedule updates",
      "enabled": false,
      "platforms": ["tw", "li"],
      "frequency": "1_hour_before",
      "template": "⏰ Reminder: {{session_title}} starts in 1 hour! \n{{session_details}}",
    },
    {
      "id": "live_updates",
      "title": "Live Event Updates",
      "description": "Real-time updates during the event",
      "enabled": true,
      "platforms": ["tw", "ig"],
      "frequency": "real_time",
      "template": "🔴 LIVE: {{update_text}} \n\n#LiveUpdates #EventMasters",
    },
  ];

  // Content Calendar
  List<Map<String, dynamic>> contentCalendar = [
    {
      "id": "post_1",
      "title": "Speaker Spotlight: Dr. Sarah Chen",
      "content": "Meet our keynote speaker Dr. Sarah Chen, AI researcher and innovation leader...",
      "platforms": ["fb", "ig", "li"],
      "scheduledDate": "2024-01-16T09:00:00Z",
      "status": "scheduled",
      "mediaType": "image",
      "mediaUrl": "https://picsum.photos/400/300?random=1&keyword=speaker",
      "engagement": null,
    },
    {
      "id": "post_2",
      "title": "Early Bird Tickets Available",
      "content": "🎫 Early bird tickets are now available! Save 30% on your conference pass...",
      "platforms": ["fb", "tw", "ig"],
      "scheduledDate": "2024-01-16T14:00:00Z",
      "status": "scheduled",
      "mediaType": "carousel",
      "mediaUrl": "https://picsum.photos/400/300?random=2&keyword=tickets",
      "engagement": null,
    },
    {
      "id": "post_3",
      "title": "Conference Agenda Released",
      "content": "📅 Full conference agenda is now live! Check out our amazing lineup...",
      "platforms": ["fb", "li", "tw"],
      "scheduledDate": "2024-01-15T16:00:00Z",
      "status": "published",
      "mediaType": "image",
      "mediaUrl": "https://picsum.photos/400/300?random=3&keyword=agenda",
      "engagement": {
        "likes": 234,
        "shares": 45,
        "comments": 12,
        "reach": 15600,
      },
    },
    {
      "id": "post_4",
      "title": "Behind the Scenes: Event Setup",
      "content": "🎬 Take a peek behind the scenes as we prepare for the big day!",
      "platforms": ["ig", "tik"],
      "scheduledDate": "2024-01-15T12:00:00Z",
      "status": "published",
      "mediaType": "video",
      "mediaUrl": "https://picsum.photos/400/300?random=4&keyword=setup",
      "engagement": {
        "likes": 567,
        "shares": 89,
        "comments": 34,
        "reach": 28900,
      },
    },
  ];

  // Analytics Data
  Map<String, dynamic> analyticsData = {
    "totalReach": 185600,
    "totalEngagement": 2340,
    "totalFollowers": 301000,
    "engagementRate": 4.8,
    "bestPerformingPost": "Speaker Announcement - Dr. Michael Torres",
    "bestPerformingPlatform": "Instagram",
    "weeklyGrowth": 12.5,
    "topHashtags": ["#EventMasters", "#Conference2024", "#TechEvent", "#Innovation"],
  };

  String selectedPlatform = "all";
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Social Media Integration",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Platforms", icon: Icon(Icons.share)),
        Tab(text: "Auto-Post", icon: Icon(Icons.schedule)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_today)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildPlatformsTab(),
        _buildAutoPostTab(),
        _buildCalendarTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildPlatformsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overall Stats
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
                Text(
                  "Social Media Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Followers", "${(analyticsData["totalFollowers"] as int).toString()}", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Engagement Rate", "${(analyticsData["engagementRate"] as double).toStringAsFixed(1)}%", Icons.trending_up, infoColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Platform Connections
          Container(
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
                Text(
                  "Connected Platforms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...socialPlatforms.map((platform) => _buildPlatformCard(platform)),
              ],
            ),
          ),

          // Integration Guide
          Container(
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
                Text(
                  "Integration Guide",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildGuideStep("1", "Connect your social media accounts", "Link your business accounts to enable posting and analytics", Icons.link),
                _buildGuideStep("2", "Configure auto-posting", "Set up automatic posts for events, speakers, and updates", Icons.schedule),
                _buildGuideStep("3", "Plan content calendar", "Schedule posts in advance for consistent engagement", Icons.calendar_today),
                _buildGuideStep("4", "Monitor analytics", "Track performance and optimize your social media strategy", Icons.analytics),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(Map<String, dynamic> platform) {
    bool isConnected = platform["connected"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (platform["color"] as Color).withAlpha(20),
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
                Row(
                  children: [
                    Text(
                      "${platform["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: isConnected ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        isConnected ? "Connected" : "Disconnected",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isConnected) ...[
                  SizedBox(height: 2),
                  Text(
                    "${(platform["followers"] as int).toString()} followers • ${(platform["engagement"] as double).toStringAsFixed(1)}% engagement",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          QButton(
            label: isConnected ? "Manage" : "Connect",
            size: bs.sm,
            onPressed: () {
              if (isConnected) {
                _showPlatformSettings(platform);
              } else {
                _connectPlatform(platform);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPostTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Auto-Post Settings
          Container(
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
                Text(
                  "Auto-Post Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Configure automatic posting for different types of content",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                ...autoPostSettings.map((setting) => _buildAutoPostCard(setting)),
              ],
            ),
          ),

          // Global Settings
          Container(
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
                Text(
                  "Global Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSettingItem("Default Hashtags", "#EventMasters #Conference2024 #TechEvent", Icons.tag),
                _buildSettingItem("Time Zone", "UTC-5 (Eastern Time)", Icons.schedule),
                _buildSettingItem("Posting Hours", "9:00 AM - 6:00 PM", Icons.access_time),
                _buildSettingItem("Weekend Posting", "Disabled", Icons.weekend),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPostCard(Map<String, dynamic> setting) {
    bool isEnabled = setting["enabled"] as bool;
    List<String> platforms = (setting["platforms"] as List).cast<String>();
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${setting["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${setting["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: (value) {
                  setting["enabled"] = value;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Platforms: ",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              ...platforms.map((platformId) {
                var platform = socialPlatforms.firstWhere((p) => p["id"] == platformId);
                return Container(
                  margin: EdgeInsets.only(right: spXs),
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: (platform["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${platform["name"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: platform["color"] as Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Calendar Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Platform",
                    items: [
                      {"label": "All Platforms", "value": "all"},
                      {"label": "Facebook", "value": "fb"},
                      {"label": "Instagram", "value": "ig"},
                      {"label": "Twitter", "value": "tw"},
                      {"label": "LinkedIn", "value": "li"},
                    ],
                    value: selectedPlatform,
                    onChanged: (value, label) {
                      selectedPlatform = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Schedule Post",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () => _showSchedulePostDialog(),
                ),
              ],
            ),
          ),

          // Content Calendar
          Container(
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
                Text(
                  "Content Calendar",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...contentCalendar.map((post) => _buildCalendarPostCard(post)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarPostCard(Map<String, dynamic> post) {
    String status = post["status"] as String;
    List<String> platforms = (post["platforms"] as List).cast<String>();
    
    Color statusColor = status == "published" ? successColor : 
                       status == "scheduled" ? warningColor : 
                       disabledColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${post["mediaUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${post["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${post["content"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      DateTime.parse("${post["scheduledDate"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    ...platforms.take(3).map((platformId) {
                      var platform = socialPlatforms.firstWhere((p) => p["id"] == platformId);
                      return Container(
                        margin: EdgeInsets.only(right: 4),
                        child: Icon(
                          platform["icon"] as IconData,
                          size: 16,
                          color: platform["color"] as Color,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () => _showPostOptions(post),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Key Metrics
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
                Text(
                  "Social Media Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Reach", "${(analyticsData["totalReach"] as int).toString()}", Icons.visibility, infoColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Engagement", "${(analyticsData["totalEngagement"] as int).toString()}", Icons.favorite, dangerColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Followers", "${(analyticsData["totalFollowers"] as int).toString()}", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Growth", "+${(analyticsData["weeklyGrowth"] as double).toStringAsFixed(1)}%", Icons.trending_up, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Platform Performance
          Container(
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
                Text(
                  "Platform Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...socialPlatforms.where((p) => p["connected"] as bool).map((platform) => _buildPlatformPerformance(platform)),
              ],
            ),
          ),

          // Top Content
          Container(
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
                Text(
                  "Top Performing Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...contentCalendar.where((post) => post["engagement"] != null).map((post) => _buildTopContentCard(post)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformPerformance(Map<String, dynamic> platform) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            platform["icon"] as IconData,
            color: platform["color"] as Color,
            size: 20,
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
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(platform["followers"] as int).toString()} followers • ${(platform["engagement"] as double).toStringAsFixed(1)}% engagement",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${platform["posts"]} posts",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopContentCard(Map<String, dynamic> post) {
    Map<String, dynamic> engagement = post["engagement"] as Map<String, dynamic>;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusXs),
              image: DecorationImage(
                image: NetworkImage("${post["mediaUrl"]}"),
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
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(engagement["likes"] as int).toString()} likes • ${(engagement["shares"] as int).toString()} shares • ${(engagement["reach"] as int).toString()} reach",
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
    );
  }

  Widget _buildGuideStep(String number, String title, String description, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, color: disabledBoldColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, color: disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: disabledBoldColor, size: 20),
        ],
      ),
    );
  }

  void _connectPlatform(Map<String, dynamic> platform) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Connect ${platform["name"]}"),
        content: Text("You will be redirected to ${platform["name"]} to authorize the connection."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              platform["connected"] = true;
              setState(() {});
              ss("${platform["name"]} connected successfully!");
            },
            child: Text("Connect"),
          ),
        ],
      ),
    );
  }

  void _showPlatformSettings(Map<String, dynamic> platform) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${platform["name"]} Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Account Settings"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Analytics"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.link_off),
              title: Text("Disconnect"),
              onTap: () {
                Navigator.pop(context);
                platform["connected"] = false;
                setState(() {});
                ss("${platform["name"]} disconnected");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSchedulePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule New Post"),
        content: Text("Post scheduling feature will be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Post scheduled successfully!");
            },
            child: Text("Schedule"),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Post Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Post"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Reschedule"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
