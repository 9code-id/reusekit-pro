import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle6View extends StatefulWidget {
  @override
  State<GrlArticle6View> createState() => _GrlArticle6ViewState();
}

class _GrlArticle6ViewState extends State<GrlArticle6View> {
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Technology",
      "icon": Icons.computer,
      "color": primaryColor,
      "count": 245,
      "trending": true,
    },
    {
      "id": 2,
      "name": "Business",
      "icon": Icons.business,
      "color": successColor,
      "count": 189,
      "trending": false,
    },
    {
      "id": 3,
      "name": "Health",
      "icon": Icons.health_and_safety,
      "color": dangerColor,
      "count": 156,
      "trending": true,
    },
    {
      "id": 4,
      "name": "Science",
      "icon": Icons.science,
      "color": infoColor,
      "count": 134,
      "trending": false,
    },
    {
      "id": 5,
      "name": "Travel",
      "icon": Icons.flight,
      "color": warningColor,
      "count": 98,
      "trending": true,
    },
    {
      "id": 6,
      "name": "Food",
      "icon": Icons.restaurant,
      "color": Colors.orange,
      "count": 87,
      "trending": false,
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"name": "Artificial Intelligence", "articles": 45},
    {"name": "Climate Change", "articles": 38},
    {"name": "Cryptocurrency", "articles": 29},
    {"name": "Remote Work", "articles": 24},
    {"name": "Mental Health", "articles": 22},
  ];

  List<Map<String, dynamic>> featuredAuthors = [
    {
      "name": "Dr. Sarah Johnson",
      "expertise": "AI Researcher",
      "articles": 28,
      "followers": 15400,
      "image": "https://picsum.photos/100/100?random=1&keyword=woman-professional",
      "verified": true,
    },
    {
      "name": "Prof. Michael Chen",
      "expertise": "Environmental Scientist",
      "articles": 22,
      "followers": 12800,
      "image": "https://picsum.photos/100/100?random=2&keyword=man-professional",
      "verified": true,
    },
    {
      "name": "Lisa Rodriguez",
      "expertise": "Business Strategist",
      "articles": 31,
      "followers": 18900,
      "image": "https://picsum.photos/100/100?random=3&keyword=woman-business",
      "verified": false,
    },
    {
      "name": "Dr. Amanda Kim",
      "expertise": "Health & Wellness",
      "articles": 19,
      "followers": 9600,
      "image": "https://picsum.photos/100/100?random=4&keyword=woman-doctor",
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> recentArticles = [
    {
      "title": "The Future of Quantum Computing",
      "author": "Dr. Sarah Johnson",
      "category": "Technology",
      "readTime": "8 min read",
      "publishedAt": "2 hours ago",
      "views": 1240,
      "image": "https://picsum.photos/300/200?random=5&keyword=quantum"
    },
    {
      "title": "Sustainable Business Practices",
      "author": "Lisa Rodriguez",
      "category": "Business",
      "readTime": "6 min read",
      "publishedAt": "4 hours ago",
      "views": 856,
      "image": "https://picsum.photos/300/200?random=6&keyword=sustainability"
    },
    {
      "title": "Mental Health in the Digital Age",
      "author": "Dr. Amanda Kim",
      "category": "Health",
      "readTime": "10 min read",
      "publishedAt": "6 hours ago",
      "views": 2100,
      "image": "https://picsum.photos/300/200?random=7&keyword=mental-health"
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Search
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(10)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Explore Categories",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Discover articles across different topics",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(Icons.category, color: primaryColor, size: 32),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: disabledBoldColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search categories, topics, authors...",
                              hintStyle: TextStyle(color: disabledColor),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(Icons.tune, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Categories Grid
            Text(
              "Browse Categories",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ResponsiveGridView(
              minItemWidth: 200,
              children: categories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              category["icon"],
                              color: category["color"],
                              size: 28,
                            ),
                          ),
                          Spacer(),
                          if (category["trending"]) ...[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.trending_up, color: warningColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Trending",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${category["count"]} articles",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Explore",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spXl),

            // Trending Topics
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: trendingTopics.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> topic = entry.value;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: index < trendingTopics.length - 1
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: index < 3 ? primaryColor : disabledColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: index < 3 ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${topic["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${topic["articles"]} articles",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.trending_up, color: successColor, size: 20),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spXl),

            // Featured Authors
            Text(
              "Featured Authors",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: featuredAuthors.map((author) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage("${author["image"]}"),
                          ),
                          if (author["verified"]) ...[
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(Icons.check, color: Colors.white, size: 12),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${author["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${author["expertise"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${author["articles"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Articles",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${((author["followers"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Follow",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spXl),

            // Recent Articles
            Row(
              children: [
                Text(
                  "Recently Published",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            Column(
              children: recentArticles.map((article) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${article["image"]}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${article["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
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
                              SizedBox(height: spXs),
                              Text(
                                "${article["author"]} • ${article["readTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: disabledColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["publishedAt"]}",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.visibility, color: disabledColor, size: 12),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["views"]}",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Icon(Icons.arrow_forward_ios, color: disabledColor, size: 16),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
