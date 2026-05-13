import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPodcast10View extends StatefulWidget {
  @override
  State<GrlPodcast10View> createState() => _GrlPodcast10ViewState();
}

class _GrlPodcast10ViewState extends State<GrlPodcast10View> {
  Map<String, dynamic> userProfile = {
    "name": "Alex Thompson",
    "email": "alex.thompson@email.com",
    "avatar": "https://picsum.photos/200/200?random=1&keyword=person",
    "totalListenTime": "142h 35m",
    "favoriteGenres": ["Technology", "Business", "Health"],
    "subscriptionsPaused": 3,
    "downloadedEpisodes": 24,
    "listeningStreak": 7
  };

  List<Map<String, dynamic>> subscriptions = [
    {
      "id": 1,
      "title": "Tech Innovation Weekly",
      "host": "Sarah Johnson",
      "image": "https://picsum.photos/150/150?random=1&keyword=tech",
      "isNotificationEnabled": true,
      "autoDownload": false,
      "lastEpisode": "2024-01-15"
    },
    {
      "id": 2,
      "title": "Business Mastery",
      "host": "Michael Chen",
      "image": "https://picsum.photos/150/150?random=2&keyword=business",
      "isNotificationEnabled": false,
      "autoDownload": true,
      "lastEpisode": "2024-01-14"
    },
    {
      "id": 3,
      "title": "Health & Wellness",
      "host": "Dr. Emily Wilson",
      "image": "https://picsum.photos/150/150?random=3&keyword=health",
      "isNotificationEnabled": true,
      "autoDownload": false,
      "lastEpisode": "2024-01-13"
    },
    {
      "id": 4,
      "title": "Creative Stories",
      "host": "David Kim",
      "image": "https://picsum.photos/150/150?random=4&keyword=creative",
      "isNotificationEnabled": false,
      "autoDownload": false,
      "lastEpisode": "2024-01-10"
    }
  ];

  List<Map<String, dynamic>> downloadedEpisodes = [
    {
      "title": "AI Revolution in Healthcare",
      "podcast": "Tech Innovation Weekly",
      "size": "45.2 MB",
      "downloadDate": "Today",
      "duration": "42:15"
    },
    {
      "title": "Marketing Strategies 2024",
      "podcast": "Business Mastery",
      "size": "38.7 MB",
      "downloadDate": "Yesterday",
      "duration": "35:30"
    },
    {
      "title": "Mental Health Tips",
      "podcast": "Health & Wellness",
      "size": "51.3 MB",
      "downloadDate": "2 days ago",
      "duration": "48:20"
    }
  ];

  bool darkModeEnabled = false;
  bool autoPlay = true;
  bool skipIntros = false;
  String audioQuality = "High";
  String downloadQuality = "Medium";
  bool cellularDownload = false;

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile & Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${userProfile["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userProfile["name"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${userProfile["email"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${userProfile["listeningStreak"]} day streak 🔥",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Stats Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Listening Stats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProfile["totalListenTime"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Listen Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${subscriptions.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Subscriptions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${userProfile["downloadedEpisodes"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Downloaded",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Tab Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Tab Headers
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              currentTab = 0;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                border: currentTab == 0
                                    ? Border(
                                        bottom: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                "Subscriptions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: currentTab == 0 ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              currentTab = 1;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                border: currentTab == 1
                                    ? Border(
                                        bottom: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                "Downloads",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: currentTab == 1 ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              currentTab = 2;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                border: currentTab == 2
                                    ? Border(
                                        bottom: BorderSide(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Text(
                                "Settings",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: currentTab == 2 ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Content
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: _buildTabContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildSubscriptionsTab();
      case 1:
        return _buildDownloadsTab();
      case 2:
        return _buildSettingsTab();
      default:
        return _buildSubscriptionsTab();
    }
  }

  Widget _buildSubscriptionsTab() {
    return Column(
      children: subscriptions.map((subscription) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${subscription["image"]}"),
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
                      "${subscription["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "by ${subscription["host"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Last episode: ${subscription["lastEpisode"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        if (subscription["isNotificationEnabled"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                fontSize: 9,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (subscription["autoDownload"] == true) ...[
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Auto Download",
                              style: TextStyle(
                                fontSize: 9,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDownloadsTab() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Downloaded Episodes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Manage",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spSm),
        Column(
          children: downloadedEpisodes.map((episode) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Icon(
                    Icons.download_done,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${episode["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${episode["podcast"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${episode["size"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${episode["duration"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${episode["downloadDate"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Playback Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        _buildSettingItem(
          "Auto Play Next Episode",
          "Automatically play the next episode",
          Switch(
            value: autoPlay,
            onChanged: (value) {
              autoPlay = value;
              setState(() {});
            },
          ),
        ),
        
        _buildSettingItem(
          "Skip Intro/Outro",
          "Automatically skip intro and outro segments",
          Switch(
            value: skipIntros,
            onChanged: (value) {
              skipIntros = value;
              setState(() {});
            },
          ),
        ),

        SizedBox(height: spLg),

        Text(
          "Audio Quality",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),

        QDropdownField(
          label: "Streaming Quality",
          items: [
            {"label": "Low", "value": "Low"},
            {"label": "Medium", "value": "Medium"},
            {"label": "High", "value": "High"},
          ],
          value: audioQuality,
          onChanged: (value, label) {
            audioQuality = value;
            setState(() {});
          },
        ),

        SizedBox(height: spSm),

        QDropdownField(
          label: "Download Quality",
          items: [
            {"label": "Low", "value": "Low"},
            {"label": "Medium", "value": "Medium"},
            {"label": "High", "value": "High"},
          ],
          value: downloadQuality,
          onChanged: (value, label) {
            downloadQuality = value;
            setState(() {});
          },
        ),

        SizedBox(height: spLg),

        Text(
          "Download Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),

        _buildSettingItem(
          "Download over Cellular",
          "Allow downloads using mobile data",
          Switch(
            value: cellularDownload,
            onChanged: (value) {
              cellularDownload = value;
              setState(() {});
            },
          ),
        ),

        SizedBox(height: spLg),

        Text(
          "App Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),

        _buildSettingItem(
          "Dark Mode",
          "Use dark theme for the app",
          Switch(
            value: darkModeEnabled,
            onChanged: (value) {
              darkModeEnabled = value;
              setState(() {});
            },
          ),
        ),

        SizedBox(height: spLg),

        Column(
          children: [
            Container(
              width: double.infinity,
              child: QButton(
                label: "Clear Cache",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Export Data",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Sign Out",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, String subtitle, Widget trailing) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
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
                SizedBox(height: spXs),
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
          trailing,
        ],
      ),
    );
  }
}
