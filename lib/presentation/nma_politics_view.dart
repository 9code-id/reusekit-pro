import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPoliticsView extends StatefulWidget {
  const NmaPoliticsView({super.key});

  @override
  State<NmaPoliticsView> createState() => _NmaPoliticsViewState();
}

class _NmaPoliticsViewState extends State<NmaPoliticsView> {
  int selectedTab = 0;
  String searchQuery = "";
  bool loading = false;
  
  List<String> tabs = ["Latest", "Analysis", "Elections", "Policy"];

  List<Map<String, dynamic>> politicsNews = [
    {
      "id": 1,
      "title": "Congressional Committee Passes Historic Infrastructure Bill",
      "subtitle": "Bipartisan legislation allocates \$2 trillion for roads, bridges, and digital infrastructure",
      "category": "Policy",
      "author": "Alexandra Martinez",
      "publishTime": "1 hour ago",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=congress",
      "views": 124500,
      "comments": 2340,
      "likes": 5670,
      "shares": 890,
      "isBreaking": true,
      "urgency": "high",
      "tags": ["infrastructure", "congress", "policy"],
      "politicalParty": "bipartisan",
      "region": "national"
    },
    {
      "id": 2,
      "title": "Presidential Poll Numbers Show Tight Race for 2024",
      "subtitle": "Latest polling data reveals competitive landscape across key swing states",
      "category": "Elections",
      "author": "David Thompson",
      "publishTime": "3 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=election",
      "views": 89200,
      "comments": 1890,
      "likes": 3420,
      "shares": 567,
      "isBreaking": false,
      "urgency": "medium",
      "tags": ["polls", "election", "2024"],
      "politicalParty": "neutral",
      "region": "national"
    },
    {
      "id": 3,
      "title": "Supreme Court Schedules Major Constitutional Case Hearing",
      "subtitle": "Landmark case could reshape federal vs state authority interpretations",
      "category": "Analysis",
      "author": "Judge Sarah Wilson",
      "publishTime": "5 hours ago",
      "readTime": "9 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=court",
      "views": 156300,
      "comments": 3450,
      "likes": 7890,
      "shares": 1230,
      "isBreaking": false,
      "urgency": "high",
      "tags": ["supreme court", "constitution", "federal"],
      "politicalParty": "neutral",
      "region": "national"
    },
    {
      "id": 4,
      "title": "State Governors Unite on Climate Policy Initiative",
      "subtitle": "Coalition of 15 governors announces coordinated response to climate challenges",
      "category": "Policy",
      "author": "Environmental Reporter Mike Chen",
      "publishTime": "6 hours ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=climate",
      "views": 67800,
      "comments": 980,
      "likes": 2340,
      "shares": 445,
      "isBreaking": false,
      "urgency": "medium",
      "tags": ["climate", "governors", "environment"],
      "politicalParty": "bipartisan",
      "region": "state"
    },
    {
      "id": 5,
      "title": "Foreign Policy Expert Warns of Rising Global Tensions",
      "subtitle": "Analysis reveals increasing diplomatic challenges in multiple international regions",
      "category": "Analysis",
      "author": "Dr. Rebecca Foster",
      "publishTime": "8 hours ago",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=diplomacy",
      "views": 92100,
      "comments": 1560,
      "likes": 4200,
      "shares": 780,
      "isBreaking": false,
      "urgency": "high",
      "tags": ["foreign policy", "diplomacy", "international"],
      "politicalParty": "neutral",
      "region": "international"
    },
    {
      "id": 6,
      "title": "Local Election Results Surprise Political Analysts",
      "subtitle": "Unexpected outcomes in mayoral races indicate shifting voter preferences",
      "category": "Elections",
      "author": "Local Politics Team",
      "publishTime": "10 hours ago",
      "readTime": "4 min read",
      "image": "https://picsum.photos/300/200?random=6&keyword=voting",
      "views": 45600,
      "comments": 670,
      "likes": 1890,
      "shares": 234,
      "isBreaking": false,
      "urgency": "low",
      "tags": ["local election", "mayor", "results"],
      "politicalParty": "mixed",
      "region": "local"
    }
  ];

  List<Map<String, dynamic>> get filteredNews {
    List<Map<String, dynamic>> filtered = politicsNews;
    
    if (selectedTab > 0) {
      String tabCategory = tabs[selectedTab];
      filtered = filtered.where((news) => 
        news["category"] == tabCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((news) =>
        (news["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (news["subtitle"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }

  Color getPartyColor(String party) {
    switch (party) {
      case "republican":
        return dangerColor;
      case "democrat":
        return infoColor;
      case "bipartisan":
        return successColor;
      case "neutral":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Politics"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loading = true;
              setState(() {});
              
              Future.delayed(Duration(seconds: 2), () {
                loading = false;
                setState(() {});
                ss("Politics news refreshed");
              });
            },
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Tab Bar
              Container(
                padding: EdgeInsets.all(spSm),
                child: QCategoryPicker(
                  items: tabs.asMap().entries.map((entry) => {
                    "label": entry.value,
                    "value": entry.key,
                  }).toList(),
                  value: selectedTab,
                  onChanged: (index, label, value, item) {
                    selectedTab = value;
                    setState(() {});
                  },
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Search politics news...",
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
                      
                      SizedBox(height: spMd),
                      
                      // Breaking News Banner
                      if (filteredNews.any((news) => news["isBreaking"] == true))
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: dangerColor.withAlpha(100),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.campaign,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "BREAKING POLITICAL NEWS",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${filteredNews.firstWhere((news) => news["isBreaking"] == true)["title"]}",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      SizedBox(height: spMd),
                      
                      // Stats Row
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${filteredNews.length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Articles",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${filteredNews.where((news) => news["isBreaking"] == true).length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Breaking",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${((filteredNews.fold(0.0, (sum, news) => sum + (news["views"] as int))) / 1000000).toStringAsFixed(1)}M",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Views",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // News Section Header
                      Text(
                        "${tabs[selectedTab]} Political News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // News List
                      if (filteredNews.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spLg),
                          child: Column(
                            children: [
                              Icon(
                                Icons.account_balance,
                                size: 64,
                                color: disabledColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "No political news found",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Try adjusting your search or category filter",
                                style: TextStyle(
                                  color: disabledColor,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: filteredNews.map((news) {
                            Color urgencyColor = getUrgencyColor(news["urgency"]);
                            Color partyColor = getPartyColor(news["politicalParty"]);
                            
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                boxShadow: [shadowSm],
                                border: Border(
                                  left: BorderSide(
                                    width: 4,
                                    color: urgencyColor,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // News Header
                                  Padding(
                                    padding: EdgeInsets.all(spSm),
                                    child: Row(
                                      children: [
                                        // Category & Breaking Badge
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${news["category"]}",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (news["isBreaking"] == true)
                                          Container(
                                            margin: EdgeInsets.only(left: 4),
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
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: partyColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${news["politicalParty"]}".toUpperCase(),
                                            style: TextStyle(
                                              color: partyColor,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // News Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    child: Image.network(
                                      "${news["image"]}",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  
                                  Padding(
                                    padding: EdgeInsets.all(spSm),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // News Title
                                        Text(
                                          "${news["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        
                                        SizedBox(height: spXs),
                                        
                                        // News Subtitle
                                        Text(
                                          "${news["subtitle"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                        SizedBox(height: spSm),
                                        
                                        // News Meta
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 14,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${news["author"]}",
                                              style: TextStyle(
                                                color: disabledColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: spSm),
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${news["publishTime"]}",
                                              style: TextStyle(
                                                color: disabledColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Spacer(),
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
                                                "${news["readTime"]}",
                                                style: TextStyle(
                                                  color: infoColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        
                                        SizedBox(height: spSm),
                                        
                                        // Tags
                                        Wrap(
                                          spacing: 4,
                                          children: (news["tags"] as List<String>).map((tag) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: urgencyColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "#$tag",
                                                style: TextStyle(
                                                  color: urgencyColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        
                                        SizedBox(height: spSm),
                                        
                                        // Engagement Stats
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.visibility,
                                                  size: 16,
                                                  color: disabledColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${((news["views"] as int) / 1000).toStringAsFixed(0)}K",
                                                  style: TextStyle(
                                                    color: disabledColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: spSm),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up,
                                                  size: 16,
                                                  color: disabledColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${((news["likes"] as int) / 1000).toStringAsFixed(1)}K",
                                                  style: TextStyle(
                                                    color: disabledColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: spSm),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.comment,
                                                  size: 16,
                                                  color: disabledColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${news["comments"]}",
                                                  style: TextStyle(
                                                    color: disabledColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    ss("Article bookmarked");
                                                  },
                                                  child: Icon(
                                                    Icons.bookmark_border,
                                                    color: disabledBoldColor,
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                GestureDetector(
                                                  onTap: () {
                                                    ss("Article shared");
                                                  },
                                                  child: Icon(
                                                    Icons.share,
                                                    color: disabledBoldColor,
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                QButton(
                                                  label: "Read Full",
                                                  size: bs.sm,
                                                  onPressed: () {},
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
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
