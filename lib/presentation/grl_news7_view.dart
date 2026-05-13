import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews7View extends StatefulWidget {
  @override
  State<GrlNews7View> createState() => _GrlNews7ViewState();
}

class _GrlNews7ViewState extends State<GrlNews7View> {
  String searchQuery = "";
  String selectedLanguage = "English";
  String selectedCountry = "United States";
  bool enablePushNotifications = true;
  int currentTab = 0;

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Canada", "value": "Canada"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
  ];

  List<Map<String, dynamic>> liveUpdates = [
    {
      "id": 1,
      "title": "Breaking: Global Summit Reaches Climate Agreement",
      "description": "Historic deal signed by 195 countries to combat climate change",
      "timestamp": "2024-01-15T12:30:00Z",
      "isLive": true,
      "priority": "critical",
      "viewers": 2500000,
    },
    {
      "id": 2,
      "title": "Stock Market Update: Major Indices Rise",
      "description": "S&P 500 up 2.5% following positive economic indicators",
      "timestamp": "2024-01-15T12:15:00Z",
      "isLive": true,
      "priority": "high",
      "viewers": 890000,
    },
    {
      "id": 3,
      "title": "Tech Giant Announces Revolutionary AI Platform",
      "description": "New artificial intelligence system promises to transform industries",
      "timestamp": "2024-01-15T11:45:00Z",
      "isLive": false,
      "priority": "medium",
      "viewers": 0,
    },
  ];

  List<Map<String, dynamic>> categoryNews = [
    {
      "category": "World",
      "icon": Icons.public,
      "color": primaryColor,
      "articles": [
        {
          "title": "International Trade Relations Show Improvement",
          "excerpt": "Diplomatic efforts yield positive results in global commerce",
          "time": "2 hours ago",
          "isHot": true,
        },
        {
          "title": "UN Peacekeeping Mission Expands to New Regions",
          "excerpt": "Enhanced security measures implemented worldwide",
          "time": "4 hours ago",
          "isHot": false,
        },
      ],
    },
    {
      "category": "Politics",
      "icon": Icons.how_to_vote,
      "color": infoColor,
      "articles": [
        {
          "title": "Election Results Show Surprising Voter Turnout",
          "excerpt": "Record-breaking participation in democratic process",
          "time": "1 hour ago",
          "isHot": true,
        },
        {
          "title": "Policy Reform Passes Through Senate",
          "excerpt": "Bipartisan support for infrastructure development",
          "time": "3 hours ago",
          "isHot": false,
        },
      ],
    },
    {
      "category": "Technology",
      "icon": Icons.computer,
      "color": successColor,
      "articles": [
        {
          "title": "Quantum Computing Milestone Achieved",
          "excerpt": "Scientists breakthrough in quantum processing power",
          "time": "30 minutes ago",
          "isHot": true,
        },
        {
          "title": "Cybersecurity Measures Enhanced Globally",
          "excerpt": "New protocols protect against emerging threats",
          "time": "2 hours ago",
          "isHot": false,
        },
      ],
    },
    {
      "category": "Business",
      "icon": Icons.business,
      "color": warningColor,
      "articles": [
        {
          "title": "Corporate Earnings Exceed Expectations",
          "excerpt": "Strong quarterly results boost investor confidence",
          "time": "1 hour ago",
          "isHot": true,
        },
        {
          "title": "Startup Funding Reaches Record Levels",
          "excerpt": "Venture capital investment shows robust growth",
          "time": "5 hours ago",
          "isHot": false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Live News Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Live", icon: Icon(Icons.live_tv)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        // Live News Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Search Section
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search live news...",
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

              // Live Updates Header
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "LIVE UPDATES",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Auto-refresh ON",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Live Updates List
              ...liveUpdates.map((update) {
                Color priorityColor = update["priority"] == "critical"
                    ? dangerColor
                    : update["priority"] == "high"
                        ? warningColor
                        : infoColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            if (update["isLive"] == true) ...[
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "LIVE",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ] else ...[
                              Icon(
                                Icons.schedule,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "ENDED",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: priorityColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${update["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  color: priorityColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${update["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${update["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              DateTime.parse("${update["timestamp"]}").dMMMykkmm,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            if (update["isLive"] == true && (update["viewers"] as int) > 0) ...[
                              SizedBox(width: spSm),
                              Icon(
                                Icons.visibility,
                                size: 14,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((update["viewers"] as int) / 1000).toStringAsFixed(0)}K watching",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.share,
                                    size: 18,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.notifications,
                                    size: 18,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Categories Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "News by Category",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...categoryNews.map((category) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Category Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: category["color"] as Color,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  color: category["color"] as Color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Articles List
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spSm,
                          children: (category["articles"] as List).map((article) {
                            return Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Row(
                                          children: [
                                            if (article["isHot"] == true) ...[
                                              Icon(
                                                Icons.local_fire_department,
                                                color: dangerColor,
                                                size: 16,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "HOT",
                                                style: TextStyle(
                                                  color: dangerColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                            ],
                                            Text(
                                              "${article["time"]}",
                                              style: TextStyle(
                                                color: disabledBoldColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${article["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${article["excerpt"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Settings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "News Preferences",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              // Language Selection
              QDropdownField(
                label: "Language",
                items: languages,
                value: selectedLanguage,
                onChanged: (value, label) {
                  selectedLanguage = value;
                  setState(() {});
                },
              ),

              // Country Selection
              QDropdownField(
                label: "Country/Region",
                items: countries,
                value: selectedCountry,
                onChanged: (value, label) {
                  selectedCountry = value;
                  setState(() {});
                },
              ),

              // Notifications Toggle
              QSwitch(
                items: [
                  {
                    "label": "Enable Push Notifications",
                    "value": true,
                    "checked": enablePushNotifications,
                  }
                ],
                value: [
                  if (enablePushNotifications)
                    {
                      "label": "Enable Push Notifications",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  enablePushNotifications = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Settings Categories
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      icon: Icons.bookmark,
                      title: "Saved Articles",
                      subtitle: "Manage your bookmarked articles",
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    _buildSettingItem(
                      icon: Icons.history,
                      title: "Reading History",
                      subtitle: "View your recently read articles",
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    _buildSettingItem(
                      icon: Icons.interests,
                      title: "Interests",
                      subtitle: "Customize your news feed",
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    _buildSettingItem(
                      icon: Icons.block,
                      title: "Blocked Sources",
                      subtitle: "Manage blocked news sources",
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    _buildSettingItem(
                      icon: Icons.privacy_tip,
                      title: "Privacy Settings",
                      subtitle: "Control your data and privacy",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Reset All Settings",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: disabledBoldColor,
            ),
          ],
        ),
      ),
    );
  }
}
