import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaStockNewsView extends StatefulWidget {
  const NmaStockNewsView({super.key});

  @override
  State<NmaStockNewsView> createState() => _NmaStockNewsViewState();
}

class _NmaStockNewsViewState extends State<NmaStockNewsView> {
  String selectedCategory = "All";
  String selectedTimeframe = "1D";
  String searchQuery = "";

  List<Map<String, dynamic>> stockNews = [
    {
      "title": "Apple Stock Soars on Q4 Earnings Beat",
      "symbol": "AAPL",
      "price": 185.25,
      "change": 8.45,
      "changePercent": 4.77,
      "time": "2 hours ago",
      "source": "MarketWatch",
      "image": "https://picsum.photos/300/200?random=1&keyword=apple",
      "summary": "Apple Inc. reported better-than-expected earnings for Q4, driven by strong iPhone 15 sales and services revenue growth.",
      "category": "Technology",
      "sentiment": "positive"
    },
    {
      "title": "Tesla Announces New Gigafactory in Mexico",
      "symbol": "TSLA",
      "price": 251.80,
      "change": -3.20,
      "changePercent": -1.26,
      "time": "4 hours ago",
      "source": "Reuters",
      "image": "https://picsum.photos/300/200?random=2&keyword=tesla",
      "summary": "Tesla reveals plans for a new manufacturing facility in Mexico, expected to produce 2 million vehicles annually.",
      "category": "Automotive",
      "sentiment": "positive"
    },
    {
      "title": "Microsoft Azure Revenue Grows 28% YoY",
      "symbol": "MSFT",
      "price": 420.15,
      "change": 12.75,
      "changePercent": 3.13,
      "time": "6 hours ago",
      "source": "CNBC",
      "image": "https://picsum.photos/300/200?random=3&keyword=microsoft",
      "summary": "Microsoft's cloud computing division continues its strong growth trajectory with AI integration driving demand.",
      "category": "Technology",
      "sentiment": "positive"
    },
    {
      "title": "Banking Sector Faces Regulatory Pressure",
      "symbol": "JPM",
      "price": 142.85,
      "change": -2.15,
      "changePercent": -1.48,
      "time": "8 hours ago",
      "source": "Bloomberg",
      "image": "https://picsum.photos/300/200?random=4&keyword=banking",
      "summary": "New regulatory proposals could impact profitability of major banking institutions.",
      "category": "Banking",
      "sentiment": "negative"
    },
    {
      "title": "Oil Prices Rise on Supply Concerns",
      "symbol": "XOM",
      "price": 118.45,
      "change": 3.85,
      "changePercent": 3.36,
      "time": "1 day ago",
      "source": "Wall Street Journal",
      "image": "https://picsum.photos/300/200?random=5&keyword=oil",
      "summary": "Crude oil prices surge amid geopolitical tensions and production cuts from major suppliers.",
      "category": "Energy",
      "sentiment": "positive"
    },
    {
      "title": "Amazon Expands Healthcare Division",
      "symbol": "AMZN",
      "price": 145.20,
      "change": 2.30,
      "changePercent": 1.61,
      "time": "1 day ago",
      "source": "Forbes",
      "image": "https://picsum.photos/300/200?random=6&keyword=amazon",
      "summary": "Amazon announces major expansion into telehealth services and pharmacy operations.",
      "category": "Healthcare",
      "sentiment": "positive"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Banking", "value": "Banking"},
    {"label": "Energy", "value": "Energy"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Automotive", "value": "Automotive"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "1D", "value": "1D"},
    {"label": "1W", "value": "1W"},
    {"label": "1M", "value": "1M"},
    {"label": "3M", "value": "3M"},
    {"label": "1Y", "value": "1Y"},
  ];

  List<Map<String, dynamic>> get filteredNews {
    return stockNews.where((news) {
      final matchesCategory = selectedCategory == "All" || news["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          news["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          news["symbol"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case 'positive':
        return successColor;
      case 'negative':
        return dangerColor;
      default:
        return warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock News"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Navigate to saved articles
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
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search stocks or news...",
                    value: searchQuery,
                    hint: "Enter symbol or keyword",
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
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
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
                ],
              ),
            ),

            // Market Summary Header
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
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Market Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "S&P 500",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "4,785.32",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "+23.45 (+0.49%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade200,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NASDAQ",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "15,456.78",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "+89.12 (+0.58%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade200,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DOW",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "37,892.45",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "-15.23 (-0.04%)",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade200,
                            ),
                          ),
                        ],
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
                  "Latest Stock News",
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
                margin: EdgeInsets.only(bottom: spSm),
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
                      child: Image.network(
                        "${news["image"]}",
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stock Symbol and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${news["symbol"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${(news["price"] as double).toStringAsFixed(2)}",
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
                                      color: (news["change"] as double) >= 0 
                                          ? successColor 
                                          : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(news["change"] as double) >= 0 ? '+' : ''}${(news["change"] as double).toStringAsFixed(2)} (${(news["changePercent"] as double) >= 0 ? '+' : ''}${(news["changePercent"] as double).toStringAsFixed(2)}%)",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // News Title
                          Text(
                            "${news["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),

                          // News Summary
                          Text(
                            "${news["summary"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),

                          // News Meta
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: _getSentimentColor("${news["sentiment"]}"),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${news["source"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${news["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Share article
                                    },
                                    child: Icon(
                                      Icons.share,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  GestureDetector(
                                    onTap: () {
                                      // Bookmark article
                                    },
                                    child: Icon(
                                      Icons.bookmark_border,
                                      size: 18,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Read More Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Read Full Article",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to full article
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Load More Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More News",
                size: bs.md,
                onPressed: () {
                  // Load more news
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
