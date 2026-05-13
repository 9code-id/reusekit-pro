import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTrending2View extends StatefulWidget {
  @override
  State<GrlTrending2View> createState() => _GrlTrending2ViewState();
}

class _GrlTrending2ViewState extends State<GrlTrending2View> {
  int selectedPeriod = 0;
  String selectedCategory = "All";

  List<Map<String, dynamic>> periods = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Music", "value": "Music"},
    {"label": "Gaming", "value": "Gaming"},
    {"label": "News", "value": "News"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];

  List<Map<String, dynamic>> trendingItems = [
    {
      "id": 1,
      "rank": 1,
      "title": "Epic Gaming Montage 2024",
      "category": "Gaming",
      "creator": "ProGamer",
      "avatar": "https://picsum.photos/50/50?random=201",
      "thumbnail": "https://picsum.photos/300/200?random=21&keyword=gaming",
      "views": 2340000,
      "likes": 156000,
      "duration": "10:24",
      "trending_score": 98.5,
      "growth": "+245%",
      "timeAgo": "2 hours ago",
      "verified": true,
    },
    {
      "id": 2,
      "rank": 2,
      "title": "Breaking: Major Tech Announcement",
      "category": "News",
      "creator": "Tech News Daily",
      "avatar": "https://picsum.photos/50/50?random=202",
      "thumbnail": "https://picsum.photos/300/200?random=22&keyword=tech",
      "views": 1890000,
      "likes": 89000,
      "duration": "5:43",
      "trending_score": 94.2,
      "growth": "+189%",
      "timeAgo": "4 hours ago",
      "verified": true,
    },
    {
      "id": 3,
      "rank": 3,
      "title": "Top 10 Songs This Week",
      "category": "Music",
      "creator": "Music Charts",
      "avatar": "https://picsum.photos/50/50?random=203",
      "thumbnail": "https://picsum.photos/300/200?random=23&keyword=music",
      "views": 1567000,
      "likes": 234000,
      "duration": "15:20",
      "trending_score": 91.8,
      "growth": "+167%",
      "timeAgo": "6 hours ago",
      "verified": false,
    },
    {
      "id": 4,
      "rank": 4,
      "title": "Championship Final Highlights",
      "category": "Sports",
      "creator": "Sports Center",
      "avatar": "https://picsum.photos/50/50?random=204",
      "thumbnail": "https://picsum.photos/300/200?random=24&keyword=sports",
      "views": 1234000,
      "likes": 78000,
      "duration": "8:15",
      "trending_score": 88.9,
      "growth": "+134%",
      "timeAgo": "8 hours ago",
      "verified": true,
    },
    {
      "id": 5,
      "rank": 5,
      "title": "Celebrity Interview Exclusive",
      "category": "Entertainment",
      "creator": "Entertainment Tonight",
      "avatar": "https://picsum.photos/50/50?random=205",
      "thumbnail": "https://picsum.photos/300/200?random=25&keyword=celebrity",
      "views": 998000,
      "likes": 67000,
      "duration": "12:30",
      "trending_score": 85.6,
      "growth": "+112%",
      "timeAgo": "12 hours ago",
      "verified": true,
    },
    {
      "id": 6,
      "rank": 6,
      "title": "Viral Dance Challenge",
      "category": "Entertainment",
      "creator": "Dance Studio",
      "avatar": "https://picsum.photos/50/50?random=206",
      "thumbnail": "https://picsum.photos/300/200?random=26&keyword=dance",
      "views": 876000,
      "likes": 145000,
      "duration": "3:45",
      "trending_score": 82.3,
      "growth": "+98%",
      "timeAgo": "1 day ago",
      "verified": false,
    },
    {
      "id": 7,
      "rank": 7,
      "title": "New Album Release Review",
      "category": "Music",
      "creator": "Music Review Hub",
      "avatar": "https://picsum.photos/50/50?random=207",
      "thumbnail": "https://picsum.photos/300/200?random=27&keyword=album",
      "views": 734000,
      "likes": 56000,
      "duration": "18:22",
      "trending_score": 79.1,
      "growth": "+87%",
      "timeAgo": "1 day ago",
      "verified": false,
    },
    {
      "id": 8,
      "rank": 8,
      "title": "Game Review: Latest Release",
      "category": "Gaming",
      "creator": "Game Reviewer",
      "avatar": "https://picsum.photos/50/50?random=208",
      "thumbnail": "https://picsum.photos/300/200?random=28&keyword=game",
      "views": 654000,
      "likes": 43000,
      "duration": "22:10",
      "trending_score": 76.8,
      "growth": "+76%",
      "timeAgo": "2 days ago",
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == "All") {
      return trendingItems;
    }
    return trendingItems.where((item) => item["category"] == selectedCategory).toList();
  }

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[400]!;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🔥 Trending Now",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Discover what's hot and viral across all categories",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Updated 5 min ago",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Time Period Filter
            Row(
              children: [
                Text(
                  "Period:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                ...List.generate(periods.length, (index) {
                  final period = periods[index];
                  final isSelected = selectedPeriod == index;
                  return Container(
                    margin: EdgeInsets.only(right: spXs),
                    child: GestureDetector(
                      onTap: () {
                        selectedPeriod = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        child: Text(
                          "${period["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: spMd),

            // Categories
            QCategoryPicker(
              label: "Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Top 3 Trending (Special Layout)
            Text(
              "🏆 Top 3 Trending",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Container(
              height: 200,
              child: Row(
                children: [
                  // 2nd Place
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: spXs, top: spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${filteredItems[1]["thumbnail"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "2",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${filteredItems[1]["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${((filteredItems[1]["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 1st Place (Taller)
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                        border: Border.all(color: Colors.amber, width: 2),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${filteredItems[0]["thumbnail"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${filteredItems[0]["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${((filteredItems[0]["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 3rd Place
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: spXs, top: spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${filteredItems[2]["thumbnail"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.brown[400],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "3",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${filteredItems[2]["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${((filteredItems[2]["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Full Trending List
            Text(
              "📈 Complete Trending List",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            ...filteredItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Rank
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: getRankColor(item["rank"] as int),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${item["rank"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${item["thumbnail"]}",
                        width: 80,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (item["verified"] as bool)
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: successColor,
                                ),
                            ],
                          ),

                          SizedBox(height: spXs),

                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${item["avatar"]}",
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${item["creator"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "•",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${item["timeAgo"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spXs),

                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${((item["views"] as int) / 1000000).toStringAsFixed(1)}M",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["growth"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // More Options
                    Icon(
                      Icons.more_vert,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
