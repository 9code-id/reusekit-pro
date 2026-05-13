import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle4View extends StatefulWidget {
  @override
  State<GrlArticle4View> createState() => _GrlArticle4ViewState();
}

class _GrlArticle4ViewState extends State<GrlArticle4View> {
  List<Map<String, dynamic>> articles = [
    {
      "id": 1,
      "title": "The Future of Technology",
      "category": "Technology",
      "author": "Dr. Sarah Johnson",
      "date": "2024-12-15",
      "readTime": "8 min read",
      "image": "https://picsum.photos/400/250?random=1&keyword=technology",
      "summary": "Exploring emerging technologies that will shape our future including AI, quantum computing, and biotechnology.",
      "views": 15240,
      "likes": 892,
      "featured": true,
    },
    {
      "id": 2,
      "title": "Climate Change Solutions",
      "category": "Environment",
      "author": "Prof. Michael Chen",
      "date": "2024-12-14",
      "readTime": "12 min read",
      "image": "https://picsum.photos/400/250?random=2&keyword=environment",
      "summary": "Innovative approaches to combat climate change through renewable energy and sustainable practices.",
      "views": 23150,
      "likes": 1456,
      "featured": true,
    },
    {
      "id": 3,
      "title": "Digital Marketing Trends",
      "category": "Marketing",
      "author": "Lisa Rodriguez",
      "date": "2024-12-13",
      "readTime": "6 min read",
      "image": "https://picsum.photos/400/250?random=3&keyword=marketing",
      "summary": "Latest trends in digital marketing including social commerce and AI-powered personalization.",
      "views": 9870,
      "likes": 634,
      "featured": false,
    },
    {
      "id": 4,
      "title": "Health & Wellness Guide",
      "category": "Health",
      "author": "Dr. Amanda Kim",
      "date": "2024-12-12",
      "readTime": "10 min read",
      "image": "https://picsum.photos/400/250?random=4&keyword=health",
      "summary": "Comprehensive guide to maintaining physical and mental wellness in modern lifestyle.",
      "views": 18500,
      "likes": 1123,
      "featured": false,
    },
    {
      "id": 5,
      "title": "Startup Success Stories",
      "category": "Business",
      "author": "James Wilson",
      "date": "2024-12-11",
      "readTime": "15 min read",
      "image": "https://picsum.photos/400/250?random=5&keyword=business",
      "summary": "Inspiring stories of successful startups and the lessons they learned along the way.",
      "views": 12900,
      "likes": 758,
      "featured": false,
    },
  ];

  List<String> categories = ["All", "Technology", "Environment", "Marketing", "Health", "Business"];
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredArticles {
    return articles.where((article) {
      bool categoryMatch = selectedCategory == "All" || article["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
        article["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        article["author"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Knowledge Hub",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Discover insights from industry experts",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: Colors.white.withAlpha(60)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.white, size: 20),
                              SizedBox(width: spXs),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Search articles...",
                                    hintStyle: TextStyle(color: Colors.white.withAlpha(180)),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    searchQuery = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white.withAlpha(60)),
                        ),
                        child: Icon(Icons.filter_list, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Category Filter
            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Featured Articles
            if (filteredArticles.where((article) => article["featured"] == true).isNotEmpty) ...[
              Text(
                "Featured Articles",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QHorizontalScroll(
                children: filteredArticles.where((article) => article["featured"] == true).map((article) {
                  return Container(
                    width: 320,
                    margin: EdgeInsets.only(right: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                              child: Image.network(
                                "${article["image"]}",
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${article["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(Icons.bookmark_border, color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${article["title"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${article["summary"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(Icons.person, color: disabledColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["author"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${article["readTime"]}",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(Icons.visibility, color: disabledColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(article["views"] as int).toString()}",
                                    style: TextStyle(color: disabledColor, fontSize: 12),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(Icons.favorite_border, color: disabledColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(article["likes"] as int).toString()}",
                                    style: TextStyle(color: disabledColor, fontSize: 12),
                                  ),
                                  Spacer(),
                                  QButton(
                                    label: "Read More",
                                    size: bs.sm,
                                    onPressed: () {},
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
              SizedBox(height: spXl),
            ],

            // All Articles
            Row(
              children: [
                Text(
                  "Latest Articles",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredArticles.length} articles",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            Column(
              children: filteredArticles.map((article) {
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
                          width: 120,
                          height: 120,
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
                                  color: primaryColor.withAlpha(40),
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
                                  fontSize: 16,
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
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Icon(Icons.visibility, color: disabledColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(article["views"] as int).toString()}",
                                    style: TextStyle(color: disabledColor, fontSize: 11),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.favorite_border, color: disabledColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(article["likes"] as int).toString()}",
                                    style: TextStyle(color: disabledColor, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Icon(Icons.bookmark_border, color: disabledColor, size: 20),
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
