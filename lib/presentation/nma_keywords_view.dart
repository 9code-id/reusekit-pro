import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaKeywordsView extends StatefulWidget {
  const NmaKeywordsView({super.key});

  @override
  State<NmaKeywordsView> createState() => _NmaKeywordsViewState();
}

class _NmaKeywordsViewState extends State<NmaKeywordsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool isLoading = false;
  String sortBy = "popularity";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "High Volume", "value": "High Volume"},
    {"label": "Low Competition", "value": "Low Competition"},
    {"label": "Trending", "value": "Trending"},
    {"label": "Long Tail", "value": "Long Tail"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popularity", "value": "popularity"},
    {"label": "Search Volume", "value": "volume"},
    {"label": "Competition", "value": "competition"},
    {"label": "CPC", "value": "cpc"},
    {"label": "Difficulty", "value": "difficulty"},
  ];

  List<Map<String, dynamic>> keywordsData = [
    {
      "keyword": "social media marketing",
      "searchVolume": 450000,
      "competition": "Medium",
      "difficulty": 65,
      "cpc": 2.35,
      "trend": "Rising",
      "category": "Marketing",
      "relatedKeywords": ["digital marketing", "online marketing", "social advertising"],
    },
    {
      "keyword": "content marketing strategy",
      "searchVolume": 180000,
      "competition": "High",
      "difficulty": 78,
      "cpc": 3.25,
      "trend": "Stable",
      "category": "Content",
      "relatedKeywords": ["content creation", "marketing strategy", "content planning"],
    },
    {
      "keyword": "instagram marketing tips",
      "searchVolume": 95000,
      "competition": "Low",
      "difficulty": 42,
      "cpc": 1.85,
      "trend": "Rising",
      "category": "Social Media",
      "relatedKeywords": ["instagram growth", "social media tips", "instagram strategy"],
    },
    {
      "keyword": "email marketing automation",
      "searchVolume": 76000,
      "competition": "Medium",
      "difficulty": 58,
      "cpc": 4.15,
      "trend": "Stable",
      "category": "Email",
      "relatedKeywords": ["email campaigns", "marketing automation", "email sequences"],
    },
    {
      "keyword": "video marketing trends",
      "searchVolume": 62000,
      "competition": "Low",
      "difficulty": 35,
      "cpc": 2.95,
      "trend": "Rising",
      "category": "Video",
      "relatedKeywords": ["video content", "video advertising", "youtube marketing"],
    },
    {
      "keyword": "influencer marketing ROI",
      "searchVolume": 41000,
      "competition": "High",
      "difficulty": 72,
      "cpc": 5.45,
      "trend": "Falling",
      "category": "Influencer",
      "relatedKeywords": ["influencer campaigns", "marketing ROI", "brand partnerships"],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadKeywords();
  }

  void _loadKeywords() {
    isLoading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      isLoading = false;
      setState(() {});
    });
  }

  List<Map<String, dynamic>> get filteredKeywords {
    var filtered = keywordsData;
    
    if (selectedCategory != "All") {
      if (selectedCategory == "High Volume") {
        filtered = filtered.where((keyword) => 
          (keyword["searchVolume"] as int) > 100000).toList();
      } else if (selectedCategory == "Low Competition") {
        filtered = filtered.where((keyword) => 
          keyword["competition"] == "Low").toList();
      } else if (selectedCategory == "Trending") {
        filtered = filtered.where((keyword) => 
          keyword["trend"] == "Rising").toList();
      } else if (selectedCategory == "Long Tail") {
        filtered = filtered.where((keyword) => 
          (keyword["keyword"] as String).split(" ").length >= 3).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((keyword) => 
        (keyword["keyword"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (keyword["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort results
    filtered.sort((a, b) {
      switch (sortBy) {
        case "volume":
          return (b["searchVolume"] as int).compareTo(a["searchVolume"] as int);
        case "competition":
          return (a["difficulty"] as int).compareTo(b["difficulty"] as int);
        case "cpc":
          return (b["cpc"] as double).compareTo(a["cpc"] as double);
        case "difficulty":
          return (a["difficulty"] as int).compareTo(b["difficulty"] as int);
        default:
          return (b["searchVolume"] as int).compareTo(a["searchVolume"] as int);
      }
    });
    
    return filtered;
  }

  Color _getDifficultyColor(int difficulty) {
    if (difficulty < 40) return successColor;
    if (difficulty < 70) return warningColor;
    return dangerColor;
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "Rising":
        return successColor;
      case "Falling":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keywords Research"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Export keywords
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Search and Sort
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search keywords...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter Keywords",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Overview Stats
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
                                "Total Keywords",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${keywordsData.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                                "Avg. Volume",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((keywordsData.map((k) => k["searchVolume"] as int).reduce((a, b) => a + b)) / keywordsData.length / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                                "Avg. CPC",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${((keywordsData.map((k) => k["cpc"] as double).reduce((a, b) => a + b)) / keywordsData.length).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Keywords List
                  Text(
                    "Keywords (${filteredKeywords.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredKeywords.length,
                    itemBuilder: (context, index) {
                      final keyword = filteredKeywords[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${keyword["keyword"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: infoColor.withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${keyword["category"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: infoColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getTrendColor(keyword["trend"] as String).withAlpha(30),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${keyword["trend"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getTrendColor(keyword["trend"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Save keyword
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Search Volume",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${((keyword["searchVolume"] as int) / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Competition",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${keyword["competition"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: keyword["competition"] == "Low" ? successColor :
                                                keyword["competition"] == "Medium" ? warningColor : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CPC",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(keyword["cpc"] as double).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Difficulty",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${keyword["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: _getDifficultyColor(keyword["difficulty"] as int),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              "Related Keywords:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (keyword["relatedKeywords"] as List<String>).map((related) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    related,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: secondaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Use Keyword",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Use keyword
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.analytics,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View analytics
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share keyword
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
