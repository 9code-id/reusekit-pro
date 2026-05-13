import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFinancialNewsView extends StatefulWidget {
  const NmaFinancialNewsView({super.key});

  @override
  State<NmaFinancialNewsView> createState() => _NmaFinancialNewsViewState();
}

class _NmaFinancialNewsViewState extends State<NmaFinancialNewsView> {
  String selectedCategory = "All";
  String selectedSource = "All";
  String searchQuery = "";
  bool showBookmarkedOnly = false;

  List<Map<String, dynamic>> financialNews = [
    {
      "id": "1",
      "title": "Federal Reserve Signals Potential Rate Cut in Q2 2024",
      "summary": "Fed officials hint at possible monetary policy adjustments amid inflation concerns and economic growth patterns.",
      "content": "Federal Reserve Chair Jerome Powell indicated during today's press conference that the central bank is closely monitoring economic indicators that could warrant a rate adjustment in the second quarter of 2024. The decision comes as inflation shows signs of stabilization while employment remains robust across most sectors.",
      "source": "Federal Reserve",
      "author": "Jerome Powell",
      "publishedAt": "2 hours ago",
      "category": "Monetary Policy",
      "image": "https://picsum.photos/400/250?random=1&keyword=federal-reserve",
      "readTime": "5 min read",
      "isBookmarked": false,
      "tags": ["Federal Reserve", "Interest Rates", "Monetary Policy"],
      "impact": "High"
    },
    {
      "id": "2",
      "title": "Bitcoin ETF Approval Drives Cryptocurrency Market Rally",
      "summary": "SEC approval of spot Bitcoin ETFs triggers significant institutional investment and price surge across major cryptocurrencies.",
      "content": "The Securities and Exchange Commission's approval of multiple spot Bitcoin exchange-traded funds has catalyzed a broader cryptocurrency market rally. Trading volumes have increased by 300% in the past 24 hours as institutional investors gain easier access to digital assets through traditional brokerage platforms.",
      "source": "CoinDesk",
      "author": "Sarah Johnson",
      "publishedAt": "4 hours ago",
      "category": "Cryptocurrency",
      "image": "https://picsum.photos/400/250?random=2&keyword=bitcoin",
      "readTime": "4 min read",
      "isBookmarked": true,
      "tags": ["Bitcoin", "ETF", "SEC", "Cryptocurrency"],
      "impact": "High"
    },
    {
      "id": "3",
      "title": "Global Supply Chain Disruptions Impact Manufacturing Sector",
      "summary": "Ongoing geopolitical tensions and shipping delays continue to challenge manufacturing companies worldwide.",
      "content": "Manufacturing companies across North America and Europe are facing renewed supply chain challenges as shipping costs increase and delivery times extend. Industry analysts report that raw material shortages are particularly affecting automotive and electronics sectors, with some companies considering nearshoring strategies.",
      "source": "Manufacturing Today",
      "author": "Michael Chen",
      "publishedAt": "6 hours ago",
      "category": "Industry",
      "image": "https://picsum.photos/400/250?random=3&keyword=manufacturing",
      "readTime": "6 min read",
      "isBookmarked": false,
      "tags": ["Supply Chain", "Manufacturing", "Geopolitics"],
      "impact": "Medium"
    },
    {
      "id": "4",
      "title": "ESG Investing Reaches New Milestone with \$50 Trillion AUM",
      "summary": "Environmental, Social, and Governance focused investments continue growing as sustainability becomes mainstream.",
      "content": "Environmental, Social, and Governance (ESG) focused investment funds have reached a new milestone with over \$50 trillion in assets under management globally. This represents a 15% increase from the previous year, driven by increased corporate sustainability initiatives and regulatory requirements in major markets.",
      "source": "Sustainable Finance Review",
      "author": "Emma Rodriguez",
      "publishedAt": "8 hours ago",
      "category": "ESG",
      "image": "https://picsum.photos/400/250?random=4&keyword=sustainability",
      "readTime": "7 min read",
      "isBookmarked": true,
      "tags": ["ESG", "Sustainability", "Investment"],
      "impact": "Medium"
    },
    {
      "id": "5",
      "title": "Central Bank Digital Currencies Gain Momentum Worldwide",
      "summary": "Multiple countries advance CBDC development as digital payment systems reshape financial infrastructure.",
      "content": "Central banks across Asia, Europe, and the Americas are accelerating their central bank digital currency (CBDC) development programs. The Bank of England announced successful pilot testing, while the European Central Bank revealed plans for a digital euro rollout by 2026.",
      "source": "Digital Finance Weekly",
      "author": "David Kim",
      "publishedAt": "12 hours ago",
      "category": "Digital Currency",
      "image": "https://picsum.photos/400/250?random=5&keyword=digital-currency",
      "readTime": "5 min read",
      "isBookmarked": false,
      "tags": ["CBDC", "Digital Currency", "Central Banks"],
      "impact": "High"
    },
    {
      "id": "6",
      "title": "Real Estate Investment Trusts Show Strong Performance",
      "summary": "REIT sector demonstrates resilience amid changing interest rate environment and evolving property markets.",
      "content": "Real Estate Investment Trusts (REITs) have shown remarkable performance in the current quarter, with industrial and healthcare property REITs leading gains. Analysts attribute this strength to strategic portfolio diversification and adaptive management strategies in response to changing market conditions.",
      "source": "Real Estate Finance Today",
      "author": "Lisa Thompson",
      "publishedAt": "1 day ago",
      "category": "Real Estate",
      "image": "https://picsum.photos/400/250?random=6&keyword=real-estate",
      "readTime": "6 min read",
      "isBookmarked": false,
      "tags": ["REIT", "Real Estate", "Investment"],
      "impact": "Medium"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Monetary Policy", "value": "Monetary Policy"},
    {"label": "Cryptocurrency", "value": "Cryptocurrency"},
    {"label": "Industry", "value": "Industry"},
    {"label": "ESG", "value": "ESG"},
    {"label": "Digital Currency", "value": "Digital Currency"},
    {"label": "Real Estate", "value": "Real Estate"},
  ];

  List<Map<String, dynamic>> sources = [
    {"label": "All", "value": "All"},
    {"label": "Federal Reserve", "value": "Federal Reserve"},
    {"label": "CoinDesk", "value": "CoinDesk"},
    {"label": "Manufacturing Today", "value": "Manufacturing Today"},
    {"label": "Sustainable Finance Review", "value": "Sustainable Finance Review"},
    {"label": "Digital Finance Weekly", "value": "Digital Finance Weekly"},
    {"label": "Real Estate Finance Today", "value": "Real Estate Finance Today"},
  ];

  List<Map<String, dynamic>> get filteredNews {
    return financialNews.where((news) {
      final matchesCategory = selectedCategory == "All" || news["category"] == selectedCategory;
      final matchesSource = selectedSource == "All" || news["source"] == selectedSource;
      final matchesBookmark = !showBookmarkedOnly || (news["isBookmarked"] as bool);
      final matchesSearch = searchQuery.isEmpty || 
          news["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          news["summary"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (news["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSource && matchesBookmark && matchesSearch;
    }).toList();
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case 'High':
        return dangerColor;
      case 'Medium':
        return warningColor;
      default:
        return successColor;
    }
  }

  void _toggleBookmark(String newsId) {
    final newsIndex = financialNews.indexWhere((news) => news["id"] == newsId);
    if (newsIndex != -1) {
      financialNews[newsIndex]["isBookmarked"] = !(financialNews[newsIndex]["isBookmarked"] as bool);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial News"),
        actions: [
          IconButton(
            icon: Icon(showBookmarkedOnly ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              showBookmarkedOnly = !showBookmarkedOnly;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search financial news...",
              value: searchQuery,
              hint: "Search by title, content, or tags",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
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
                          items: categories,
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
                          label: "Source",
                          items: sources,
                          value: selectedSource,
                          onChanged: (value, label) {
                            selectedSource = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // News Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${filteredNews.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Articles",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Column(
                    children: [
                      Text(
                        "${financialNews.where((news) => news["isBookmarked"] as bool).length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Bookmarked",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(100),
                  ),
                  Column(
                    children: [
                      Text(
                        "${financialNews.where((news) => news["impact"] == "High").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "High Impact",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // News List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showBookmarkedOnly ? "Bookmarked News" : "Latest Financial News",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${filteredNews.length} articles",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            // News List
            ...filteredNews.map((news) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // News Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${news["image"]}",
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getImpactColor("${news["impact"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${news["impact"]} Impact",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () => _toggleBookmark("${news["id"]}"),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  (news["isBookmarked"] as bool) 
                                      ? Icons.bookmark 
                                      : Icons.bookmark_border,
                                  color: Colors.white,
                                  size: 20,
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
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and Read Time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${news["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${news["readTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Title
                          Text(
                            "${news["title"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),

                          // Summary
                          Text(
                            "${news["summary"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),

                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (news["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Author and Source
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${news["author"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${news["source"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${news["publishedAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Read Article",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to full article
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  // Share article
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    size: 20,
                                    color: disabledBoldColor,
                                  ),
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

            // Load More Button
            if (filteredNews.isNotEmpty) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Articles",
                  size: bs.md,
                  onPressed: () {
                    // Load more articles
                  },
                ),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
