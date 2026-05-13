import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews9View extends StatefulWidget {
  @override
  State<GrlNews9View> createState() => _GrlNews9ViewState();
}

class _GrlNews9ViewState extends State<GrlNews9View> {
  String searchQuery = "";
  String selectedFormat = "All Formats";
  String sortOrder = "Most Recent";
  bool showReadingTime = true;
  int selectedIndex = 0;

  List<Map<String, dynamic>> formats = [
    {"label": "All Formats", "value": "All Formats"},
    {"label": "Articles", "value": "Articles"},
    {"label": "Videos", "value": "Videos"},
    {"label": "Podcasts", "value": "Podcasts"},
    {"label": "Infographics", "value": "Infographics"},
    {"label": "Live Streams", "value": "Live Streams"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "Most Recent"},
    {"label": "Most Popular", "value": "Most Popular"},
    {"label": "Most Relevant", "value": "Most Relevant"},
    {"label": "Shortest Read", "value": "Shortest Read"},
    {"label": "Longest Read", "value": "Longest Read"},
  ];

  List<Map<String, dynamic>> multimedia = [
    {
      "id": 1,
      "title": "The Future of Renewable Energy: A Visual Journey",
      "description": "Comprehensive look at solar, wind, and hydroelectric power developments worldwide",
      "format": "Video",
      "duration": "12:34",
      "thumbnail": "https://picsum.photos/400/240?random=1&keyword=renewable",
      "author": "Green Energy Today",
      "publishedAt": "2024-01-15T10:00:00Z",
      "views": 145000,
      "likes": 8900,
      "category": "Environment",
      "quality": "4K",
      "isLive": false,
      "readTime": 0,
    },
    {
      "id": 2,
      "title": "AI Revolution in Healthcare: Expert Panel Discussion",
      "description": "Leading doctors and tech innovators discuss the impact of artificial intelligence on medical practice",
      "format": "Podcast",
      "duration": "45:22",
      "thumbnail": "https://picsum.photos/400/240?random=2&keyword=healthcare",
      "author": "MedTech Insights",
      "publishedAt": "2024-01-15T08:30:00Z",
      "views": 67000,
      "likes": 3400,
      "category": "Technology",
      "quality": "HD Audio",
      "isLive": false,
      "readTime": 0,
    },
    {
      "id": 3,
      "title": "Global Climate Data: Interactive Visualization",
      "description": "Explore real-time climate change data through interactive charts and maps",
      "format": "Infographic",
      "duration": "00:00",
      "thumbnail": "https://picsum.photos/400/240?random=3&keyword=climate",
      "author": "Climate Watch",
      "publishedAt": "2024-01-15T09:15:00Z",
      "views": 89000,
      "likes": 5600,
      "category": "Science",
      "quality": "Interactive",
      "isLive": false,
      "readTime": 8,
    },
    {
      "id": 4,
      "title": "Breaking: World Economic Forum Live Coverage",
      "description": "Live coverage of key speeches and panel discussions from the World Economic Forum",
      "format": "Live Stream",
      "duration": "LIVE",
      "thumbnail": "https://picsum.photos/400/240?random=4&keyword=conference",
      "author": "Global News Network",
      "publishedAt": "2024-01-15T12:00:00Z",
      "views": 234000,
      "likes": 12300,
      "category": "Economics",
      "quality": "HD",
      "isLive": true,
      "readTime": 0,
    },
    {
      "id": 5,
      "title": "Space Exploration Milestones: The Complete Timeline",
      "description": "From Sputnik to Mars rovers - a comprehensive visual timeline of humanity's journey to space",
      "format": "Article",
      "duration": "00:00",
      "thumbnail": "https://picsum.photos/400/240?random=5&keyword=space",
      "author": "Space Chronicles",
      "publishedAt": "2024-01-15T07:45:00Z",
      "views": 112000,
      "likes": 7800,
      "category": "Science",
      "quality": "Long-form",
      "isLive": false,
      "readTime": 15,
    },
  ];

  List<Map<String, dynamic>> quickStats = [
    {"label": "Total Articles", "value": "2,847", "icon": Icons.article, "color": primaryColor},
    {"label": "Video Content", "value": "892", "icon": Icons.play_circle, "color": dangerColor},
    {"label": "Live Streams", "value": "23", "icon": Icons.live_tv, "color": successColor},
    {"label": "Audio Content", "value": "1,456", "icon": Icons.headphones, "color": warningColor},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.playlist_play),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: QTextField(
                    label: "Search multimedia content...",
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

            // Format and Sort Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Content Format",
                    items: formats,
                    value: selectedFormat,
                    onChanged: (value, label) {
                      selectedFormat = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortOrder,
                    onChanged: (value, label) {
                      sortOrder = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Reading Time Toggle
            QSwitch(
              items: [
                {
                  "label": "Show Reading Time Estimates",
                  "value": true,
                  "checked": showReadingTime,
                }
              ],
              value: [
                if (showReadingTime)
                  {
                    "label": "Show Reading Time Estimates",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showReadingTime = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Quick Stats
            Text(
              "Content Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["label"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Multimedia Content Header
            Row(
              children: [
                Icon(
                  Icons.video_library,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Featured Multimedia",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Multimedia Content Cards
            ...multimedia.map((content) {
              Color formatColor = _getFormatColor("${content["format"]}");
              IconData formatIcon = _getFormatIcon("${content["format"]}");

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          child: Image.network(
                            "${content["thumbnail"]}",
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Format Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: formatColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  formatIcon,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${content["format"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Duration/Live Badge
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: content["isLive"] == true 
                                  ? dangerColor 
                                  : Colors.black.withAlpha(179),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (content["isLive"] == true) ...[
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                Text(
                                  "${content["duration"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Play Button Overlay
                        if (content["format"] == "Video" || content["format"] == "Live Stream")
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(128),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  content["isLive"] == true ? Icons.live_tv : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: formatColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${content["category"]}",
                                  style: TextStyle(
                                    color: formatColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${content["quality"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              if (showReadingTime && (content["readTime"] as int) > 0)
                                Text(
                                  "${content["readTime"]} min read",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                          
                          Text(
                            "${content["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                          
                          Text(
                            "${content["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: formatColor.withAlpha(51),
                                child: Text(
                                  "${content["author"]}".substring(0, 1),
                                  style: TextStyle(
                                    color: formatColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${content["author"]} • ${DateTime.parse("${content["publishedAt"]}").dMMMy}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((content["views"] as int) / 1000).toStringAsFixed(0)}K",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: spSm),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((content["likes"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.bookmark_border,
                                      size: 20,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.share,
                                      size: 20,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 20,
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
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getFormatColor(String format) {
    switch (format.toLowerCase()) {
      case 'video':
        return dangerColor;
      case 'podcast':
        return warningColor;
      case 'infographic':
        return infoColor;
      case 'live stream':
        return successColor;
      case 'article':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFormatIcon(String format) {
    switch (format.toLowerCase()) {
      case 'video':
        return Icons.play_circle;
      case 'podcast':
        return Icons.headphones;
      case 'infographic':
        return Icons.bar_chart;
      case 'live stream':
        return Icons.live_tv;
      case 'article':
        return Icons.article;
      default:
        return Icons.description;
    }
  }
}
