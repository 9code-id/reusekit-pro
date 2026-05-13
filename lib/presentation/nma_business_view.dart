import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaBusinessView extends StatefulWidget {
  const NmaBusinessView({super.key});

  @override
  State<NmaBusinessView> createState() => _NmaBusinessViewState();
}

class _NmaBusinessViewState extends State<NmaBusinessView> {
  int selectedTab = 0;
  String searchQuery = "";
  bool loading = false;
  
  List<String> tabs = ["Markets", "Corporate", "Economy", "Crypto"];

  List<Map<String, dynamic>> businessNews = [
    {
      "id": 1,
      "title": "Tech Stocks Surge as AI Investment Reaches Record High",
      "subtitle": "Major technology companies report unprecedented quarterly earnings driven by artificial intelligence",
      "category": "Markets",
      "author": "Financial Reporter Sarah Kim",
      "publishTime": "30 minutes ago",
      "readTime": "4 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=stocks",
      "views": 234500,
      "comments": 3450,
      "likes": 7890,
      "shares": 1230,
      "stockSymbol": "TECH",
      "priceChange": "+12.5%",
      "marketCap": "2.1T",
      "isPositive": true,
      "urgency": "high",
      "sector": "Technology"
    },
    {
      "id": 2,
      "title": "Federal Reserve Announces Interest Rate Decision",
      "subtitle": "Central bank maintains current rates while signaling potential future adjustments",
      "category": "Economy",
      "author": "Economic Analyst Michael Rodriguez",
      "publishTime": "1 hour ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=federal",
      "views": 189200,
      "comments": 2890,
      "likes": 5430,
      "shares": 890,
      "stockSymbol": "BOND",
      "priceChange": "-0.8%",
      "marketCap": "N/A",
      "isPositive": false,
      "urgency": "high",
      "sector": "Government"
    },
    {
      "id": 3,
      "title": "Global Manufacturing Giant Announces Massive Expansion",
      "subtitle": "Company plans to invest \$5 billion in new facilities across emerging markets",
      "category": "Corporate",
      "author": "Corporate News Team",
      "publishTime": "2 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=manufacturing",
      "views": 156800,
      "comments": 1890,
      "likes": 4230,
      "shares": 670,
      "stockSymbol": "MANF",
      "priceChange": "+8.3%",
      "marketCap": "45.2B",
      "isPositive": true,
      "urgency": "medium",
      "sector": "Manufacturing"
    },
    {
      "id": 4,
      "title": "Cryptocurrency Market Volatility Continues Despite Regulation",
      "subtitle": "Bitcoin and major altcoins experience significant price swings amid regulatory clarity",
      "category": "Crypto",
      "author": "Crypto Specialist Lisa Chen",
      "publishTime": "3 hours ago",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=crypto",
      "views": 298700,
      "comments": 5670,
      "likes": 12340,
      "shares": 2890,
      "stockSymbol": "BTC",
      "priceChange": "-15.2%",
      "marketCap": "580B",
      "isPositive": false,
      "urgency": "high",
      "sector": "Cryptocurrency"
    },
    {
      "id": 5,
      "title": "Retail Giants Report Strong Holiday Shopping Results",
      "subtitle": "Consumer spending exceeds expectations as retailers post record quarterly revenues",
      "category": "Corporate",
      "author": "Retail Industry Expert Tom Wilson",
      "publishTime": "4 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=retail",
      "views": 145600,
      "comments": 1560,
      "likes": 3890,
      "shares": 560,
      "stockSymbol": "RETL",
      "priceChange": "+6.7%",
      "marketCap": "78.9B",
      "isPositive": true,
      "urgency": "medium",
      "sector": "Retail"
    },
    {
      "id": 6,
      "title": "Energy Sector Transformation Accelerates Green Transition",
      "subtitle": "Major oil companies double down on renewable energy investments and carbon neutrality",
      "category": "Markets",
      "author": "Energy Market Analyst David Park",
      "publishTime": "6 hours ago",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=6&keyword=energy",
      "views": 123400,
      "comments": 980,
      "likes": 2780,
      "shares": 445,
      "stockSymbol": "ENRG",
      "priceChange": "+4.1%",
      "marketCap": "123.4B",
      "isPositive": true,
      "urgency": "medium",
      "sector": "Energy"
    }
  ];

  List<Map<String, dynamic>> get filteredNews {
    List<Map<String, dynamic>> filtered = businessNews;
    
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

  Color getSectorColor(String sector) {
    switch (sector.toLowerCase()) {
      case "technology":
        return infoColor;
      case "finance":
        return successColor;
      case "energy":
        return warningColor;
      case "healthcare":
        return dangerColor;
      case "retail":
        return primaryColor;
      case "manufacturing":
        return secondaryColor;
      case "cryptocurrency":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up),
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
                ss("Business news refreshed");
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
                              label: "Search business news...",
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
                      
                      // Market Summary
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              successColor.withAlpha(20),
                              primaryColor.withAlpha(20),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Market Status: OPEN",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "DOW +1.2% • S&P 500 +0.8% • NASDAQ +2.1%",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "LIVE",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    "${filteredNews.where((news) => news["isPositive"] == true).length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Positive",
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
                                    "${filteredNews.where((news) => news["isPositive"] == false).length}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "Negative",
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
                      
                      // News Section
                      Row(
                        children: [
                          Icon(
                            Icons.business,
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
                            "Live updates",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Business News List
                      Column(
                        children: filteredNews.map((news) {
                          Color sectorColor = getSectorColor(news["sector"]);
                          bool isPositive = news["isPositive"] as bool;
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              boxShadow: [shadowSm],
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: sectorColor,
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
                                      // Stock Info
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: sectorColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${news["stockSymbol"]}",
                                              style: TextStyle(
                                                color: sectorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${news["priceChange"]}",
                                              style: TextStyle(
                                                color: isPositive ? successColor : dangerColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        isPositive ? Icons.trending_up : Icons.trending_down,
                                        color: isPositive ? successColor : dangerColor,
                                        size: 16,
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
                                      
                                      // Market Cap & Sector Info
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: sectorColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${news["sector"]}",
                                              style: TextStyle(
                                                color: sectorColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (news["marketCap"] != "N/A")
                                            Container(
                                              margin: EdgeInsets.only(left: 4),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: infoColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "Cap: \$${news["marketCap"]}",
                                                style: TextStyle(
                                                  color: infoColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                                                  ss("News added to watchlist");
                                                },
                                                child: Icon(
                                                  Icons.add_chart,
                                                  color: disabledBoldColor,
                                                  size: 18,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              GestureDetector(
                                                onTap: () {
                                                  ss("News shared");
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: disabledBoldColor,
                                                  size: 18,
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
                      
                      SizedBox(height: spMd),
                      
                      // Load More Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Load More Business News",
                          size: bs.md,
                          onPressed: () {
                            ss("Loading more business news...");
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
