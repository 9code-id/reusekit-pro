import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTechnologyView extends StatefulWidget {
  const NmaTechnologyView({super.key});

  @override
  State<NmaTechnologyView> createState() => _NmaTechnologyViewState();
}

class _NmaTechnologyViewState extends State<NmaTechnologyView> {
  int selectedTab = 0;
  String searchQuery = "";
  bool loading = false;
  
  List<String> tabs = ["AI & ML", "Gadgets", "Software", "Startups"];

  List<Map<String, dynamic>> techNews = [
    {
      "id": 1,
      "title": "OpenAI Unveils GPT-5 with Revolutionary Reasoning Capabilities",
      "subtitle": "Next-generation AI model demonstrates human-level problem solving across multiple domains",
      "category": "AI & ML",
      "author": "Tech Editor Dr. Sarah Kim",
      "publishTime": "45 minutes ago",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=ai",
      "views": 456700,
      "comments": 5670,
      "likes": 12340,
      "shares": 2890,
      "isBreaking": true,
      "techCategory": "Artificial Intelligence",
      "companyValuation": "80B",
      "funding": "N/A",
      "trending": ["GPT-5", "reasoning", "openai"],
      "impact": "revolutionary"
    },
    {
      "id": 2,
      "title": "Apple Announces Next-Generation MacBook with M4 Ultra Chip",
      "subtitle": "Revolutionary silicon delivers 40% performance boost while extending battery life to 24 hours",
      "category": "Gadgets",
      "author": "Hardware Reviewer Mike Chen",
      "publishTime": "2 hours ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=macbook",
      "views": 289300,
      "comments": 3450,
      "likes": 8970,
      "shares": 1560,
      "isBreaking": false,
      "techCategory": "Hardware",
      "companyValuation": "3T",
      "funding": "N/A",
      "trending": ["macbook", "m4", "apple"],
      "impact": "high"
    },
    {
      "id": 3,
      "title": "Microsoft Integrates Advanced AI into Office Suite",
      "subtitle": "Copilot Pro brings natural language programming and document automation to 365 million users",
      "category": "Software",
      "author": "Software Analyst Jennifer Park",
      "publishTime": "4 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=microsoft",
      "views": 234500,
      "comments": 2890,
      "likes": 6780,
      "shares": 1230,
      "isBreaking": false,
      "techCategory": "Software",
      "companyValuation": "2.8T",
      "funding": "N/A",
      "trending": ["copilot", "office", "microsoft"],
      "impact": "high"
    },
    {
      "id": 4,
      "title": "Quantum Computing Startup Raises \$500M Series C Funding",
      "subtitle": "IonQ achieves breakthrough in error correction, bringing practical quantum computers closer to reality",
      "category": "Startups",
      "author": "Startup Reporter David Wilson",
      "publishTime": "6 hours ago",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=quantum",
      "views": 156800,
      "comments": 1890,
      "likes": 4560,
      "shares": 890,
      "isBreaking": true,
      "techCategory": "Quantum Computing",
      "companyValuation": "2.1B",
      "funding": "500M",
      "trending": ["quantum", "ionq", "funding"],
      "impact": "revolutionary"
    },
    {
      "id": 5,
      "title": "Tesla Debuts Full Self-Driving Version 12 with Neural Networks",
      "subtitle": "End-to-end neural network approach eliminates traditional coding for autonomous vehicle control",
      "category": "AI & ML",
      "author": "Automotive Tech Expert Lisa Rodriguez",
      "publishTime": "8 hours ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=tesla",
      "views": 345600,
      "comments": 4230,
      "likes": 9870,
      "shares": 1670,
      "isBreaking": false,
      "techCategory": "Autonomous Vehicles",
      "companyValuation": "800B",
      "funding": "N/A",
      "trending": ["fsd", "tesla", "neural"],
      "impact": "high"
    },
    {
      "id": 6,
      "title": "Meta Launches Horizon OS for Third-Party VR Headsets",
      "subtitle": "Open platform strategy aims to accelerate virtual reality adoption across multiple hardware vendors",
      "category": "Software",
      "author": "VR Specialist Tom Anderson",
      "publishTime": "10 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=6&keyword=vr",
      "views": 189200,
      "comments": 2340,
      "likes": 5670,
      "shares": 980,
      "isBreaking": false,
      "techCategory": "Virtual Reality",
      "companyValuation": "1.2T",
      "funding": "N/A",
      "trending": ["horizon", "meta", "vr"],
      "impact": "medium"
    }
  ];

  List<Map<String, dynamic>> get filteredNews {
    List<Map<String, dynamic>> filtered = techNews;
    
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

  Color getImpactColor(String impact) {
    switch (impact) {
      case "revolutionary":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return successColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "artificial intelligence":
        return dangerColor;
      case "hardware":
        return primaryColor;
      case "software":
        return infoColor;
      case "quantum computing":
        return secondaryColor;
      case "virtual reality":
        return warningColor;
      case "autonomous vehicles":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technology"),
        actions: [
          IconButton(
            icon: Icon(Icons.code),
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
                ss("Technology news refreshed");
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
                              label: "Search tech news...",
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
                      
                      // Tech Innovation Banner
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              infoColor.withAlpha(90),
                              primaryColor.withAlpha(60),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.rocket_launch,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Innovation Hub",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fsH6,
                                    ),
                                  ),
                                  Text(
                                    "Latest breakthroughs in technology",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Breaking News Alert
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
                                Icons.flash_on,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "TECH BREAKTHROUGH",
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
                      
                      // Quick Stats
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
                                    "Stories",
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
                                    "${filteredNews.where((news) => news["impact"] == "revolutionary").length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Breakthrough",
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
                                    "${filteredNews.where((news) => news["funding"] != "N/A").length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Funded",
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
                      
                      // Tech News Section
                      Row(
                        children: [
                          Icon(
                            Icons.computer,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${tabs[selectedTab]} News",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Real-time updates",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Technology News List
                      Column(
                        children: filteredNews.map((news) {
                          Color impactColor = getImpactColor(news["impact"]);
                          Color categoryColor = getCategoryColor(news["techCategory"]);
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: impactColor,
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
                                      // Tech Category
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: categoryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["techCategory"]}",
                                          style: TextStyle(
                                            color: categoryColor,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
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
                                            fontSize: 8,
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
                                          color: impactColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["impact"]}".toUpperCase(),
                                          style: TextStyle(
                                            color: impactColor,
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
                                      
                                      // Company Info
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business,
                                            size: 14,
                                            color: disabledColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Valuation: \$${news["companyValuation"]}",
                                            style: TextStyle(
                                              color: disabledColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          if (news["funding"] != "N/A")
                                            Row(
                                              children: [
                                                SizedBox(width: spSm),
                                                Icon(
                                                  Icons.trending_up,
                                                  size: 14,
                                                  color: successColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Funding: \$${news["funding"]}",
                                                  style: TextStyle(
                                                    color: successColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
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
                                      
                                      // Trending Tags
                                      Text(
                                        "Trending:",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Wrap(
                                        spacing: 4,
                                        children: (news["trending"] as List<String>).map((tag) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: impactColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "#$tag",
                                              style: TextStyle(
                                                color: impactColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      
                                      SizedBox(height: spSm),
                                      
                                      // Author & Time
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 14,
                                            color: disabledColor,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "${news["author"]}",
                                              style: TextStyle(
                                                color: disabledColor,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
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
                                        ],
                                      ),
                                      
                                      SizedBox(height: spSm),
                                      
                                      // Engagement & Actions
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
                                                "${((news["comments"] as int) / 1000).toStringAsFixed(1)}K",
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
                                                  size: 18,
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
                                                  size: 18,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              QButton(
                                                label: "Read More",
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
                      
                      SizedBox(height: spMd),
                      
                      // Load More Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Load More Tech News",
                          size: bs.md,
                          onPressed: () {
                            ss("Loading more technology news...");
                          },
                        ),
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
