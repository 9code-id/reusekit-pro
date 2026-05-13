import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews5View extends StatefulWidget {
  @override
  State<GrlNews5View> createState() => _GrlNews5ViewState();
}

class _GrlNews5ViewState extends State<GrlNews5View> {
  String searchQuery = "";
  String selectedRegion = "Global";
  String selectedTimeframe = "Today";
  bool showPersonalized = true;

  List<Map<String, dynamic>> regions = [
    {"label": "Global", "value": "Global"},
    {"label": "United States", "value": "US"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia Pacific", "value": "APAC"},
    {"label": "Middle East", "value": "ME"},
    {"label": "Africa", "value": "AF"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "Week"},
    {"label": "This Month", "value": "Month"},
    {"label": "This Year", "value": "Year"},
  ];

  List<Map<String, dynamic>> topStories = [
    {
      "id": 1,
      "title": "Global Economic Summit Addresses Inflation Concerns",
      "summary": "World leaders discuss comprehensive strategies to combat rising inflation rates affecting international markets",
      "image": "https://picsum.photos/400/250?random=1&keyword=economy",
      "category": "Economics",
      "source": "Global Business Today",
      "publishedAt": "2024-01-15T11:00:00Z",
      "readTime": 8,
      "priority": "high",
      "tags": ["Economy", "Inflation", "Global Markets"],
    },
    {
      "id": 2,
      "title": "Breakthrough in Renewable Energy Storage Technology",
      "summary": "Scientists develop revolutionary battery technology that could transform the renewable energy sector",
      "image": "https://picsum.photos/400/250?random=2&keyword=energy",
      "category": "Technology",
      "source": "Tech Innovation Weekly",
      "publishedAt": "2024-01-15T10:30:00Z",
      "readTime": 6,
      "priority": "medium",
      "tags": ["Technology", "Green Energy", "Innovation"],
    },
    {
      "id": 3,
      "title": "International Space Station Mission Achieves Historic Milestone",
      "summary": "Crew successfully completes longest duration space walk in history, advancing scientific research",
      "image": "https://picsum.photos/400/250?random=3&keyword=space",
      "category": "Science",
      "source": "Space Explorer News",
      "publishedAt": "2024-01-15T09:45:00Z",
      "readTime": 5,
      "priority": "medium",
      "tags": ["Space", "Science", "Research"],
    },
  ];

  List<Map<String, dynamic>> personalizedNews = [
    {
      "id": 4,
      "title": "AI in Healthcare: Revolutionary Diagnostic Tools",
      "excerpt": "Machine learning algorithms show 95% accuracy in medical imaging",
      "image": "https://picsum.photos/200/120?random=4&keyword=medical",
      "category": "Healthcare",
      "readTime": 4,
      "engagement": 89,
    },
    {
      "id": 5,
      "title": "Sustainable Agriculture Practices Gain Momentum",
      "excerpt": "Farmers worldwide adopt eco-friendly farming techniques",
      "image": "https://picsum.photos/200/120?random=5&keyword=agriculture",
      "category": "Environment",
      "readTime": 3,
      "engagement": 76,
    },
    {
      "id": 6,
      "title": "Cryptocurrency Market Shows Signs of Recovery",
      "excerpt": "Bitcoin and major altcoins surge after regulatory clarity",
      "image": "https://picsum.photos/200/120?random=6&keyword=crypto",
      "category": "Finance",
      "readTime": 5,
      "engagement": 92,
    },
    {
      "id": 7,
      "title": "Olympic Training Centers Embrace Virtual Reality",
      "excerpt": "Athletes use VR technology to enhance performance training",
      "image": "https://picsum.photos/200/120?random=7&keyword=sports",
      "category": "Sports",
      "readTime": 6,
      "engagement": 68,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global News"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
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
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search global news...",
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframes,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Personalization Toggle
            QSwitch(
              items: [
                {
                  "label": "Show Personalized Content",
                  "value": true,
                  "checked": showPersonalized,
                }
              ],
              value: [
                if (showPersonalized)
                  {
                    "label": "Show Personalized Content",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showPersonalized = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Top Stories Header
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Top Stories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    selectedRegion,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Top Stories
            ...topStories.map((story) {
              Color priorityColor = story["priority"] == "high"
                  ? dangerColor
                  : story["priority"] == "medium"
                      ? warningColor
                      : successColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: priorityColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      child: Image.network(
                        "${story["image"]}",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
                                  color: priorityColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${story["category"]}",
                                  style: TextStyle(
                                    color: priorityColor,
                                    fontSize: 12,
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
                                  color: priorityColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${story["priority"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${story["readTime"]} min read",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${story["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${story["summary"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (story["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.source,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${story["source"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                DateTime.parse("${story["publishedAt"]}").dMMMy,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
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

            if (showPersonalized) ...[
              // Personalized Section
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Personalized for You",
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
                      "Customize",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Personalized News Grid
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: personalizedNews.map((news) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          child: Image.network(
                            "${news["image"]}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${news["category"]}",
                                      style: TextStyle(
                                        color: infoColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 12,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${news["engagement"]}%",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "${news["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${news["excerpt"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${news["readTime"]} min read",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
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
              ),
            ],
          ],
        ),
      ),
    );
  }
}
