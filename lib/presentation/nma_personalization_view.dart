import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPersonalizationView extends StatefulWidget {
  const NmaPersonalizationView({Key? key}) : super(key: key);

  @override
  State<NmaPersonalizationView> createState() => _NmaPersonalizationViewState();
}

class _NmaPersonalizationViewState extends State<NmaPersonalizationView> {
  String contentLanguage = "english";
  String readingLevel = "intermediate";
  String articleLength = "medium";
  String contentType = "mixed";
  bool personalizedRecommendations = true;
  bool trackReadingHistory = true;
  bool showPersonalizedAds = false;
  bool enableSmartFiltering = true;
  bool autoBookmark = true;
  
  double readingSpeed = 250.0; // words per minute
  int dailyReadingGoal = 3; // articles per day
  String preferredTime = "morning";
  
  List<String> blockedSources = ["fake-news-site.com", "spam-content.net"];
  List<String> favoriteAuthors = ["Dr. Sarah Johnson", "Michael Chen", "Prof. Elena Rodriguez"];
  
  List<Map<String, dynamic>> personalizationSettings = [
    {
      "title": "Content Personalization",
      "description": "Customize your content preferences",
      "icon": Icons.tune,
      "color": Colors.blue,
      "items": [
        {"key": "language", "label": "Content Language", "type": "dropdown"},
        {"key": "reading_level", "label": "Reading Level", "type": "dropdown"},
        {"key": "article_length", "label": "Preferred Article Length", "type": "dropdown"},
        {"key": "content_type", "label": "Content Type", "type": "dropdown"},
      ]
    },
    {
      "title": "Recommendations",
      "description": "Control how we recommend content to you",
      "icon": Icons.recommend,
      "color": Colors.green,
      "items": [
        {"key": "personalized_recommendations", "label": "Personalized Recommendations", "type": "switch"},
        {"key": "track_reading_history", "label": "Track Reading History", "type": "switch"},
        {"key": "smart_filtering", "label": "Smart Content Filtering", "type": "switch"},
        {"key": "auto_bookmark", "label": "Auto-bookmark Interesting Articles", "type": "switch"},
      ]
    },
    {
      "title": "Reading Preferences",
      "description": "Optimize your reading experience",
      "icon": Icons.chrome_reader_mode,
      "color": Colors.orange,
      "items": [
        {"key": "reading_speed", "label": "Reading Speed (WPM)", "type": "slider"},
        {"key": "daily_goal", "label": "Daily Reading Goal", "type": "slider"},
        {"key": "preferred_time", "label": "Preferred Reading Time", "type": "dropdown"},
      ]
    },
    {
      "title": "Privacy & Data",
      "description": "Control your data and privacy settings",
      "icon": Icons.privacy_tip,
      "color": Colors.red,
      "items": [
        {"key": "personalized_ads", "label": "Show Personalized Ads", "type": "switch"},
        {"key": "data_sharing", "label": "Share Usage Data", "type": "switch"},
        {"key": "analytics", "label": "Enable Analytics", "type": "switch"},
      ]
    },
  ];

  List<Map<String, dynamic>> readingStats = [
    {"label": "Articles Read", "value": "247", "icon": Icons.article, "color": Colors.blue},
    {"label": "Reading Time", "value": "45h", "icon": Icons.schedule, "color": Colors.green},
    {"label": "Streak", "value": "12 days", "icon": Icons.local_fire_department, "color": Colors.orange},
    {"label": "Bookmarks", "value": "89", "icon": Icons.bookmark, "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personalization"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _resetToDefaults(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Personalization overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(10), primaryColor.withAlpha(5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Your Personalization Profile",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We've learned your preferences from ${personalizedRecommendations ? '247 articles read' : 'your manual settings'}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: readingStats.map((stat) => 
                      Expanded(child: _buildStatCard(stat))
                    ).toList(),
                  ),
                ],
              ),
            ),

            // Personalization settings
            ...personalizationSettings.map((section) => _buildSettingsSection(section)),

            // Blocked sources
            Container(
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
                      Icon(
                        Icons.block,
                        color: dangerColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Blocked Sources",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _addBlockedSource(),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (blockedSources.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "No blocked sources",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...blockedSources.map((source) => _buildBlockedSourceItem(source)),
                ],
              ),
            ),

            // Favorite authors
            Container(
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
                      Icon(
                        Icons.favorite,
                        color: successColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Favorite Authors",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _addFavoriteAuthor(),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (favoriteAuthors.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Text(
                            "No favorite authors",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...favoriteAuthors.map((author) => _buildFavoriteAuthorItem(author)),
                ],
              ),
            ),

            // Personalization insights
            Container(
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
                      Icon(
                        Icons.insights,
                        color: infoColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Personalization Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildInsightItem("Most read topic", "Technology (45%)", Icons.computer),
                  _buildInsightItem("Favorite reading time", "Morning (8-10 AM)", Icons.schedule),
                  _buildInsightItem("Average article length", "8 minutes", Icons.timer),
                  _buildInsightItem("Reading consistency", "Daily reader", Icons.calendar_today),
                ],
              ),
            ),

            // Export/Import settings
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Settings",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: () => _exportSettings(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Import Settings",
                    size: bs.md,
                    icon: Icons.upload,
                    onPressed: () => _importSettings(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      margin: EdgeInsets.only(right: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (stat["color"] as Color).withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            stat["icon"],
            color: stat["color"],
            size: 16,
          ),
          SizedBox(height: spXs),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: stat["color"],
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${stat["label"]}",
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(Map<String, dynamic> section) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (section["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  section["icon"],
                  color: section["color"],
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${section["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: section["color"],
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${section["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: section["color"],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          ...(section["items"] as List).map((item) => _buildSettingItem(item)),
        ],
      ),
    );
  }

  Widget _buildSettingItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${item["label"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: spSm),
          _buildSettingControl(item),
        ],
      ),
    );
  }

  Widget _buildSettingControl(Map<String, dynamic> item) {
    switch (item["type"]) {
      case "dropdown":
        return Container(
          width: 120,
          child: _buildDropdownForKey(item["key"]),
        );
      case "switch":
        return Switch(
          value: _getSwitchValue(item["key"]),
          onChanged: (value) => _updateSwitchValue(item["key"], value),
          activeColor: primaryColor,
        );
      case "slider":
        return Container(
          width: 120,
          child: _buildSliderForKey(item["key"]),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildDropdownForKey(String key) {
    switch (key) {
      case "language":
        return QDropdownField(
          label: "",
          items: [
            {"label": "English", "value": "english"},
            {"label": "Spanish", "value": "spanish"},
            {"label": "French", "value": "french"},
            {"label": "German", "value": "german"},
          ],
          value: contentLanguage,
          onChanged: (value, label) {
            contentLanguage = value;
            setState(() {});
          },
        );
      case "reading_level":
        return QDropdownField(
          label: "",
          items: [
            {"label": "Beginner", "value": "beginner"},
            {"label": "Intermediate", "value": "intermediate"},
            {"label": "Advanced", "value": "advanced"},
            {"label": "Expert", "value": "expert"},
          ],
          value: readingLevel,
          onChanged: (value, label) {
            readingLevel = value;
            setState(() {});
          },
        );
      case "article_length":
        return QDropdownField(
          label: "",
          items: [
            {"label": "Short (1-3 min)", "value": "short"},
            {"label": "Medium (4-8 min)", "value": "medium"},
            {"label": "Long (9+ min)", "value": "long"},
            {"label": "Any Length", "value": "any"},
          ],
          value: articleLength,
          onChanged: (value, label) {
            articleLength = value;
            setState(() {});
          },
        );
      case "content_type":
        return QDropdownField(
          label: "",
          items: [
            {"label": "Mixed", "value": "mixed"},
            {"label": "News Only", "value": "news"},
            {"label": "Articles Only", "value": "articles"},
            {"label": "Analysis Only", "value": "analysis"},
          ],
          value: contentType,
          onChanged: (value, label) {
            contentType = value;
            setState(() {});
          },
        );
      case "preferred_time":
        return QDropdownField(
          label: "",
          items: [
            {"label": "Morning", "value": "morning"},
            {"label": "Afternoon", "value": "afternoon"},
            {"label": "Evening", "value": "evening"},
            {"label": "Night", "value": "night"},
          ],
          value: preferredTime,
          onChanged: (value, label) {
            preferredTime = value;
            setState(() {});
          },
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildSliderForKey(String key) {
    switch (key) {
      case "reading_speed":
        return Column(
          children: [
            Slider(
              value: readingSpeed,
              min: 100,
              max: 500,
              divisions: 20,
              onChanged: (value) {
                readingSpeed = value;
                setState(() {});
              },
            ),
            Text(
              "${readingSpeed.round()} WPM",
              style: TextStyle(fontSize: 10, color: disabledBoldColor),
            ),
          ],
        );
      case "daily_goal":
        return Column(
          children: [
            Slider(
              value: dailyReadingGoal.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                dailyReadingGoal = value.round();
                setState(() {});
              },
            ),
            Text(
              "$dailyReadingGoal articles",
              style: TextStyle(fontSize: 10, color: disabledBoldColor),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  bool _getSwitchValue(String key) {
    switch (key) {
      case "personalized_recommendations":
        return personalizedRecommendations;
      case "track_reading_history":
        return trackReadingHistory;
      case "personalized_ads":
        return showPersonalizedAds;
      case "smart_filtering":
        return enableSmartFiltering;
      case "auto_bookmark":
        return autoBookmark;
      default:
        return false;
    }
  }

  void _updateSwitchValue(String key, bool value) {
    switch (key) {
      case "personalized_recommendations":
        personalizedRecommendations = value;
        break;
      case "track_reading_history":
        trackReadingHistory = value;
        break;
      case "personalized_ads":
        showPersonalizedAds = value;
        break;
      case "smart_filtering":
        enableSmartFiltering = value;
        break;
      case "auto_bookmark":
        autoBookmark = value;
        break;
    }
    setState(() {});
  }

  Widget _buildBlockedSourceItem(String source) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: dangerColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.block, color: dangerColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              source,
              style: TextStyle(
                fontSize: 12,
                color: dangerColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _removeBlockedSource(source),
            child: Icon(
              Icons.close,
              color: dangerColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteAuthorItem(String author) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: successColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              author,
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _removeFavoriteAuthor(author),
            child: Icon(
              Icons.close,
              color: successColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Icon(icon, color: infoColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _addBlockedSource() {
    showDialog(
      context: context,
      builder: (context) {
        String newSource = "";
        return AlertDialog(
          title: Text("Block Source"),
          content: QTextField(
            label: "Website URL",
            value: newSource,
            hint: "Enter website URL to block",
            onChanged: (value) {
              newSource = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Block",
              size: bs.sm,
              onPressed: () {
                if (newSource.trim().isNotEmpty) {
                  blockedSources.add(newSource.trim());
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeBlockedSource(String source) {
    blockedSources.remove(source);
    setState(() {});
    ss("Removed blocked source");
  }

  void _addFavoriteAuthor() {
    showDialog(
      context: context,
      builder: (context) {
        String newAuthor = "";
        return AlertDialog(
          title: Text("Add Favorite Author"),
          content: QTextField(
            label: "Author Name",
            value: newAuthor,
            hint: "Enter author name",
            onChanged: (value) {
              newAuthor = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Add",
              size: bs.sm,
              onPressed: () {
                if (newAuthor.trim().isNotEmpty) {
                  favoriteAuthors.add(newAuthor.trim());
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeFavoriteAuthor(String author) {
    favoriteAuthors.remove(author);
    setState(() {});
    ss("Removed favorite author");
  }

  void _exportSettings() {
    ss("Settings exported successfully");
  }

  void _importSettings() {
    ss("Settings imported successfully");
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset to Defaults"),
        content: Text("This will reset all personalization settings to their default values. Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Reset",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              _performReset();
            },
          ),
        ],
      ),
    );
  }

  void _performReset() {
    contentLanguage = "english";
    readingLevel = "intermediate";
    articleLength = "medium";
    contentType = "mixed";
    personalizedRecommendations = true;
    trackReadingHistory = true;
    showPersonalizedAds = false;
    enableSmartFiltering = true;
    autoBookmark = true;
    readingSpeed = 250.0;
    dailyReadingGoal = 3;
    preferredTime = "morning";
    blockedSources.clear();
    favoriteAuthors.clear();
    
    setState(() {});
    ss("Settings reset to defaults");
  }
}
