import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews10View extends StatefulWidget {
  @override
  State<GrlNews10View> createState() => _GrlNews10ViewState();
}

class _GrlNews10ViewState extends State<GrlNews10View> {
  String searchQuery = "";
  String selectedRegion = "Global";
  String selectedLanguage = "English";
  bool enableRealTimeUpdates = true;
  bool showAISummary = true;
  int selectedTab = 0;

  List<Map<String, dynamic>> regions = [
    {"label": "Global", "value": "Global"},
    {"label": "North America", "value": "NA"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia Pacific", "value": "APAC"},
    {"label": "Latin America", "value": "LATAM"},
    {"label": "Middle East & Africa", "value": "MEA"},
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Arabic", "value": "Arabic"},
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "id": 1,
      "headline": "Global Climate Agreement Signed by 195 Nations",
      "summary": "Historic international climate accord commits world leaders to ambitious carbon reduction targets, marking a turning point in global environmental policy.",
      "aiAnalysis": "This agreement represents the most comprehensive climate action plan in history, with legally binding commitments that could reshape global energy policies over the next decade.",
      "image": "https://picsum.photos/400/250?random=1&keyword=climate",
      "source": "International Environmental Times",
      "author": "Dr. Sarah Mitchell",
      "publishedAt": "2024-01-15T11:30:00Z",
      "region": "Global",
      "priority": "critical",
      "readTime": 8,
      "shares": 45600,
      "comments": 2890,
      "verification": "verified",
      "tags": ["Climate", "Environment", "Policy", "International"],
    },
    {
      "id": 2,
      "headline": "Breakthrough in Quantum Computing Achieved by Tech Giants",
      "summary": "Major technology companies announce successful quantum computing milestone that could revolutionize data processing and cybersecurity industries.",
      "aiAnalysis": "This quantum breakthrough could accelerate AI development, enhance cryptographic security, and potentially solve complex problems in drug discovery and financial modeling.",
      "image": "https://picsum.photos/400/250?random=2&keyword=quantum",
      "source": "Technology Innovation Weekly",
      "author": "Dr. Michael Chen",
      "publishedAt": "2024-01-15T10:45:00Z",
      "region": "Global",
      "priority": "high",
      "readTime": 12,
      "shares": 28900,
      "comments": 1567,
      "verification": "verified",
      "tags": ["Technology", "Quantum", "Innovation", "Computing"],
    },
    {
      "id": 3,
      "headline": "World Health Organization Reports Disease Outbreak Contained",
      "summary": "International health officials confirm successful containment of emerging infectious disease through coordinated global response efforts.",
      "aiAnalysis": "The swift containment demonstrates improved pandemic preparedness and international cooperation following lessons learned from previous health crises.",
      "image": "https://picsum.photos/400/250?random=3&keyword=health",
      "source": "Global Health Monitor",
      "author": "Dr. Elena Rodriguez",
      "publishedAt": "2024-01-15T09:20:00Z",
      "region": "Global",
      "priority": "high",
      "readTime": 6,
      "shares": 18400,
      "comments": 892,
      "verification": "verified",
      "tags": ["Health", "WHO", "Disease", "Global Response"],
    },
  ];

  List<Map<String, dynamic>> regionalNews = [
    {
      "region": "North America",
      "articles": [
        {
          "title": "Infrastructure Investment Act Shows Positive Results",
          "excerpt": "Job creation and economic growth exceed projections",
          "time": "2 hours ago",
        },
        {
          "title": "Tech Industry Announces Major Expansion Plans",
          "excerpt": "Silicon Valley companies commit to nationwide growth",
          "time": "4 hours ago",
        },
      ],
    },
    {
      "region": "Europe",
      "articles": [
        {
          "title": "European Union Strengthens Digital Privacy Laws",
          "excerpt": "New regulations enhance citizen data protection",
          "time": "1 hour ago",
        },
        {
          "title": "Renewable Energy Targets Exceeded Across EU",
          "excerpt": "Solar and wind power adoption surpasses goals",
          "time": "3 hours ago",
        },
      ],
    },
    {
      "region": "Asia Pacific",
      "articles": [
        {
          "title": "Trade Relations Show Signs of Improvement",
          "excerpt": "Regional partnerships strengthen economic ties",
          "time": "30 minutes ago",
        },
        {
          "title": "Innovation Hubs Drive Technology Development",
          "excerpt": "Research centers accelerate scientific progress",
          "time": "2 hours ago",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> aiInsights = [
    {
      "category": "Market Trends",
      "insight": "Technology stocks showing 15% growth correlation with AI adoption announcements",
      "confidence": 94,
      "sources": 23,
    },
    {
      "category": "Social Impact",
      "insight": "Climate change discussions increased 40% following recent policy announcements",
      "confidence": 87,
      "sources": 156,
    },
    {
      "category": "Economic Indicators",
      "insight": "Global trade volume recovering faster than predicted, suggesting economic resilience",
      "confidence": 91,
      "sources": 78,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "World News Hub",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Breaking", icon: Icon(Icons.flash_on)),
        Tab(text: "Regional", icon: Icon(Icons.public)),
        Tab(text: "AI Insights", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        // Breaking News Tab
        SingleChildScrollView(
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
                      label: "Search breaking news...",
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

              // Global Settings
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
                      label: "Language",
                      items: languages,
                      value: selectedLanguage,
                      onChanged: (value, label) {
                        selectedLanguage = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Settings Toggles
              QSwitch(
                items: [
                  {
                    "label": "Real-time Updates",
                    "value": "realtime",
                    "checked": enableRealTimeUpdates,
                  },
                  {
                    "label": "AI Summary",
                    "value": "aisummary",
                    "checked": showAISummary,
                  }
                ],
                value: [
                  if (enableRealTimeUpdates)
                    {
                      "label": "Real-time Updates",
                      "value": "realtime",
                      "checked": true
                    },
                  if (showAISummary)
                    {
                      "label": "AI Summary",
                      "value": "aisummary",
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  enableRealTimeUpdates = values.any((v) => v["value"] == "realtime");
                  showAISummary = values.any((v) => v["value"] == "aisummary");
                  setState(() {});
                },
              ),

              // Breaking News Header
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
                    "BREAKING NEWS",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  if (enableRealTimeUpdates)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "LIVE",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              // Breaking News Articles
              ...breakingNews.map((news) {
                Color priorityColor = news["priority"] == "critical"
                    ? dangerColor
                    : news["priority"] == "high"
                        ? warningColor
                        : infoColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border(
                      left: BorderSide(
                        width: 6,
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
                          "${news["image"]}",
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
                                    color: priorityColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${news["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (news["verification"] == "verified")
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          color: successColor,
                                          size: 10,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "VERIFIED",
                                          style: TextStyle(
                                            color: successColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Spacer(),
                                Text(
                                  "${news["readTime"]} min read",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${news["headline"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                height: 1.3,
                              ),
                            ),
                            Text(
                              "${news["summary"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                            if (showAISummary)
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: infoColor.withAlpha(51),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.psychology,
                                          color: infoColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "AI Analysis",
                                          style: TextStyle(
                                            color: infoColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${news["aiAnalysis"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (news["tags"] as List).map((tag) {
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
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: priorityColor.withAlpha(51),
                                  child: Text(
                                    "${news["author"]}".substring(0, 1),
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${news["author"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${news["source"]} • ${DateTime.parse("${news["publishedAt"]}").dMMMykkmm}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
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
                                      Icons.share,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((news["shares"] as int) / 1000).toStringAsFixed(1)}K",
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
                                      Icons.comment,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((news["comments"] as int) / 1000).toStringAsFixed(1)}K",
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

        // Regional News Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Regional News Coverage",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...regionalNews.map((region) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${region["region"]}",
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
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          spacing: spSm,
                          children: (region["articles"] as List).map((article) {
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
                                        Text(
                                          "${article["time"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 11,
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

        // AI Insights Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "AI-Powered News Insights",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: infoColor.withAlpha(51),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.psychology,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "AI Analysis Dashboard",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Our AI system analyzes thousands of news sources to provide real-time insights and trend predictions.",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    ...aiInsights.map((insight) {
                      Color confidenceColor = (insight["confidence"] as int) >= 90
                          ? successColor
                          : (insight["confidence"] as int) >= 70
                              ? warningColor
                              : dangerColor;

                      return Container(
                        margin: EdgeInsets.only(top: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
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
                                    color: confidenceColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${insight["category"]}",
                                    style: TextStyle(
                                      color: confidenceColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: confidenceColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${insight["confidence"]}% confidence",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${insight["insight"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Based on ${insight["sources"]} sources",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
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
}
