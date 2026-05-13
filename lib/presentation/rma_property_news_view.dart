import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPropertyNewsView extends StatefulWidget {
  const RmaPropertyNewsView({super.key});

  @override
  State<RmaPropertyNewsView> createState() => _RmaPropertyNewsViewState();
}

class _RmaPropertyNewsViewState extends State<RmaPropertyNewsView> {
  String selectedCategory = "All";
  String selectedTimeframe = "This Week";
  bool showFavorites = false;
  
  List<Map<String, dynamic>> newsArticles = [
    {
      "id": "1",
      "title": "NYC Housing Market Reaches New Highs in Q4 2023",
      "excerpt": "The New York City real estate market has demonstrated remarkable resilience with record-breaking sales and price appreciation across multiple boroughs.",
      "content": "Full article content here...",
      "author": "Sarah Chen",
      "publishDate": "2024-01-20",
      "readTime": "5 min read",
      "category": "Market Trends",
      "source": "NYC Real Estate Weekly",
      "image": "https://picsum.photos/400/250?random=1&keyword=newyork",
      "tags": ["NYC", "Housing Market", "Sales", "Trends"],
      "viewCount": 2547,
      "shareCount": 156,
      "isFavorite": false,
      "isBreaking": true,
      "priority": "high"
    },
    {
      "id": "2",
      "title": "New Luxury Development Announced for Manhattan's Upper East Side",
      "excerpt": "A 50-story luxury residential tower is set to break ground next year, featuring premium amenities and unparalleled city views.",
      "content": "Full article content here...",
      "author": "Michael Rodriguez",
      "publishDate": "2024-01-19",
      "readTime": "3 min read",
      "category": "Development",
      "source": "Manhattan Business Journal",
      "image": "https://picsum.photos/400/250?random=2&keyword=luxury",
      "tags": ["Manhattan", "Luxury", "Development", "Upper East Side"],
      "viewCount": 1823,
      "shareCount": 89,
      "isFavorite": true,
      "isBreaking": false,
      "priority": "medium"
    },
    {
      "id": "3",
      "title": "Federal Reserve Rate Decision Impacts Real Estate Financing",
      "excerpt": "The latest interest rate announcement from the Federal Reserve is expected to influence mortgage rates and real estate investment strategies.",
      "content": "Full article content here...",
      "author": "Jennifer Park",
      "publishDate": "2024-01-18",
      "readTime": "7 min read",
      "category": "Finance",
      "source": "Real Estate Finance Today",
      "image": "https://picsum.photos/400/250?random=3&keyword=finance",
      "tags": ["Interest Rates", "Federal Reserve", "Mortgage", "Investment"],
      "viewCount": 3421,
      "shareCount": 234,
      "isFavorite": false,
      "isBreaking": false,
      "priority": "high"
    },
    {
      "id": "4",
      "title": "Brooklyn's Emerging Neighborhoods Show Strong Growth Potential",
      "excerpt": "Several up-and-coming Brooklyn neighborhoods are attracting investors and young professionals with their cultural scene and affordability.",
      "content": "Full article content here...",
      "author": "David Wilson",
      "publishDate": "2024-01-17",
      "readTime": "6 min read",
      "category": "Neighborhoods",
      "source": "Brooklyn Real Estate Report",
      "image": "https://picsum.photos/400/250?random=4&keyword=brooklyn",
      "tags": ["Brooklyn", "Neighborhoods", "Investment", "Growth"],
      "viewCount": 1456,
      "shareCount": 78,
      "isFavorite": true,
      "isBreaking": false,
      "priority": "medium"
    },
    {
      "id": "5",
      "title": "Sustainable Building Practices Transform NYC Construction",
      "excerpt": "Green building initiatives and sustainable construction methods are becoming the new standard in New York's development projects.",
      "content": "Full article content here...",
      "author": "Lisa Thompson",
      "publishDate": "2024-01-16",
      "readTime": "4 min read",
      "category": "Sustainability",
      "source": "Green Building NYC",
      "image": "https://picsum.photos/400/250?random=5&keyword=green",
      "tags": ["Sustainability", "Green Building", "Construction", "Environment"],
      "viewCount": 987,
      "shareCount": 45,
      "isFavorite": false,
      "isBreaking": false,
      "priority": "low"
    },
    {
      "id": "6",
      "title": "Co-living Spaces Gain Popularity Among Young Professionals",
      "excerpt": "The co-living trend continues to grow in NYC as millennials and Gen Z seek affordable, community-oriented housing solutions.",
      "content": "Full article content here...",
      "author": "Alex Kim",
      "publishDate": "2024-01-15",
      "readTime": "5 min read",
      "category": "Lifestyle",
      "source": "Urban Living Magazine",
      "image": "https://picsum.photos/400/250?random=6&keyword=coliving",
      "tags": ["Co-living", "Millennials", "Housing", "Community"],
      "viewCount": 1234,
      "shareCount": 67,
      "isFavorite": false,
      "isBreaking": false,
      "priority": "medium"
    },
    {
      "id": "7",
      "title": "Foreign Investment in NYC Real Estate Shows Signs of Recovery",
      "excerpt": "International buyers are returning to the New York real estate market after a period of reduced activity during the pandemic.",
      "content": "Full article content here...",
      "author": "Robert Chen",
      "publishDate": "2024-01-14",
      "readTime": "8 min read",
      "category": "Investment",
      "source": "International Property News",
      "image": "https://picsum.photos/400/250?random=7&keyword=international",
      "tags": ["Foreign Investment", "International", "Recovery", "Global"],
      "viewCount": 2156,
      "shareCount": 134,
      "isFavorite": true,
      "isBreaking": false,
      "priority": "high"
    }
  ];

  List<String> categories = ["All", "Market Trends", "Development", "Finance", "Neighborhoods", "Sustainability", "Lifestyle", "Investment"];
  List<String> timeframes = ["Today", "This Week", "This Month", "This Year"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property News"),
        actions: [
          Icon(Icons.bookmark),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildHeaderSection(),
            _buildBreakingNews(),
            _buildFiltersSection(),
            _buildNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.newspaper,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Text(
                "Property News",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "Stay updated with the latest real estate news and market insights",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
          Row(
            children: [
              _buildNewsStat("Today", "12"),
              SizedBox(width: spLg),
              _buildNewsStat("This Week", "47"),
              SizedBox(width: spLg),
              _buildNewsStat("Trending", "8"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakingNews() {
    List<Map<String, dynamic>> breakingNews = newsArticles.where((article) => article["isBreaking"] as bool).toList();
    
    if (breakingNews.isEmpty) return SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Icon(
              Icons.flash_on,
              color: dangerColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Breaking News",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        QHorizontalScroll(
          children: breakingNews.map((article) {
            return Container(
              width: 300,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(80), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "BREAKING",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "${article["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${article["excerpt"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "${article["source"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${article["publishDate"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Read Now",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter News",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories.map((category) => {
                    "label": category,
                    "value": category,
                  }).toList(),
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframes.map((timeframe) => {
                    "label": timeframe,
                    "value": timeframe,
                  }).toList(),
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show favorites only",
                "value": true,
                "checked": showFavorites,
              }
            ],
            value: [
              if (showFavorites)
                {
                  "label": "Show favorites only",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showFavorites = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    List<Map<String, dynamic>> filteredArticles = newsArticles.where((article) {
      bool categoryMatch = selectedCategory == "All" || article["category"] == selectedCategory;
      bool favoriteMatch = !showFavorites || (article["isFavorite"] as bool);
      return categoryMatch && favoriteMatch;
    }).toList();

    // Sort by priority and date
    filteredArticles.sort((a, b) {
      Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
      int priorityA = priorityOrder[a["priority"]] ?? 1;
      int priorityB = priorityOrder[b["priority"]] ?? 1;
      
      if (priorityA != priorityB) {
        return priorityB.compareTo(priorityA);
      }
      return (b["publishDate"] as String).compareTo(a["publishDate"] as String);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Latest News (${filteredArticles.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Column(
          spacing: spSm,
          children: filteredArticles.map((article) {
            return _buildNewsCard(article);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> article) {
    bool isFavorite = article["isFavorite"] as bool;
    bool isBreaking = article["isBreaking"] as bool;
    String priority = article["priority"] as String;
    
    Color priorityColor = priority == "high" ? dangerColor : 
                         priority == "medium" ? warningColor : successColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isBreaking ? dangerColor.withAlpha(80) : disabledOutlineBorderColor,
          width: isBreaking ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${article["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        if (isBreaking)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "BREAKING",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (isBreaking) SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${article["category"]}",
                            style: TextStyle(
                              fontSize: 8,
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            article["isFavorite"] = !isFavorite;
                            setState(() {});
                            if (!isFavorite) {
                              ss("Added to favorites");
                            } else {
                              sw("Removed from favorites");
                            }
                          },
                          child: Icon(
                            isFavorite ? Icons.bookmark : Icons.bookmark_border,
                            color: isFavorite ? warningColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${article["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 12, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text("${article["author"]}", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                        SizedBox(width: spSm),
                        Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text("${article["readTime"]}", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${article["excerpt"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (article["tags"] as List<String>).take(3).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            children: [
              Text(
                "${article["source"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "•",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${article["publishDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Text("${article["viewCount"]}", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                  SizedBox(width: spSm),
                  Icon(Icons.share, size: 12, color: disabledBoldColor),
                  SizedBox(width: 4),
                  Text("${article["shareCount"]}", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Read Article",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {
                  article["shareCount"] = (article["shareCount"] as int) + 1;
                  setState(() {});
                  ss("Article shared successfully");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.comment,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
