import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaWorldNewsView extends StatefulWidget {
  const NmaWorldNewsView({super.key});

  @override
  State<NmaWorldNewsView> createState() => _NmaWorldNewsViewState();
}

class _NmaWorldNewsViewState extends State<NmaWorldNewsView> {
  String selectedCategory = "All";
  String selectedRegion = "Global";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Politics", "value": "Politics"},
    {"label": "Economics", "value": "Economics"},
    {"label": "Conflicts", "value": "Conflicts"},
    {"label": "Diplomacy", "value": "Diplomacy"},
    {"label": "Human Rights", "value": "Human Rights"},
    {"label": "Climate", "value": "Climate"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "Global", "value": "Global"},
    {"label": "North America", "value": "North America"},
    {"label": "Europe", "value": "Europe"},
    {"label": "Asia Pacific", "value": "Asia Pacific"},
    {"label": "Middle East", "value": "Middle East"},
    {"label": "Africa", "value": "Africa"},
    {"label": "Latin America", "value": "Latin America"},
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "id": 1,
      "title": "G20 Summit Reaches Historic Climate Agreement",
      "summary": "World leaders unite on unprecedented \$500 billion fund for renewable energy transition",
      "category": "Politics",
      "region": "Global",
      "country": "Brazil",
      "author": "International Desk",
      "publishedAt": "2024-12-15T18:30:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=1&keyword=summit",
      "readTime": "7 min read",
      "isBreaking": true,
      "urgency": "high",
      "sources": ["Reuters", "AP", "BBC"],
    },
    {
      "id": 2,
      "title": "European Union Announces Major Trade Deal with Southeast Asia",
      "summary": "Historic agreement removes tariffs on 95% of goods, boosting economic cooperation",
      "category": "Economics",
      "region": "Europe",
      "country": "Belgium",
      "author": "Economic Reporter",
      "publishedAt": "2024-12-15T16:45:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=2&keyword=trade",
      "readTime": "5 min read",
      "isBreaking": false,
      "urgency": "medium",
      "sources": ["Financial Times", "Euronews"],
    },
  ];

  List<Map<String, dynamic>> topStories = [
    {
      "id": 3,
      "title": "Peace Talks Resume Between Neighboring Nations",
      "category": "Diplomacy",
      "region": "Middle East",
      "country": "Jordan",
      "publishedAt": "2024-12-15T15:20:00Z",
      "views": 245600,
      "importance": "high",
    },
    {
      "id": 4,
      "title": "Global Food Crisis: UN Calls for Emergency Aid",
      "category": "Human Rights",
      "region": "Africa",
      "country": "Ethiopia",
      "publishedAt": "2024-12-15T14:15:00Z",
      "views": 189300,
      "importance": "critical",
    },
    {
      "id": 5,
      "title": "Cyber Security Breach Affects Multiple Governments",
      "category": "Politics",
      "region": "Global",
      "country": "International",
      "publishedAt": "2024-12-15T13:30:00Z",
      "views": 156800,
      "importance": "high",
    },
    {
      "id": 6,
      "title": "Renewable Energy Investment Reaches Record High",
      "category": "Economics",
      "region": "Asia Pacific",
      "country": "China",
      "publishedAt": "2024-12-15T12:45:00Z",
      "views": 134200,
      "importance": "medium",
    },
  ];

  List<Map<String, dynamic>> conflictUpdates = [
    {
      "location": "Eastern Europe",
      "status": "Ongoing",
      "lastUpdate": "2024-12-15T17:00:00Z",
      "casualties": "Civilian casualties reported",
      "diplomaticEfforts": "UN mediators continue negotiations",
      "humanitarianAid": "Red Cross delivers supplies to affected areas",
      "severity": "high",
    },
    {
      "location": "Horn of Africa",
      "status": "Ceasefire",
      "lastUpdate": "2024-12-15T14:30:00Z",
      "casualties": "No recent casualties",
      "diplomaticEfforts": "African Union peace talks scheduled",
      "humanitarianAid": "WHO provides medical assistance",
      "severity": "medium",
    },
  ];

  List<Map<String, dynamic>> economicIndicators = [
    {
      "indicator": "Global GDP Growth",
      "value": "3.2%",
      "change": "+0.3%",
      "trend": "positive",
      "period": "Q3 2024",
    },
    {
      "indicator": "World Trade Volume",
      "value": "\$28.5T",
      "change": "+1.8%",
      "trend": "positive",
      "period": "2024 YTD",
    },
    {
      "indicator": "Oil Price (Brent)",
      "value": "\$78.50",
      "change": "-2.1%",
      "trend": "negative",
      "period": "Today",
    },
    {
      "indicator": "Global Inflation",
      "value": "4.1%",
      "change": "-0.5%",
      "trend": "positive",
      "period": "November 2024",
    },
  ];

  List<Map<String, dynamic>> diplomaticEvents = [
    {
      "event": "UN Security Council Emergency Meeting",
      "date": "2024-12-16",
      "time": "14:00 UTC",
      "topic": "Global Food Security Crisis",
      "participants": ["P5 Members", "Regional Representatives"],
      "importance": "high",
    },
    {
      "event": "ASEAN Summit 2024",
      "date": "2024-12-18",
      "time": "09:00 UTC",
      "topic": "Regional Economic Integration",
      "participants": ["10 ASEAN Members", "Dialogue Partners"],
      "importance": "medium",
    },
    {
      "event": "COP29 Follow-up Conference",
      "date": "2024-12-20",
      "time": "10:00 UTC",
      "topic": "Climate Action Implementation",
      "participants": ["196 Countries", "NGO Representatives"],
      "importance": "high",
    },
  ];

  List<Map<String, dynamic>> worldLeaders = [
    {
      "leader": "Angela Merkel (Former Chancellor)",
      "country": "Germany",
      "announcement": "Calls for strengthened European unity in global challenges",
      "imageUrl": "https://picsum.photos/80/80?random=7&keyword=leader",
      "publishedAt": "2024-12-15T16:00:00Z",
      "impact": "high",
    },
    {
      "leader": "Justin Trudeau",
      "country": "Canada",
      "announcement": "Announces new Arctic sovereignty initiative",
      "imageUrl": "https://picsum.photos/80/80?random=8&keyword=politician",
      "publishedAt": "2024-12-15T15:30:00Z",
      "impact": "medium",
    },
    {
      "leader": "Narendra Modi",
      "country": "India",
      "announcement": "Launches major renewable energy partnership with Africa",
      "imageUrl": "https://picsum.photos/80/80?random=9&keyword=minister",
      "publishedAt": "2024-12-15T14:45:00Z",
      "impact": "high",
    },
  ];

  List<Map<String, dynamic>> humanRightsNews = [
    {
      "title": "UN Human Rights Council Issues Statement on Press Freedom",
      "location": "Multiple Countries",
      "issue": "Journalist Safety",
      "impact": "183 journalists imprisoned globally",
      "action": "International pressure campaign launched",
      "publishedAt": "2024-12-15T13:20:00Z",
      "urgency": "high",
    },
    {
      "title": "Women's Rights Progress in Education Access",
      "location": "Sub-Saharan Africa",
      "issue": "Education Equality",
      "impact": "2.3 million girls gain school access",
      "action": "UNESCO partnership programs expanded",
      "publishedAt": "2024-12-15T11:15:00Z",
      "urgency": "positive",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("World News"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              // Language selection
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QCategoryPicker(
                  label: "Category",
                  items: categoryItems,
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
                QCategoryPicker(
                  label: "Region",
                  items: regionItems,
                  value: selectedRegion,
                  onChanged: (index, label, value, item) {
                    selectedRegion = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Breaking News Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.flash_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Breaking World News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: breakingNews.map((news) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to full article
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage("${news["imageUrl"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (news["isBreaking"])
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "BREAKING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      top: spSm,
                                      right: spSm,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getUrgencyColor(news["urgency"]),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["urgency"]}".toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${news["category"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${news["region"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${news["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${news["summary"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${news["country"]} • ${news["author"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${news["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${DateTime.parse(news["publishedAt"]).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      spacing: spXs,
                                      children: (news["sources"] as List).map((source) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "$source",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,
                                              color: successColor,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Top Stories Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.trending_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Top Stories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: topStories.map((story) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to story
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getImportanceColor(story["importance"]),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getImportanceColor(story["importance"]).withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${story["importance"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: _getImportanceColor(story["importance"]),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${story["category"]}",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${story["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${story["country"]} • ${story["region"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${DateTime.parse(story["publishedAt"]).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Column(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  Text(
                                    "${((story["views"] as int) / 1000).toStringAsFixed(1)}K",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Conflict Updates & Economic Indicators
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                // Conflict Updates
                Container(
                  padding: EdgeInsets.all(spSm),
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
                            Icons.warning_amber,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Conflict Updates",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: conflictUpdates.map((conflict) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: _getSeverityColor(conflict["severity"]),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${conflict["location"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColorConflict(conflict["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${conflict["status"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColorConflict(conflict["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Casualties: ${conflict["casualties"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Diplomatic: ${conflict["diplomaticEfforts"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Aid: ${conflict["humanitarianAid"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Updated: ${DateTime.parse(conflict["lastUpdate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Economic Indicators
                Container(
                  padding: EdgeInsets.all(spSm),
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
                            Icons.trending_up,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Economic Indicators",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: economicIndicators.map((indicator) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${indicator["indicator"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      indicator["trend"] == "positive" ? Icons.trending_up : Icons.trending_down,
                                      color: _getTrendColor(indicator["trend"]),
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${indicator["value"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getTrendColor(indicator["trend"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${indicator["change"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getTrendColor(indicator["trend"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${indicator["period"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Diplomatic Events
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.handshake,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upcoming Diplomatic Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: diplomaticEvents.map((event) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getImportanceColor(event["importance"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${event["importance"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: _getImportanceColor(event["importance"]),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${event["date"]} • ${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${event["event"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Topic: ${event["topic"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Participants: ${(event["participants"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // World Leaders & Human Rights
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                // World Leaders News
                Container(
                  padding: EdgeInsets.all(spSm),
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
                            Icons.account_balance,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "World Leaders",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: worldLeaders.map((leader) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to leader news
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage("${leader["imageUrl"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: spXs,
                                      children: [
                                        Text(
                                          "${leader["leader"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${leader["country"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${leader["announcement"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Human Rights News
                Container(
                  padding: EdgeInsets.all(spSm),
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
                            Icons.balance,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Human Rights",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: spXs,
                        children: humanRightsNews.map((rights) {
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: _getUrgencyColorHuman(rights["urgency"]),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getUrgencyColorHuman(rights["urgency"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${rights["issue"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getUrgencyColorHuman(rights["urgency"]),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${rights["title"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${rights["location"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Impact: ${rights["impact"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Action: ${rights["action"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColorConflict(String status) {
    switch (status) {
      case "Ongoing":
        return dangerColor;
      case "Ceasefire":
        return warningColor;
      case "Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "positive":
        return successColor;
      case "negative":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColorHuman(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "positive":
        return successColor;
      case "medium":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
